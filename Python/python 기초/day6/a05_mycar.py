# mycar.py

from a04_vehicle import Car

if __name__ == '__main__' :
    mycar = Car('98하 5678', '흰색')
    # mycar.차량번호 = '98하 5678'
    # mycar.색상 = '흰색'
    mycar.연료 = '경유'
    mycar.제조사 = '기아'
    mycar.출고년도도 = 1999
    
    mycar.전진한다(input('몇 단으로 갈지 입력하세요 : '))

    print(mycar)
    