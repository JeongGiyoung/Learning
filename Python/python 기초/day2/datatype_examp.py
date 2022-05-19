# 자료형
print(None)
print(type(None))

print( 0 == None)
a = None
print(a)
print(type(a))

# 숫자형

금액 = 12_234_666
print(금액)

# 문자열

bruce_eckel = 'Life is short. You need Python'
print(bruce_eckel)

# \n (New Line): 문자열 줄 띄우기

bruce_eckel = 'Life is short.\nYou need Python.'
print(bruce_eckel)

# \\ : \를 문자열로 표현하고 싶을 때

bruce_eckel = 'Life is short.\\You need Python.'
print(bruce_eckel)

# ''' (트리플 코테이션) : 여러줄 작성

bruce_eckel = '''Life is short.
You need Python.
난 필요없는데... 파이썬'''

print(bruce_eckel)

# 불형

val_sum = 1000
print(val_sum == 1000)
print(val_sum == 999)

# print(val_sum = 10) : 같은 변수에 다른 값을 할당할 수 없다.

bl_true = True
print(type(bl_true))

print(bl_true == True) # True
print(bl_true is True) # True

print(a is None) # True

print(val_sum is 1000) # True

# 의미가 있는 bool

print(bool(1)) # True
print(bool(0)) # False

# list (리스트)

b = [1,2,3,4,5,6,7,8,9,10]
print(b)

arr2 = ['Life', 'is', 'short', 'U', 'need', 'Python', 3]
print(arr2)

arr3 = [[1,2,3], [4,5,6]]
print(arr3)

# 빈 리스트 생성

arr4 = list()
print(arr4)

# 튜플
tuple1 = (1,2,3,4,5)
print(tuple1) 

# {A : a, B:b, ---} : 딕셔너리

spiderman = {'name' : '피터 파커',
            'age' : 18,
            'weapon' : '웹슈터'}
print(spiderman)

# set() : 집합(중복값은 제거)

set_int = set([1,2,3,4,5,6,7,1,2,2])
print(set_int)