# 출처 : https://philosopher-chan.tistory.com/432
from flask import Flask, render_template
app = Flask(__name__)

import crawling


@app.route('/')
def hello():

    myList, myList_href = crawling.daum()
    todayhumor, todayhumor_href = crawling.today_humor()
    clien, clien_href = crawling.clien()

    return render_template("index.html",
                           list = myList, list_href = myList_href, list_len = len(myList),
                           list2 = todayhumor, list2_href = todayhumor_href, list2_len = len(todayhumor),
                           list3 = clien, list3_href = clien_href, list3_len = len(clien))

@app.route('/about')
def about():
    return "여기는 어바웃입니다."


if __name__ == '__main__':
    app.run()