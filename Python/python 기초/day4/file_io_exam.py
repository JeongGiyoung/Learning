# 파일을 가져오는 것은 input, 파일에 데이터를 수정하면 output

# 파일 입출력

# 파일출력

## f=open 한 다음에는 반드시 close() 해야된다.

# 기본 파이썬 폴더에 파일을 생성하는 방법

""" f = open('newfile.txt', 'w')
f.close()

# 특정 경로에 파일 생성하는 방법

f = open(f'C:\\Sources\\Sample\\test2.txt', 'w')
f.close()
print('파일이 생성되었습니다.') """

# 인코딩
## 영어 : ascii
## 한글 : cp949
## 중국어 포함 모든 언어 : utf-8

# newfile.txt 파일입력(읽어오기)

## 파일 읽어오기

from xmlrpc.client import INVALID_ENCODING_CHAR


""" f = open('newfile.txt', 'r', encoding='utf-8')
while True :
    line = f.readline() # 연 파일을 1줄씩 읽는 명령어
    if not line : # 'line에 어떠한 내용도 없을 때'라는 조건
        break
    print(line)

f.close() """

#
f = open('newfile.txt', 'r', encoding='utf-8')

for line in f :
    print(line.replace('\n'))

f.clsoe()