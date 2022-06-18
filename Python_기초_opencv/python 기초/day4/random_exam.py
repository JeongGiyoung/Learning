# random 함수

# 주사위

import random 

# print(random.choice(range(1,7)))

# lottery(복권)

numbers = list(range(1, 46))
lottery = [] # list()

for i in range(6) :
    lottery.append(random.choice(numbers))

print(lottery)

# random 라이브러리 불러오는 또다른 방법

from random import *

numbers = list(range(1, 46))
lottery = [] # list()

for i in range(6) :
    lottery.append(choice(numbers))

print(lottery)