# 리스트 연산

# range(5) : 0부터 5까지

arr = list(range(5))
print(arr)

# range(... , ...) : 어디부터 어디까지

## 1부터 5까지 
arr = list(range(1,6))
print(arr)

# range(... , ... , **) 증가량 수정

arr = list(range(2, 101, 2))
print(arr)

# 색인을 이용해 계산을 쉽게 하는 방법

print(arr[0] + arr[5])

# print(...[..][..]) : 2차원 배열(리스트)

arr2 = [1,2,['Hi', 'My', 'Friends']]
print()
print(arr2[0])
print(arr2[2])
print(arr2[2][1])
print(arr2[2][1][0])

arr3 = list(range(1,4))
print(arr3)
print(arr3 * 3)

# print(arr3 + 3)

print(arr3 + arr)

print(len(arr))

# 리스트 함수

# del() : 인데스로 찾아서 삭제하기

print('-- 리스트 내장함수')
del(arr3[1])
print(arr3)

# .remove : 값을 지울 때

arr3.remove(1)
print(arr3)

# .remove() : 리스트에서 최초 해당 문자 삭제

arr4 = [4, 2, 6, 9, 12, 16, 7, 1, 3, 3, 5]

# 값을 찾아서 삭제

arr4.remove(3) 
print(arr4)

# 리스트 인덱스로 삭제

del(arr4[8]) 
print(arr4)

# .sort() : 오름차순

arr4.sort()
print(arr4)

# .reverse() : 내림차순

arr4.reverse()
print(arr4)

# .insert(... , ...)

arr4.insert(2, 10)
print(arr4)

# tuple()

tup1 = tuple(range(1,6))
print(tup1)

# tuple()은 수정 불가능

## tup1[0] = 99
## print(tup1)

# {... : ...} : (딕션너리) 키, 값을 지정. 

dic1 = {1 : 'a'}
dic1[2] = 'b'
print(dic1)

# 딕션너리를 이용해 언제든지 값을 추가하거나 삭제하고 싶을 때

dic1['name'] = 'Hugo'
print(dic1)

del dic1['name']
print(dic1)

print(dic1.keys())
print(dic1.values())
print(dic1.items())

# 리스트를 튜플로 변환

print('--리스트/튜플 변환')
print(arr4)
tup2 = tuple(arr4) # 튜플로 변화
print(tup2)

arr4.sort()

print(tup1)
arr5 = list(tup1)
print(arr5)
arr5.append(6)
print(arr5)
tup1 = tuple(arr5)
print(tup1)
