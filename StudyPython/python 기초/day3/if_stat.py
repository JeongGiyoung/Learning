# if 구문 - 흐름제어

## 들여쓰기(탭) 통일이 필수

name = '기영'

if name == '기영' :
    print('의사를 만나러 갑니다.')
    print('의사쌤한테 인사합니다.')
elif name == '다원' :
    print('주사실로 갑니다.')
else : 
    print('호출할 때까지 대기합니다.')

name = ['명건', '태경', '기영', '광조']

# if name == '기영' or name == '태경' :

## if ... in ...

print('')
print('if ... in ...')

if '길동' in name :
    print('의사쌤한테 인사합니다.')
elif name == '다원' :
    print('주사실로 갑니다.')
else : 
    print('호출할 때까지 대기합니다.')

# () : 튜플 

print('')
print('<    () : 튜플   >')

name = ('명건', '태경', '기영', '광조')

if '길동' in name :
    print('의사를 만나러 갑니다.')
    print('의사쌤한테 인사합니다.')
elif name == '다원' :
    print('주사실로 갑니다.')
else : 
    print('호출할 때까지 대기합니다.')

# if 문을 unless 문처럼 사용하려면

print('')
print('<    if 문을 unless 문처럼 사용하려면    >')

x = 10
if x != 10 :
    pass
else : 
    pass