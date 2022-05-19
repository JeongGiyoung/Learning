# 변수 라이프스코프

a = 1 # 전역변수(global)

def vartest(a) : # 지역변수(이 def 함수에서만 쓰인다) : 3 번째 줄에 a와 다른 값
    a = a + 1
    return a

a = vartest(a)
print(a)

#

a = 1 # 전역변수(global)

def vartest(x) : # 지역변수(이 def 함수에서만 쓰인다) : 3 번째 줄에 a와 다른 값
    x = x + 1
    return x

a = vartest(a)
print(a)
# print(x)

#

a = 1 # 전역변수(global)
res = 0

def vartest(x) : # 지역변수(local, 이 def 함수에서만 쓰인다) : 3 번째 줄에 a와 다른 값
    x = x + 1
    return x

res = vartest(a)
print(res)