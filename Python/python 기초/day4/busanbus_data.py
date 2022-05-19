# 부산 버스 노선별 이용 건수

import csv

file_name = '부산버스정보.csv'
f = open('부산버스정보.csv', mode='r', encoding='utf-8')

reader = csv.reader(f, delimiter=',')  # delimiter 는 구분자. 보통은 쉼표

next(reader) # 헤더(파일의 맨 첫줄)를 없애는 역할

for line in reader :
    print(line)

f.close()