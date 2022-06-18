""" # 웹페이지 긁어오기

## 네이버 웹페이지 요청

### 웹페이지의 뜻 : request 에 대한 response

from urllib.request import Request, urlopen

req = Request('http://www.naver.com')
res = urlopen(req)

print(res.status) # 값이 '200'이 나오면 페이지를 찾았다는 뜻 """

# 외부 request 패키지 추가 설치
# pip install requests

from lib2to3.pgen2.pgen import DFAState
import requests 
url = 'http://www.naver.com'
res = requests.get(url)

# print(res.status_code)
print(res.text)
