# exception_handle.py

# 예외처림! 가장 중요!

# try : 
# except :  

""" def add(a,b) :
    return a + b

def minus(a,b) :
    return a - b

def multi(a,b) :
    return a * b

def divide(a,b) :
    return a / b

print('사칙연산 시작')

a, b = 4, 0

try :
    print(f'나누기 결과 : {divide(a,b)}')
# 어떠한 상황에서 예외가 발생할 수 있는지 예시를 보여주는 명령문
# except Exception as e :  
#     print(f'예외발생! {e}')
except ZeroDivisionError as e:
    print(f'예외발생! {e}')

print(f'곱하기기 결과 : {multi(a,b)}')
print(f'빼기 결과 : {minus(a,b)}')
print(f'더하기 결과 : {add(a,b)}')

print('사칙연산 종료') """

# 각 예외별로 다른 대처를 해야할 경우 각 예외별 명령문을 각각 적는다.

""" def add(a,b) :
    return a + b

def minus(a,b) :
    return a - b

def multi(a,b) :
    return a * b

def divide(a,b) :
    return a / b

print('사칙연산 시작')

a, b = 4, 0

try :
    print(f'나누기 결과 : {divide(a,b)}')
    print(f'곱하기기 결과 : {multi(a,b)}')
    print(f'빼기 결과 : {minus(a,b)}')
    print(f'더하기 결과 : {add(a,b)}')
except ZeroDivisionError as e:
    print(f'나누기 예외. 추가처리1 {e}')
except IndexError as e :
    print(f'인덱스 에외. 추가처리2 {e}')
except Exception as e :
    print(f'알 수 없는 예외. 추가처리 5 {e}')

print('사칙연산 종료') """

# 예외를 모두 try 명령문 사이로 두면 예외가 한 개 발생하면 그 이후 명령문으로 진행되지 않는다. 그래서 예외가 발생할 명령문에만 try 명령문에 포함시키는 게 좋다.

""" def add(a,b) :
    return a + b

def minus(a,b) :
    return a - b

def multi(a,b) :
    return a * b

def divide(a,b) :
    return a / b

print('사칙연산 시작')

a, b = 4, 1
numbers = [3,6,9] # 리스트 생성

try :
    print(f'나누기 결과 : {divide(a,b)}')
    res = int(numbers[3]) * 8
except ZeroDivisionError as e:
    print(f'나누기 예외. 추가처리1 {e}')
except IndexError as e :
    print(f'인덱스 에외. 추가처리2 {e}')
except Exception as e :
    print(f'알 수 없는 예외. 추가처리 5 {e}')

finally : # 예외 발생 여부와 상관없이 결과 출력. 반드시 실행해야 하는 close() 명령문에 잘 쓰인다.
    print(f'곱하기기 결과 : {multi(a,b)}')
    print(f'빼기 결과 : {minus(a,b)}')
    print(f'더하기 결과 : {add(a,b)}')

print('사칙연산 종료') """

# 그럼 모든 try, except를 적어두는 게 좋지 않나 생각할 수 있지만, 그렇게 되면 이 연산의 성능이 떨어진다.

""" def add(a,b) :
    return a + b

def minus(a,b) :
    return a - b

def multi(a,b) :
    return a * b

def divide(a,b) :
    return a / b

print('사칙연산 시작')

a, b = 4, 1
numbers = [3,6,9] # 리스트 생성

try :
    print(f'나누기 결과 : {divide(a,b)}')
    res = int(numbers[1]) * 8
    num = int(input('수를 입력하세요'))
    
except ZeroDivisionError as e:
    print(f'나누기 예외. 추가처리1 {e}')
except IndexError as e :
    print(f'인덱스 에외. 추가처리2 {e}')
except ValueError as e :
    print(f'제발! 쫌 숫자만 넣으라고!! {e}')
except Exception as e :
    print(f'알 수 없는 예외. 추가처리 5 {e}')

finally : 
    print(f'곱하기기 결과 : {multi(a,b)}')
    print(f'빼기 결과 : {minus(a,b)}')
    print(f'더하기 결과 : {add(a,b)}')

print('사칙연산 종료') """

# F5 : 디버깅 시작
# F9 : 브레이크 포인트
# F10 : 브레이크 포인트에서 함수로 돌아가지 않고, 그 다음 줄 시작 대기 
# F11 : 함수가 포함되어 있는 줄에서 함수로 진입

def add(a,b) :
    return a + b

def minus(a,b) :
    return a - b

def multi(a,b) :
    return a * b

def divide(a,b) :
    res = a / b
    return res

print('사칙연산 시작')

a, b = 4, 1
numbers = [3,6,9] # 리스트 생성

try :
    print(f'나누기 결과 : {divide(a,b)}')
    res = int(numbers[1]) * 8
    num = int(input('수를 입력하세요'))
    
except ZeroDivisionError as e:
    print(f'나누기 예외. 추가처리1 {e}')
except IndexError as e :
    print(f'인덱스 에외. 추가처리2 {e}')
except ValueError as e :
    print(f'제발! 쫌 숫자만 넣으라고!!')
except Exception as e :
    print(f'알 수 없는 예외. 추가처리 5 {e}')

finally : 
    print(f'곱하기기 결과 : {multi(a,b)}')
    print(f'빼기 결과 : {minus(a,b)}')
    print(f'더하기 결과 : {add(a,b)}')

print('사칙연산 종료')