'''
    - flask 기반 웹서비스 엔트리 포인트 파일
    - 모든 경로법은 엔트리 포인트 기준으로 계산된다
        - 모듈의 경로
'''
# TODO 모듈 가져오기
from flask import Flask, render_template

# TODO Flask 객체 생성
app = Flask(__name__)

# TODO 라우팅 : 서버측으로 특정 url로 요청이 들어오면 
#      어떤 함수가 처리할지 연결해주는 역활
# 데코레이터 
@app.route('/')
def home(): 
    # render_template는 templates 하위를 찾아서 랜더링 한다
    return render_template('index.html')

# TODO 서버 가동 : run.py를 직접 구동시킬때만, 가동한다
#      만약, 다른 모듈이 run.py을 가져와서 사용한다면
#      __name__는 'run(파일이름)'으로 값이 세팅된다
if __name__ == '__main__': # 직접 구동했다면 
    # 서버 가동, 디버깅 모드로
    app.run(debug=True)
