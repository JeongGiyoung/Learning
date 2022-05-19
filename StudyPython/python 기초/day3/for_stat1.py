""" # for : 반복

print('')
print('<    for : 반복      >')

# i는 item의 약자

arr = [1,2,3,4,5]

for i in arr :
    print(f'{i:2.1f}')

# list(range(... , ...))

print('')
print('<    for문에서  >')
print('<    list(range(... , ...))  >')

arr = list(range(1,10))

for i in arr :
    print(f'{i:2.1f}')

# 튜플로 for문
# :>10 // fomat에서 오른쪽 정렬

print('')
print('<    튜플로 for문    >')
print('<    :>10 // fomat에서 오른쪽 정렬    >')

arr2 = ('me', 'my', 'friend', 'jane')

for item in arr2 :
    print(f'{item:>10}') """


""" # 합계 for 문
# res += item
# f'{}' 문

print('')
print('<    합계 for 문 >')
print('<    += >')
print('<    f' ' 문 >')

numbers = list(range(1, 21))
res = 0

for item in numbers :
    res += item

print(f'{numbers[-1]} 까지의 총 합은 {res} 입니다.')

# 1에서 20까지 홀수 합계

print('')
print('<1에서 20까지 홀수 합계>')

numbers = list(range(1, 21, 2))
res = 0

for item in numbers :
    res += item

print(f'{numbers[0]} 에서 {numbers[-1]} 까지의 총 합은 {res} 입니다.') """

""" # % 2 == 0 : 짝수 표현
print('')
print('<    % 2 == 0 : 짝수 표현    >')

numbers = list(range(1, 21))

for item in numbers :
    if item % 2 == 0 : # 짝수
        print(f'{item}은 짝수')

# % 2 != 0 : 홀수 표현
print('')
print('<    % 2 != 0 : 홀수 표현    >')

numbers = list(range(1, 21))

for item in numbers :
    if item % 2 != 0 : # 홀수 혹은 item % 2 == 1
        print(f'{item}은 홀수') """

""" # break : 주어진 조건에 따라 진행을 더이상 하지 않고 그 다음 명령문으로 넘어간다.

# 13이상이면 탈출(break) 또는 계속(continue)

## break문은 for문 바로 아래 써서 사용하는 게 좋다.

print('')
print('<    break 문    >')

numbers = list(range(1, 21))

for item in numbers :
    if item > 12 :
        break
    
    if item % 2 != 0 : 
        print(f'{item}은 홀수')

# cotinue : 

print('')
print('<    cotinue 문    >')

numbers = list(range(1, 21))

for item in numbers :
    if item == 15 :
        continue
    
    if item % 2 != 0 : 
        print(f'{item}은 홀수') """

""" # 구구단
# 구분해서 출력하는 방법
# end=''

print('구구단 프로그램')
for i in range(2, 10) : # 2~9단 
    print(f'{i}단 시작')
    print('')
    for j in range(1, 10) : # 1~9를 곱해야 되기 때문
        print(f'{i} x {j} = {i * j:2d}',end=',   ')
    print('')
    print('')
    print('')

# end를 안쓰는 경우

print('구구단 프로그램')
for i in range(2, 10) : # 2~9단 
    print(f'{i}단 시작')
    print('')
    for j in range(1, 10) : # 1~9를 곱해야 되기 때문
        print(f'{i} x {j} = {i * j:2d}')
    print('')
    print('')
    print('')

# 구구단에서 break 사용하는 방법

print('구구단 프로그램')
for i in range(2, 10) : # 2~9단 
    print(f'{i}단 시작')
    print('')
    if i == 7 :
        break
    for j in range(1, 10) : # 1~9를 곱해야 되기 때문
        print(f'{i} x {j} = {i * j:2d}', end='   ')        
    print('')
    print('')
    print('') """

# for 활용

a = [1,2,3,4]
result = [i * 3 for i in a]
print(result)

t = []
for i in a :
    t.append(i*3)
print(t)

