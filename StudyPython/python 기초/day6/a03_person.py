# person.py
# Person 클래스

class Person :
    name = '무명이' # 아직 이름이 없길래
    age = 0
    height = 0
    gender = ''
    feetsize = 250
    bloodtype = ''

    
    # 생성자

    def __init__(self, name, age, height, gender) -> None : # 초기화
        self.name = name
        self.age = age
        self.height = height
        self.gender = gender
        print('Person이 생성되었습니다.')

    def 소개한다(self) -> None : 
        greeting = f'''안녕하세요. 저는 {self.name}입니다.
        {self.gender} 구요. {self.age}
        '''
        print(greeting)

    def 먹는다(self, food) :
        print(f'{self.name}(이)가 {food}를 먹는다.')

    def 일한다(self, drink) :
        print(f'{self.name}(이)가 {drink}를 마시면서 일한다.')

if __name__  == '__main__' :
    """ 
        p = Person()
        print(type(p))
        print(id(p)) # id값

        p2 = Person() # p2 객체 생성
        print(type(p2))
        print(id(p2))
    """
    jgy = Person('정기영', 34, 180, 'male') # == __init__(self, name, age):
    # jgy.name = '정기영'
    # jgy.age = 34
    # jgy.height = 180
    # jgy.gender = 'male'
    jgy.feetsize = 275
    jgy.bloodtype = 'RH+ A'
    
    jgy.소개한다()
    jgy.먹는다('본죽')
    jgy.일한다('핫식스')


""" 
    hgd = Person()
    hgd.name = '홍길동'
    hgd.age = 490
    hgd.height = 150
    hgd.gender = 'male' 
"""

