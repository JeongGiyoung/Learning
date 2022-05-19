# vehicle.py

class Car :
    차량번호 = '22나 4444'
    # 기본값 : 따로 값을 넣지 않으면 차량번호는 22나 4444
    __제조사 = '현대'
    """ 
    # 앞에다가 __(언더바 두개)를 '프라이빗(private)'이라고 부르고 class 밖에서는 값으로 접근이 불가능하도록 하는 기능이다. 
      * 다만 Python은 유연한 언어라서 private 으로 만들어도 접근이 가능하다.
    """

    색상 = '흰색'
    연료 = '가솔린'
    출고년도 = 2018

    def __init__(self, 차량번호, 색상) -> None :
        self.차량번호 = 차량번호
        self.색상 = 색상

    def __str__(self) -> str:
        return f'제 차는 {self.출고년도}년도에 만들어진 {self.연료} 차량입니다.'

    def 전진한다(self, level) :
        print(f'{self.색상}차가 {level}단 앞으로 달린다.')

    def 후진한다(self) :
        print("뒤로 달린다.")
        

    def 좌회전한다(self) :
        print("왼쪽으로 달린다.")
        

    def 우회전한다(self) :
        print("오른쪽으로 달린다.")
        

    def 멈춘다(self) :
        print("멈춘다.")
        

