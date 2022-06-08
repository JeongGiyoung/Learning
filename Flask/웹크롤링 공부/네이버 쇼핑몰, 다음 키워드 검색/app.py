# 출처 : https://vicepresident.tistory.com/107
from flask import Flask, render_template, request

app = Flask(__name__)

import requests
from bs4 import BeautifulSoup
import time

# 엑셀 쓰기 위한 준비
from openpyxl import Workbook

write_wb = Workbook()
write_ws = write_wb.active

from selenium import webdriver


@app.route('/')
def hello_world():
    return render_template("index.html")


@app.route('/result', methods=['POST'])
def result():
    keyword = request.form['input1']
    page = request.form['input2']
    daum_list = []

    for num in range(1, int(page) + 1):
        url = "https://search.daum.net/search?w=news&nil_search=btn&DA=NTB&enc=utf8&cluster=y&cluster_page=1&q=" + keyword + "&p=" + str(
            num)
        req = requests.get(url)
        soup = BeautifulSoup(req.text, "html.parser")

        for i in soup.find_all("a", class_="tit_main fn_tit_u"):
            print(i.text)
            daum_list.append(i.text)

    for i in range(1, len(daum_list) + 1):
        write_ws.cell(i, 1, daum_list[i - 1])
    write_wb.save("static/result.xlsx")

    return render_template("result.html", daum_list=daum_list)


@app.route('/naver_shopping', methods=['POST'])
def naver_shopping():
    search = request.form['input3']
    search_list = []
    search_list_src = []
    driver = webdriver.Chrome("./chromedriver")
    # 3초 기다려주기, 웹페이지 로딩까지
    driver.implicitly_wait(3)

    driver.get("https://search.shopping.naver.com/search/all?query=" + search)

    # 스크롤 내리기
    y = 1000
    for timer in range(0, 5):
        driver.execute_script("window.scrollTo(0, " + str(y) + ")")
        y = y + 1000
        time.sleep(1)

    soup = BeautifulSoup(driver.page_source, 'html.parser')

    select = "#__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > ul > div"
    for i in soup.select(select)[0].find_all("div", class_='basicList_title__3P9Q7'):
        # print(i.text)
        search_list.append(i.text)

    # img
    for i in soup.select(select)[0].find_all("img"):
        # print(i['src'])
        search_list_src.append(i['src'])

    print("-------0-0-0-0-0-0-0-------")
    # 네이버쇼핑에서 해외직구 버튼을 눌러서 이동
    # 검색하는 물건마다 css_seletor 변수 값이 변해야 하는 듯..
    css_selector = "#__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > div.seller_filter_area > ul > li.active > a"
    driver.find_element_by_css_selector(css_selector).click()
    time.sleep(1)
    # 스크롤 내리기
    y = 1000
    for timer in range(0, 5):
        driver.execute_script("window.scrollTo(0, " + str(y) + ")")
        y = y + 1000
        time.sleep(1)

    soup = BeautifulSoup(driver.page_source, "html.parser")
    select = "#__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > ul > div"
    for i in soup.select(select)[0].find_all("div", class_='basicList_title__3P9Q7'):
        # print(i.text)
        search_list.append(i.text)
    # img
    for i in soup.select(select)[0].find_all("img"):
        # print(i['src'])
        search_list_src.append(i['src'])

    driver.close()

    return render_template("shopping.html",
                           search_list=search_list,
                           search_list_src=search_list_src,
                           len=len(search_list_src))


if __name__ == "__main__":
    app.run()