from flask import Flask, render_template, jsonify, request
from ml import lang_detect_ml
# render_template은 html을 읽어서 사용자가 넣은 데이터를 믹스해서
# 원하는 화면을 동적으로 만들어서 돌려주는 함수이다
# 이런 작업 => 서버에서 html을 동적으로 만들어서 랜더링 하는 방식 : 
# SSR(Server Side Rendering)
# 이런 작업은 템플릿 엔진을 통해서 데이터를 믹스 할수 있는데 파이썬은
# JinJa 엔진을 사용한다 -> html에 데이터를 믹스하는 엔진(템플릿엔진)


app = Flask(__name__)

@app.route('/')
def home(): 
    name = '안녕'
    return render_template('index.html', key=name)

@app.route('/lang_detect', methods=['POST','GET'])
def lang_detect(): 
    if request.method == 'POST':
        # 1. 사용자가 보낸 말뭉치 획득
        # post로 보내면 아래처럼 데이터를 추출한다
        ori_src = request.form.get('ori_src')
        #print( ori_src )

        # 2. 말뭉치를 머신러닝 모델이 언어를 감지하여 결과를 돌려주는
        #    함수를 호출할때 전달한다
        code, na = lang_detect_ml( ori_src )

        res = {
            'code':code,
            'ko':na
        }
        return jsonify( res )
    else:        
        ori_text = '''
            The Yankee was one of America's first cultural publications and a precursor to the independent American press that formed decades later. Founded and edited by John Neal (pictured), it was published in Portland, Maine, between 1828 and 1829. The magazine helped establish the American gymnastics movement, covered national politics, and critiqued American literature, art, theater, and social issues. Many new, predominantly female, writers and editors started their careers with publication and coverage in The Yankee, including many who are familiar to modern readers. Essays by Neal on American art and theater anticipated major changes and movements realized in the following decades. His articles on women's rights and early feminist ideas affirmed intellectual equality between men and women and demanded political and economic rights for women, saying "If woman would act with woman, there would be a stop to our tyranny".
        '''
        lang_detect_ml( ori_text )
        return ''

if __name__ == '__main__':
    app.run(debug=True)