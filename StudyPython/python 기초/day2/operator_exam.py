# 연산자

from pickletools import string1

a = 11
b = 4
print(a+b)
print(a -b)
print(a/b)
print(a % b )
print(a // b)

# 문자열 연산

stat1 = 'Hello'
stat2 = 'World'
res = stat1 + stat2
print(res)

res = stat1, stat2
print(res)

# 문자열 연산에는 +, * 만 있음

print(stat1 + stat2)
# print(stat1 - stat2)
print(stat1 * 5)

# 문자열에는 빼기가 없음

## print(stat1 - stat2) 

# 문자열 나누기 없음

## print(stat1 / 3) 

# 문자열끼리 곱하기 없음
## print(stat1 * stat2) 

# len() : 문자열 길이

print(len(stat1))

stat3 = '안녕하세요'
print(len(stat3))

# 문자열 인덱스, 리스트와 동일한 작업

# 변수[숫자] : 인덱스(숫자 번째 글자 출력)

## 첫글자는 0번째이다.

# print(stat3[0])
# print(stat3[1])
# print(stat3[2])
# print(stat3[3])
# print(stat3[4])
#print(stat3[5])

#stat3[0] = '저'
#stat3[1] = '리'
#print(stat3)

# 변수[-1] : 뒤에서 첫번째 문자

print(stat3[-1])
print(stat3[-2])
print(stat3[-3])
print(stat3[-4])
print(stat3[-5])

# 변수[0:?] : 문자열 자르기

일시 = '2022-01-17 14:39:25'

# 시작은 '0'을 생략해도 된다

print(일시[:4],'년') 
print(일시[5:7],'월')
print(일시[8:10],'일')
print(일시[11:13],'시')
print(일시[14:16],'분')

# 끝은 마지막 번호를 생략해도 된다

print(일시[17:],'초') 

print(일시[-5:-3], '분')

# 변수 = [] : 리스트

# [] : 리스트에서는 앞서 할당된 값을 수정할 수 없다.

list_a = [1,2,3,4,5]
list_a[1] = 19
print(list_a)

print(stat3)
stat4 = '저리가' + stat3[3:]
print(stat4)

# {0}.fromat(문자) : 문자열 포맷팅

## 숫자는 안됨

str1 = "I'm so happy {0} U".format('to')
print(str1)

str1 = "I'm so happy {0} U. are {1}?".format('to', 'You')

# 
첫번째 = '투'
두번째 = '유'

str1 = "I'm so happy {0} U. are {1}?".format(첫번째, 두번째)
print(str1)

# f"...{}..." : 문자열 포맷팅 생략형
str2 = f"I'm so happy {첫번째} U. are {두번째}?"
print(str2)

# format(... , ',d') : 천단위 마다 쉼표 출력

money = 100000000000000000000
print(format(money, ',d'))

from datetime import datetime

now = datetime.now() # 현재 일시
print(now)

## strftime(...) : 양식

print(now.strftime('%Y년 %m월 %d일 %H:%M:%S'))

## 

import math

myPi = math.pi
print(myPi)

print('{0}'.format(myPi))
print('{0:0.2f}'.format(myPi))
print(f'{myPi:0.6f}')

full_name = 'Hugo MG Sung'
age = 47
greeting = f'''안녕하세요. 저는 {full_name}입니다.
나이는 {age:0.1f}살 이구요.'''

print(greeting)

# split() : 분할

## () : 띄어쓰기 기준으로 분할

part_name = full_name.split()
print(type(part_name))
print(part_name)

# split(',') : 쉼표기준으로 분할

test = 'Hey, guys'
print(test.split(','))

# |
 
code = 'TEST|2022|01|17|F45678'
split_codes = code.split('|')
print(split_codes)

code = 'TEST|2022|01|17|F45678'
print(code.split('|'))

# .replace() : 단어교체

print(full_name.replace('Hugo MG', 'Ashely'))

# .strip() : 공백 삭제 / Oracle 에서 trim 명령어와 동일
## .lstrip() : 왼쪽 공백 삭제
### .rstirp() : 오른쪽 공백 삭제

aaa = '      Hello, World     '
print(aaa.rstrip())

# .index() : 문자열이 자리한 위치를 숫자로 출력

print(full_name.index('H')) # 0
print(full_name.index('u')) # 1
print(full_name.index('g')) # 2
print(full_name.index('G')) # 6
# print(full_name.index('X')) # not found

# .find() : 
## 문자열이 자리한 위치를 숫자로 출력하되 없는 문자는 -1로 출력
### 두글자 이상을 찾을 때는 맨 앞 글자 위치의 숫자가 출력

print(full_name.find('X'))
print(full_name.find('MG'))

# .count() : 찾는 문자의 개수

print(full_name.count('u'))
print(full_name.count('n'))

# .join() 

print('-'.join(full_name))

# .upper()
# .lower()

print(full_name.upper())
print(full_name.lower())

