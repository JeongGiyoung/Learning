# 크롤링 라이브러리 import
import requests
from bs4 import BeautifulSoup

def daum() :
    # 엔터치기
    req = requests.get('https://www.daum.net/')

    # 이런 식으로 HTML에 있는 코드를 다 가져온다
    soup = BeautifulSoup(req.text, 'html.parser')

    myList = []
    myList_href = []

    for i in soup.select("#mArticle > div.cmain_tmp > div.section_media > div.hotissue_builtin > div.realtime_part > ol > li"):
        myList.append(i.find("a").text)
        myList_href.append(i.find("a")["href"])

    return myList, myList_href


def today_humor() :
    # 엔터치기
    req = requests.get('http://www.todayhumor.co.kr/board/list.php?table=bestofbest')

    # 이런 식으로 HTML에 있는 코드를 다 가져온다
    soup = BeautifulSoup(req.text, 'html.parser')

    myList = []
    myList_href = []

    for i in soup.find_all("td", class_="subject") :
        myList.append(i.text)
        myList_href.append("http://www.todayhumor.co.kr/" + i.find("a")["href"])

    return myList,myList_href


def clien():
    # 엔터치기
    req = requests.get('https://www.clien.net/service/recommend')

    # 이런 식으로 HTML에 있는 코드를 다 가져온다
    soup = BeautifulSoup(req.text, 'html.parser')

    myList = []
    myList_href = []

    for i in soup.find_all("span", class_="subject_fixed") :
        myList.append(i.text)

    for i in soup.find_all("a", class_="list_subject") :
        myList_href.append("https://www.clien.net/" + i["href"])

    return myList, myList_href