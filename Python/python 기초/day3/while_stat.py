# while

## for 와 차이 : while은 조건이 참인 동안에 반복

hit = 0

while hit < 10 :
    hit = hit + 1

    print(f'나무를 {hit}번 찍습니다.')

# += 사용법

hit = 0

while hit < 100 :
    hit += 1
    
    if hit > 99 :
        break

    print(f'나무를 {hit}번 찍습니다.')

# while을 for문으로 바꾸기

for hit in range(0,100) :
    if hit > 9 :
        break

    print(f'나무를 {hit+1}번 찍습니다.')

    