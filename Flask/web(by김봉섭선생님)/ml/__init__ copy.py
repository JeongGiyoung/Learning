# 특정 폴더 밑에 모듈(*.py)이 위치하면
# 해당 폴더는 패키지라고 부른다
# 패키지를 대변하는 모듈은 __init__.py이다
# 이 파일은 생략 가능하다
PI = 3.14
########################################
# 머신러닝 모듈 로드, 데이터 전처리, 예측, 번역

def load():
    pass
def preprocessing():
    pass
def predict():
    pass
def trans():
    pass

# 말뭉치를 받아서, 전처리후, 모델로드해서, 예측하고 응답
def lang_detect_ml( ori_text ):
    # 1. 말뭉치 획득
    print( ori_text[:100] )
    # 2. 전처리 -> [ [a빈도, b빈도, .... ,z빈도] ]
    # 3. 모델로드
    # 4. 예측수행
        # 4-1 예측
        # 4-2 번역요청(파파고 api 연동)
    # 5. 결과리턴
    pass

if __name__ == '__main__':
    # 단위 테스트용
    lang_detect_ml()

