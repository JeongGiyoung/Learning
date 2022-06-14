from flask import Flask, render_template, request

app = Flask(__name__)

import requests
from bs4 import BeautifulSoup
import time

from selenium import webdriver

@app.route('/')
def hello_world():
    return render_template("index.html")

@app.route('/naver_shopping', methods=['POST'])
def naver_shopping():
    search = request.form['input3']

    search_list = []
    search_list_src = []

    driver = webdriver.Chrome("C:/Users/admin/Desktop/chromedriver_win32/chromedriver.exe")

    # 3초 기다려주기, 웹페이지 로딩까지
    driver.implicitly_wait(3)

    # 드라이버 실행
    driver.get("https://search.shopping.naver.com/search/all?query=" + search)

    y = 2
    for timer in range(0, 5):
        driver.execute_script("window.scrollTo(0, " + str(y) + ")")
        y = y + 1000
        time.sleep(1)

    soup = BeautifulSoup(driver.page_source, 'html.parser')

    select = "#__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > ul > div"
    # text
    for i in soup.select(select)[0].find_all("div", class_='basicList_title__3P9Q7'):
        # print(i.text)
        search_list.append(i.text)

    # img
    for i in soup.select(select)[0].find_all("div", class_='thumbnail_thumb_wrap__1pEkS _wrapper'):
        tmp = i.find_all("img")
        for index in tmp:
            search_list_src.append(index['src'])

    driver.close()

    return render_template("shopping.html",
                           search_list=search_list,
                           search_list_src=search_list_src,
                           len=3)

if __name__ == "__main__":
    app.run()