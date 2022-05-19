# 변수 : 파이선의 변수에는 제약이 거의 없다.

from re import A


a = '헬로우'
print(a)

a = 3.141592
print(a)

a = 10
print(a)

a=999999999999999999999999999999999999999
print(a)

a=1/10
print(a)

# 변수값을 지정(할당) - assgin 방법

a = 3
# Left Value = Right Value
## 데이터를 담을 값은 Left Value에만 와야 한다.
### 예) 3 = a : 불가능

b = 3.141592
c = 'python'
d = (1,2,3) # 튜플
e = [1, 2, 3, 4] # 리스트
f = [7,'8', '$', a] # 파이썬의 장점

# 변수명 지정 불가


val = 10
val2 = 20
val4 = 30

# 4val = 40 변수명은 '문자'(숫자X)로 시작해야 한다.
# _ (언더바)만 된다.

val_of_change = 99
chain_reation = 108
chanReaction = 109

# val- = 111
# val$ = 99

val_ = 999
Val_ = 9080

print(val_)
print(Val_)

MyAccountOfBank = 1
은행계좌금액 = 1

print(id(val_))
print(id(Val_))

# type() : 변수타입 확인

print(type(val_)) # int
print(type(c)) # str
print(type(d)) # tuple
print(type(e)) # list
print(type(f)) # list
print(type(b)) # float

