import re
import joblib
# 말뭉치 -> 전처리 -> 학습에 적합하도록 변형 -> 모델로드
# -> 데이터를 모델에 주입하여 예측 -> 결과 리턴 
def lang_detect_ml( ori_text ):
    print( ori_text[:100] )    
    # 1. 말뭉치 -> 전처리
    text      = ori_text.lower()            # 소문자 처리
    p         = re.compile( '[^a-z]*' )     # 정규식 정의
    text      = p.sub( '' , text ).lower()  # 정규식을 이용하여 전처리
    print( text[:100] )
    
    # 2. 학습에 적합하도록 변형
    STD_INDEX       = ord('a')              
    cnts            = [0]*26
    for ch in text:        
        index           = ord(ch) - STD_INDEX
        cnts[ index ]  += 1
    total_count     = sum( cnts)
    cnt_norms       = list( map( lambda x: x/total_count, cnts ) ) 

    # 사전 학습된 머신러닝 기반 모델을 서비스에 적용한 위치 ---------
    # 3. 모델로드
    #    파일 위치는 워크스테이션 기준으로 체크되므로
    #    나중에는 os 모둘을 이용하여서 경로를 잡는다
    clf = joblib.load('./model/lang_clf.model')
    # 4. 예측
    y_pred = clf.predict( [cnt_norms] )
    # 5. 결과 확인
    print( y_pred )
    # ------------------------------------------------------------
    # 6. 정답표 로드
    labels = joblib.load('./model/lang.label')
    print( y_pred[0], labels[ y_pred[0] ] )
    
    # 7. 리턴
    return y_pred[0], labels[ y_pred[0] ]
    

if __name__ == '__main__':
    lang_detect_ml()

