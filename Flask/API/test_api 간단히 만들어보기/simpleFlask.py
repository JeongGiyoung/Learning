#!/usr/bin/env python
# coding: utf-8

# # # 출처
#   * https://rekt77.tistory.com/103

# In[1]:


from flask import Flask
app = Flask (__name__)
 
@app.route('/')
# URL의 / 경로를 요청하면 하위에 기재된 코드를 실행하는 것 입니다.
# 이 함수에서는 Hello, World!를 리턴하기 때문에 Hello, World!가 출력되는 것입니다.
# 이런식으로 경로를 설정하여 다른동작을 하게 하는것을 라우팅이라고 합니다.

def hello_world():
    return 'Hello, World!'

@app.route('/user/<userName>') # URL뒤에 <>을 이용해 가변 경로를 적는다
# 추가적으로 라우팅 함수는 URL을 변수로 받아와서 처리하게 구현할 수 도 있습니다.
## hello_user를 보시면 라우팅 데코레이터에 <userName>이라는게 들어 있는걸 볼 수 있습니다. 이는 가변 경로에 대해 그 값을 변수로 사용하겠다는 의미입니다. 이러한 가변 경로를 변수로 사용하기 위해서는 hello_user의 인자 값으로 만들어 줘야하기 때문에 인자에 userName이 들어가 있는 것 입니다.
def hello_user(userName):
    return f'Hello, {userName}'
 
if __name__ == "__main__":
    app.run()


# In[ ]:




