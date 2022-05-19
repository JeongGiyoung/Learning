from flask import Flask, render_template, jsonify, request
from ml import lang_detect_ml

app = Flask(__name__)

@app.route('/')
def home(): 
    return render_template('index.html')

# 라우팅할때 method를 지정하지 않으면 무조건 get방식이다
@app.route('/lang_detect', methods=['POST','GET'])
def lang_detect(): 
    if request.method == 'POST':
        # 더미 데이터로 바로 응답
        # 일단 특정값으로만 응답하게 구성하겟다,
        # 차후 머신러닝 모듈이 붙으면 그때 기능 테스트를 진행하는것으로
        res = {
            'code':'en',
            'ko':'영어'
        }
        # dict => json으로 처리하는 함수
        return jsonify( res )

    else: # get
        # 1. 클라이언트가 보낸 말뭉치를 획득, 여기서는 기본세팅
        ori_text = '''
            The Yankee was one of America's first cultural publications and a precursor to the independent American press that formed decades later. Founded and edited by John Neal (pictured), it was published in Portland, Maine, between 1828 and 1829. The magazine helped establish the American gymnastics movement, covered national politics, and critiqued American literature, art, theater, and social issues. Many new, predominantly female, writers and editors started their careers with publication and coverage in The Yankee, including many who are familiar to modern readers. Essays by Neal on American art and theater anticipated major changes and movements realized in the following decades. His articles on women's rights and early feminist ideas affirmed intellectual equality between men and women and demanded political and economic rights for women, saying "If woman would act with woman, there would be a stop to our tyranny".
        '''
        # 2. 말뭉치를 예측 모델에 사용할수 있도록 전처리 
        #    => [ [10,23,..,10] ]
        # 3. 머신러닝 모델 로드
        # 4. 예측 수행
        lang_detect_ml( ori_text )
        # 5. 응답 데이터 구성
        # 6. 응답
        return ''

if __name__ == '__main__':
    app.run(debug=True)