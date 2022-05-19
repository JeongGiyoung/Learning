# studyPythonByAnaconda

# Day1 파일은 여기에 있는 파일이 있어야 정상 작동
  * C:\Users\admin\busan\1day\data

# [1일차_아나콘다 설치]

### 1.2. 엑셀 파일 읽어 들이기


```python
# 파일 위치 지정
file_path = "./data/bicycle.xlsx"

# 데이터프레임 형태로 파일 읽어들이기
df_excel = pd.read_excel(file_path)
```

### 2. 파일 저장

### 2.1. csv 파일 저장하기


```python
df_csv.to_csv("./data/save_data.csv")
```


### # 엑셀파일로 저장


```python
df_excel.to_excel("./data/save_data.xlsx")
```


### 3. 공공데이터 Open API 데이터 읽어오기


```python
import pandas
```


```python
from bs4 import BeautifulSoup
```


```python
import requests
```


```python
from openpyxl.workbook import Workbook
```


```python
# api key 입력

apikey='2iBxaKFKnzeyq04AkTe7ZCYjXgKOO6sXWOegK0YOWsgfPk%2FyFKrzqSaEiKFNMSUDX9qffhdPG0ajf0ydWGVzFQ%3D%3D'

# 약국정보서비스 URL
api = "http://apis.data.go.kr/B551182/pharmacyInfoService/getParmacyBasisList?serviceKey=2iBxaKFKnzeyq04AkTe7ZCYjXgKOO6sXWOegK0YOWsgfPk%2FyFKrzqSaEiKFNMSUDX9qffhdPG0ajf0ydWGVzFQ%3D%3D&pageNo=1&numOfRows=10&sidoCd=110000&sgguCd=110019&emdongNm=%EC%8B%A0%EB%82%B4%EB%8F%99&yadmNm=%EC%98%A8%EB%88%84%EB%A6%AC%EA%B1%B4%EA%B0%95&type=json&APPID={key}"

# 약국정보 컬럼(제목) 정의
list_drugs = ["병원명", "종목코드명", "시도명", "주소", "전화번호"]
```


```python
# API 정보 가지고 오기
for list_drug in list_drugs : 
    url = api.format(list_drugs = list_drug,
                    key = apikey)
    
    req = requests.get(url)
    re = req.text
    soup = BeautifulSoup(re, "html.parser")
    # print(soup)
    
    yadmnm = soup.find_all("yadmnm")
    sggucdnm = soup.find_all("sggucdnm")
    sidocdnm = soup.find_all("sidocdnm")
    addr = soup.find_all("addr")
    telno = soup.find_all("telno")
    
    print("병원명 : ", yadmnm)
    print("종목코드명 : ", sggucdnm)
    print("시도명 : ", sidocdnm)
    print("주소 : ", addr)
    print("전화번호 : ", telno)
    print("==========================")
```
    

### 4. 웹크롤링


```python
# 사용되는 라이브러리
from bs4 import BeautifulSoup as bs
from pprint import pprint
import requests
```


```python
# 수집하고자 하는 사이트 URL을 이용하여 
# Tag 가지고 오기
site_url = "https://search.naver.com/search.naver?query=날씨"
html = requests.get(site_url)


# html.text

soup = bs(html.text, "html.parser")
soup
```



```python
fine_dust_code = dustdata_all[0].find("span", {"class", "blind"})
fine_dust_code
```


```python
fine_dust_code_text = dustdata_all[0].find("span", {"class", "blind"}).text

fine_dust_code_text
```


```python
for i in range(0, len(dustdata_all) -1 ) :
    fine_dust_code_text = dustdata_all[i].find("span", {"class", "blind"}).text
    print(fine_dust_code_text)
```

-----
# [2day_01_판다스_데이터구조]

# 데이터 구조 파악

## pandas 라이브러리 활용

### # 라이브러리 불러들이기


```python
import pandas as pd
```

## [Series]

### = pd.Series( , index = )
시리즈 데이터 만들기


```python
sd1 = pd.Series(['Doc', 'Cat', 'Tiger', 'Lion', 'Monkey'], 
               index = ['00','11','22','33','44'])

sd1
```



### # 딕셔너리 -> 시리즈

### = { 'key' : value ... }
딕셔너리 만들기


```python
dict_data = {'a' : 1 , 'b' : 2, 'c' : 3}

dict_data
```




    {'a': 1, 'b': 2, 'c': 3}




```python
dict_data['b']
```




    2



### 딕셔너리를 시리즈로 만들면 key 값은 인덱스가 된다.


```python
sd2 = pd.Series(dict_data)

sd2
```




    a    1
    b    2
    c    3
    dtype: int64



### # 리스트 -> 시리즈


```python
list_data = ['Dog', 'Cat', 'Tiger']
```


```python
sd3 = pd.Series(list_data)

sd3
```




    0      Dog
    1      Cat
    2    Tiger
    dtype: object




### # 튜플 -> 시리즈


```python
# '이순신', '1991-03-15', '남자'
# 위 데이터를 튜플로 만든다.

tup = ('이순신', '1991-03-15', '남자')

tup
```




    ('이순신', '1991-03-15', '남자')




```python
col_name = ["이름", "생년원일", "성별"]

sd4 = pd.Series(tup,
               index = col_name)

sd4
```




    이름             이순신
    생년원일    1991-03-15
    성별              남자
    dtype: object



## [데이터프레임]

### # 딕셔너리 -> 데이터프레임


```python
# 동물 : 'Dog', 'Cat', 'Tiger', 'Lion', 'Monkey'
# 나이 : 7,9,2,3,1
# 위에 동물과 나이를 하나의 딕셔너리로 만든다.

dict_ani = {'동물' : ['Dog', 'Cat', 'Tiger', 'Lion', 'Monkey'],
            '나이' : [7,9,2,3,1]}

dict_ani
```




    {'동물': ['Dog', 'Cat', 'Tiger', 'Lion', 'Monkey'], '나이': [7, 9, 2, 3, 1]}




```python
dict_ani['동물']
```




    ['Dog', 'Cat', 'Tiger', 'Lion', 'Monkey']



### = pd.DataFrame()
데이터프레임으로 만들기


```python
df1 = pd.DataFrame(dict_ani)

df1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>동물</th>
      <th>나이</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Dog</td>
      <td>7</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Cat</td>
      <td>9</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tiger</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Lion</td>
      <td>3</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Monkey</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



### # 리스트 -> 데이터프레임


```python
# 2행 5열 리스트 만들기

list_data = [['Dog', 7],
             ['Cat', 9],
             ['Tiger', 2],
             ['Tiger', 3],
             ['Monkey', 1]]
list_data
```




    [['Dog', 7], ['Cat', 9], ['Tiger', 2], ['Tiger', 3], ['Monkey', 1]]



### # 데이터프레임으로 만들기


```python
df2 = pd.DataFrame(list_data, 
                  columns = ['동물', '나이'])

print(df2)

print(type(df2))
```

           동물  나이
    0     Dog   7
    1     Cat   9
    2   Tiger   2
    3   Tiger   3
    4  Monkey   1
    <class 'pandas.core.frame.DataFrame'>
    

### 변수.dtypes
각 열의 데이터 타입 확인


```python
df2.dtypes
```




    동물    object
    나이     int64
    dtype: object



### # 비어있는 데이터프레임 만들기
df_null = pd.DataFrame()


```python
df_null = pd.DataFrame()

df_null
```



### # 컬럼(변수) 만들기
df_null[" "] = " "


```python
df_null["동물"] = "Dog"

df_null
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>동물</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
</div>


-----
# [2day_02_데이터프레임_조작]

# 데이터프레임 조작

## [데이터 요약 확인]

### # 필요한 라이브러리 장착


```python
import pandas as pd

import matplotlib as mpl

import matplotlib.pylab as plt

import seaborn as sns
```

### # 행의 위치를 찾을 때 쓸 라이브러리


```python
import numpy as np
```

### # seaborn 안에 있는 내장 데이터 가지고 오기
  * 'tips' : 손님들의 유형별 팁을 얼마나 주는가?


```python
tips = sns.load_dataset("tips")

tips
```

#### # 데이터 구조  확인


```python
tips.info()

"""
# 데이터 형태 확인 가능
  * rangeIndex 와  Non-Null Count 의 값을 비교하여 결측치 확인 가능
"""
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 244 entries, 0 to 243
    Data columns (total 10 columns):
     #   Column      Non-Null Count  Dtype   
    ---  ------      --------------  -----   
     0   total_bill  244 non-null    float64 
     1   tip         244 non-null    float64 
     2   sex         244 non-null    category
     3   smoker      244 non-null    category
     4   day         244 non-null    category
     5   time        244 non-null    category
     6   size        244 non-null    int64   
     7   total       244 non-null    float64 
     8   total2      244 non-null    float64 
     9   smoker_str  244 non-null    object  
    dtypes: category(4), float64(4), int64(1), object(1)
    memory usage: 13.1+ KB
    




    '\n# 데이터 형태 확인 가능\n  * rangeIndex 와  Non-Null Count 의 값을 비교하여 결측치 확인 가능\n'



#### # 가장 상위, 하위 조회


```python
tips.head()
```


```python
tips.head(10)
```


```python
tips.tail()
```


```python
tips.tail(10)
```

#### # 데이터프레임 행 조회 방법 2가지

1. 컬럼명(변수명)으로 조회 


```python
tips ["sex"]
```




    0      Female
    1        Male
    2        Male
    3        Male
    4      Female
            ...  
    239      Male
    240    Female
    241      Male
    242      Male
    243    Female
    Name: sex, Length: 244, dtype: category
    Categories (2, object): ['Male', 'Female']



### # 데이터 프레임 형태로 조회


```python
tips[["sex"]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sex</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Female</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Female</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
    </tr>
    <tr>
      <th>239</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>240</th>
      <td>Female</td>
    </tr>
    <tr>
      <th>241</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>242</th>
      <td>Male</td>
    </tr>
    <tr>
      <th>243</th>
      <td>Female</td>
    </tr>
  </tbody>
</table>
<p>244 rows × 1 columns</p>
</div>




```python
tips ["sex"][0]
```




    'Female'




```python
tips[["sex", "tip"]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sex</th>
      <th>tip</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Female</td>
      <td>1.01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Male</td>
      <td>1.66</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Male</td>
      <td>3.50</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Male</td>
      <td>3.31</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Female</td>
      <td>3.61</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>239</th>
      <td>Male</td>
      <td>5.92</td>
    </tr>
    <tr>
      <th>240</th>
      <td>Female</td>
      <td>2.00</td>
    </tr>
    <tr>
      <th>241</th>
      <td>Male</td>
      <td>2.00</td>
    </tr>
    <tr>
      <th>242</th>
      <td>Male</td>
      <td>1.75</td>
    </tr>
    <tr>
      <th>243</th>
      <td>Female</td>
      <td>3.00</td>
    </tr>
  </tbody>
</table>
<p>244 rows × 2 columns</p>
</div>



### 2. numpy의 loc와 iloc 사용

* 차이점을 확인하기 위해 특정 행 하나 삭제


```python
tips_del = tips.drop([2])

tips_del
```


### # 행의 위치(순서)로 변수의 데이터 출력


```python
tips_del.iloc[2]
```


### # 인위적으로 부여된 index번호를 이용


```python
tips_del.loc[3]
```

```python
tips.loc[[1,3,5]]
```

```python
tips.iloc[-1]
```


```python
tips[0:3]
```


### # 행 순서로 출력

[0:3] 의 의미
  * 0에서 시작해서 3-0 = 3
  * 즉, 3개를 불러오겠다.


```python
tips.loc[0:3]
```

### # loc를 이용해 여러 컬럼을 조회


```python
tips.loc[0:3, ['sex', 'day']]
```

```python
tips.loc[0, ['sex', 'day']]
```


```python
tips.loc[2, 'sex']
```

### [문제]
행의 위치 3~5의 행과

컬럼은 첫번째 ~ 두번째 컬럼의 데이터 조회


```python
tips.iloc[3:6, 0:2]
```

```python
tips.loc[3:6, ['total_bill','tip']]
```

```python
tips.iloc[[1, 2, 4],[0, 3]]
```


#### # 컬럼을 전부 조회


```python
tips.iloc[1:3, :]
```


### # 행을 전부 조회


```python
tips.iloc[ : , 1:3]
```



```python
tips.iloc[1,1]
```

### # 하나의 요소 값 조회

```python
tips.iat[1,1]
```


### # 조건식의 조회 형태


```python
tips.tip > 5
```


### # 조건식을 묶는 방법


```python
tips[tips.tip > 5]
tips[tips["tip"] > 5]
```



### [문제]
sex 값이 Male 이고 smoker 값이 No인 데이터 조회


```python
tips[(tips["sex"] == 'Male') & (tips["smoker"] == 'No')]
```

### # 특정 값을 조회


```python
tips["day"].isin(["Sun"])
```


```python
tips[tips["day"].isin(["Sun"])]
```


### # tips에서 total_bill, tip, day 컬럼의 값을 조회


```python
tips[['total_bill', 'tip', 'day']]
```

### # 컬럼 추가


```python
tips["total"] = 0
```


### [문제]
total = total_bill + tip

위 계산 공식으로 total 의 각 행을 계산해서 넣기


```python
tips["total"] = tips["total_bill"] + tips["tip"]
```


```python
tips["total2"] = tips["total_bill"] + tips["tip"]
```

### # tips의 각 컬럼별 데이터들의 type 조회


```python
tips.dtypes
```




    total_bill     float64
    tip            float64
    sex           category
    smoker        category
    day           category
    time          category
    size             int64
    total          float64
    total2         float64
    dtype: object



### # tips에서 total_bill 컬럼의 type 조회


```python
type(tips.total_bill)
```




    pandas.core.series.Series



### # 데이터 타입 변환


```python
tips["smoker_str"] = tips["smoker"].astype(str)
```


### # 데이터 개수 확인


```python
tips.count()
```




    total_bill    244
    tip           244
    sex           244
    smoker        244
    day           244
    time          244
    size          244
    total         244
    total2        244
    smoker_str    244
    dtype: int64




```python
tips.tip.count()
```




    244




```python
tips["tip"].count()
```




    244




```python
len(tips)
```




    244



### # 변수의 인덱스 구성 확인


```python
tips.index
```




    RangeIndex(start=0, stop=244, step=1)



### # 변수의 컬럼 구성 확인


```python
tips.columns
```




    Index(['total_bill', 'tip', 'sex', 'smoker', 'day', 'time', 'size', 'total',
           'total2', 'smoker_str'],
          dtype='object')



### # 데이터프레임 형태의 변수를 / 튜플 형태로 보고자 할 때


```python
tips.values
```




    array([[16.99, 1.01, 'Female', ..., 18.0, 18.0, 'No'],
           [10.34, 1.66, 'Male', ..., 12.0, 12.0, 'No'],
           [21.01, 3.5, 'Male', ..., 24.51, 24.51, 'No'],
           ...,
           [22.67, 2.0, 'Male', ..., 24.67, 24.67, 'Yes'],
           [17.82, 1.75, 'Male', ..., 19.57, 19.57, 'No'],
           [18.78, 3.0, 'Female', ..., 21.78, 21.78, 'No']], dtype=object)




```python
tips["tip"].values
```




    array([ 1.01,  1.66,  3.5 ,  3.31,  3.61,  4.71,  2.  ,  3.12,  1.96,
            3.23,  1.71,  5.  ,  1.57,  3.  ,  3.02,  3.92,  1.67,  3.71,
            3.5 ,  3.35,  4.08,  2.75,  2.23,  7.58,  3.18,  2.34,  2.  ,
            2.  ,  4.3 ,  3.  ,  1.45,  2.5 ,  3.  ,  2.45,  3.27,  3.6 ,
            2.  ,  3.07,  2.31,  5.  ,  2.24,  2.54,  3.06,  1.32,  5.6 ,
            3.  ,  5.  ,  6.  ,  2.05,  3.  ,  2.5 ,  2.6 ,  5.2 ,  1.56,
            4.34,  3.51,  3.  ,  1.5 ,  1.76,  6.73,  3.21,  2.  ,  1.98,
            3.76,  2.64,  3.15,  2.47,  1.  ,  2.01,  2.09,  1.97,  3.  ,
            3.14,  5.  ,  2.2 ,  1.25,  3.08,  4.  ,  3.  ,  2.71,  3.  ,
            3.4 ,  1.83,  5.  ,  2.03,  5.17,  2.  ,  4.  ,  5.85,  3.  ,
            3.  ,  3.5 ,  1.  ,  4.3 ,  3.25,  4.73,  4.  ,  1.5 ,  3.  ,
            1.5 ,  2.5 ,  3.  ,  2.5 ,  3.48,  4.08,  1.64,  4.06,  4.29,
            3.76,  4.  ,  3.  ,  1.  ,  4.  ,  2.55,  4.  ,  3.5 ,  5.07,
            1.5 ,  1.8 ,  2.92,  2.31,  1.68,  2.5 ,  2.  ,  2.52,  4.2 ,
            1.48,  2.  ,  2.  ,  2.18,  1.5 ,  2.83,  1.5 ,  2.  ,  3.25,
            1.25,  2.  ,  2.  ,  2.  ,  2.75,  3.5 ,  6.7 ,  5.  ,  5.  ,
            2.3 ,  1.5 ,  1.36,  1.63,  1.73,  2.  ,  2.5 ,  2.  ,  2.74,
            2.  ,  2.  ,  5.14,  5.  ,  3.75,  2.61,  2.  ,  3.5 ,  2.5 ,
            2.  ,  2.  ,  3.  ,  3.48,  2.24,  4.5 ,  1.61,  2.  , 10.  ,
            3.16,  5.15,  3.18,  4.  ,  3.11,  2.  ,  2.  ,  4.  ,  3.55,
            3.68,  5.65,  3.5 ,  6.5 ,  3.  ,  5.  ,  3.5 ,  2.  ,  3.5 ,
            4.  ,  1.5 ,  4.19,  2.56,  2.02,  4.  ,  1.44,  2.  ,  5.  ,
            2.  ,  2.  ,  4.  ,  2.01,  2.  ,  2.5 ,  4.  ,  3.23,  3.41,
            3.  ,  2.03,  2.23,  2.  ,  5.16,  9.  ,  2.5 ,  6.5 ,  1.1 ,
            3.  ,  1.5 ,  1.44,  3.09,  2.2 ,  3.48,  1.92,  3.  ,  1.58,
            2.5 ,  2.  ,  3.  ,  2.72,  2.88,  2.  ,  3.  ,  3.39,  1.47,
            3.  ,  1.25,  1.  ,  1.17,  4.67,  5.92,  2.  ,  2.  ,  1.75,
            3.  ])



### # 정렬

  * 행단위 정렬 : axis = 0
  * 컬럼단위 정렬 : axis = 1
  * True = 오름차순
  * False = 내림차순


```python
tips.sort_values(by = ['total_bill'], axis = 0, ascending = False)
```

```python
tips.sort_index(axis = 1, ascending = True)
```


### # 행단위로 컬럼의 값들을 합하기


```python
tips.sum(axis = 1)
```

### # 컬럼단위로 합하기


```python
tips.sum(axis=0)
```



```python
tips.sum()
```

    total_bill                                              4827.77
    tip                                                      731.58
    size                                                        627
    total                                                   5559.35
    total2                                                  5559.35
    smoker_str    NoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNoNo...
    dtype: object



## [데이터 합하기]

### # 시리즈 데이터 행 단위 합하기
##### 시리즈변수명 s1 ==> 값은 0,1 / 인덱스 값은 A, B로 시리즈 만들기
##### 시리즈변수명 s2 ==> 값은 2,3,4 / 인덱스 값은 a,b,c로 시리즈 만들기


```python
s1 = pd.Series([0,1], index=["A", "B"])
s1
```




    A    0
    B    1
    dtype: int64




```python
s2 = pd.Series([2,3,4], index=["a", "b", "c"])
s2
```




    a    2
    b    3
    c    4
    dtype: int64




```python
pd.concat([s1, s2], axis = 0)
```




    A    0
    B    1
    a    2
    b    3
    c    4
    dtype: int64



### # 시리즈 데이터 컬럼 단위 합하기


```python
df_temp1 = pd.DataFrame([["Dog", 3],
                         ["Cat", 10],
                         ["Tiger", 6],
                         ["Moose", 3]],
                       index = [0,1,2,3],
                       columns = ["동물",
                                 "나이"])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>동물</th>
      <th>나이</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Dog</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Cat</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tiger</td>
      <td>6</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Moose</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_temp2 = pd.DataFrame([["집", 0],
                         ["초원", 1],
                         ["수풀", 0],
                         ["초원", 1]],
                        index = [0,1,2,3],
                        columns = ["사는곳", "뿔의 갯수"])
```


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>사는곳</th>
      <th>뿔의 갯수</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>집</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>초원</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>수풀</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>초원</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.concat([df_temp1, df_temp2], axis = 1)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>동물</th>
      <th>나이</th>
      <th>사는곳</th>
      <th>뿔의 갯수</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Dog</td>
      <td>3</td>
      <td>집</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Cat</td>
      <td>10</td>
      <td>초원</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tiger</td>
      <td>6</td>
      <td>수풀</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Moose</td>
      <td>3</td>
      <td>초원</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_info1 = pd.DataFrame({"고객번호" : [1001, 1002, 1003, 1004, 1005, 1006, 1007],
                        "이름" : ["강", "김", "홍", "이", "박", "최", "소"]},
                       columns = ["고객번호", "이름"])

df_info1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>이름</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>강</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1002</td>
      <td>김</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1003</td>
      <td>홍</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1004</td>
      <td>이</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1005</td>
      <td>박</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1006</td>
      <td>최</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1007</td>
      <td>소</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_info2 = pd.DataFrame({"고객번호" : [1001, 1001, 1005, 1006, 1008, 1001], 
                        "금액" : [10000, 20000, 15000, 5000, 100000, 30000]},
                       columns = ["고객번호", "금액"])
df_info2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>금액</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>10000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1001</td>
      <td>20000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1005</td>
      <td>15000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1006</td>
      <td>5000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1008</td>
      <td>100000</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1001</td>
      <td>30000</td>
    </tr>
  </tbody>
</table>
</div>



### [문제]
* 컬럼 단위로 옆으로 추가
* 단, 고객번호가 같은 값들만


```python
pd.merge(df_info1, df_info2,
         how ="inner")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>이름</th>
      <th>금액</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>강</td>
      <td>10000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1001</td>
      <td>강</td>
      <td>20000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1001</td>
      <td>강</td>
      <td>30000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1005</td>
      <td>박</td>
      <td>15000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1006</td>
      <td>최</td>
      <td>5000</td>
    </tr>
  </tbody>
</table>
</div>




```python
print(df_info1)
print(df_info2)
```

       고객번호 이름
    0  1001  강
    1  1002  김
    2  1003  홍
    3  1004  이
    4  1005  박
    5  1006  최
    6  1007  소
       고객번호      금액
    0  1001   10000
    1  1001   20000
    2  1005   15000
    3  1006    5000
    4  1008  100000
    5  1001   30000
    

* 컬럼 단위로 옆으로 추가
* 단, 고객번호가 없더라도 합치기


```python
pd.merge(df_info1, df_info2, how = "outer")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>이름</th>
      <th>금액</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>강</td>
      <td>10000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1001</td>
      <td>강</td>
      <td>20000.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1001</td>
      <td>강</td>
      <td>30000.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1002</td>
      <td>김</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1003</td>
      <td>홍</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1004</td>
      <td>이</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1005</td>
      <td>박</td>
      <td>15000.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1006</td>
      <td>최</td>
      <td>5000.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1007</td>
      <td>소</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>1008</td>
      <td>NaN</td>
      <td>100000.0</td>
    </tr>
  </tbody>
</table>
</div>



### # 왼쪽 변수 기준 합치기


```python
pd.merge(df_info1, df_info2 , how = "left")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>이름</th>
      <th>금액</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>강</td>
      <td>10000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1001</td>
      <td>강</td>
      <td>20000.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1001</td>
      <td>강</td>
      <td>30000.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1002</td>
      <td>김</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1003</td>
      <td>홍</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1004</td>
      <td>이</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1005</td>
      <td>박</td>
      <td>15000.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1006</td>
      <td>최</td>
      <td>5000.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1007</td>
      <td>소</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



### # 오른쪽 변수 기준 합치기


```python
pd.merge(df_info1, df_info2 , how = "right")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>고객번호</th>
      <th>이름</th>
      <th>금액</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1001</td>
      <td>강</td>
      <td>10000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1001</td>
      <td>강</td>
      <td>20000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1005</td>
      <td>박</td>
      <td>15000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1006</td>
      <td>최</td>
      <td>5000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1008</td>
      <td>NaN</td>
      <td>100000</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1001</td>
      <td>강</td>
      <td>30000</td>
    </tr>
  </tbody>
</table>
</div>
-----------------------------------------

# [3day_01_빈도_교차분석]

### # 기본 라이브러리 장착


```python
import pandas as pd

import matplotlib as mpl

import matplotlib.pylab as plt

import seaborn as sns # seaborn 라이브러리는 matplotlib 라이브러리랑 연동되어 있어서 함께 장착

import numpy as np # loc 함수 사용시 필요
```

### # tips 데이터셋 읽어들이기

```python
tips = sns.load_dataset("tips")

tips
```

### # 성별를 데이터 프레임 형태로 출력

```python
tips[["sex"]]
```

### 성별 데이터를 여러 정보를 포함해서 출력

```python
tips.sex
```

### # 하나의 컬럼 안에 있는 각 값들의 빈도 조회

```python
print(tips["sex"].value_counts())

print(tips["day"].value_counts())

print(tips["smoker"].value_counts())

print(tips["time"].value_counts())
```

### # 월별/성별 교차분석

```python
pd.crosstab(tips["sex"], tips["day"])
```

### # 성별/월별 교차분석 총괄표
  * 행렬별 합계

```python
pd.crosstab(tips["sex"],
            tips["day"],
            margins = True)
```

### # 빈도 비율 확인

```python
pd.crosstab(tips["sex"],
            tips["day"]).apply(lambda r : r/len(tips), axis = 1)
```

### # 컬럼별 데이터 타입 확인
  * category라는 타입이 나오면 범주형 데이터로 분석할 수 있다.

```python
tips.dtypes
```

### # 기초 통계 조회

```python
tips.describe()
```

### # 행별로 결측치 확인

```python
tips.isnull().sum(1)
```

### # 열별로 결측치 확인

```python
tips.isnull().sum(0)
```

### # 행 단위로 결측치 삭제 

```python
tips.dropna(axis = 0)
```

### # 열 단위로 결측치 삭제 

```python
tips.dropna(axis = 1)
```

### # 데이터프레임 형태로 결측치 제거

```python
tips.dropna()
```
### # 결측치를 0으로 채우기

```python
tips.fillna(0)
```

### # 결측치를 문자열로 대체


```python
tips.fillna(' ')
```

### # 결측치를 평균값으로 대체
  * 범주형 데이터는 비율을 확인해서 비율대로 데이터값을 채운다.

```python
tips.fillna(tips.mean())
```

----------------------------------------
# 3day_02_결측치_처리

# 결측치 처리하기

### # 필요한 라이브러리 장착


```python
import pandas as pd
import numpy as np
```

### # bicycle.csv 파일 읽어 오기


```python
# 파일 경로 지정
file_path = "./data/bicycle.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)
```

### # 오류 중 맨 마지막 줄에 utf-8 오류가 나올 때
  * 메모장 - 다른이름으로 저장 - 인코딩 - utf-8로 저장
  
  혹은
  
  * df= pd.read_csv(file_path, encoding = "euc-kr")
    - "euc-kr"은 한국에서만 통용되는 인코딩

### # 결측치 확인

```python
df.isnull()
```

### # 컬럼별 결측값이 있는 행의 개수 조회

```python
df.isnull().sum(0)
```

### # 행별 결측값이 있는 컬럼의 개수 조회

```python
df.isnull().sum(1)
```

### # 결측치가 아닌 행, 열 값 개수 조회

```python
print(df.notnull().sum(1))
print(df.notnull().sum(0))
```

### # 결측치가 있는 모든 행 삭제

```python
df_drop_allrow = df.dropna(axis=0)
df_drop_allrow
```

### # 결측치가 있는 컬럼들 행단위로 제거

```python
df_drop_allcolum = df.dropna(axis = 1)
df_drop_allcolum.head()
```
    

### # 특정 컬럼에 있는 결측치 행들 컬럼 단위로 삭제


```python
df1 = df["대여거치대"].dropna(axis = 0)
```


```python
df1.isnull().sum(0)
```

### # 여러개 컬럼을 기준으로 삭제


```python
df1 = df[["대여소번호",
          "대여거치대",
          "이용시간"]].dropna(axis =0)
```


```python
df1.isnull().sum(0)
```

### # 결측치를 모두 0으로 변환


```python
df.fillna(0)
```
### # '이용거리' 컬럼에 있는 결측치를 모두 0으로 변환


```python
df1 = df["이용거리"].fillna(0)
```

### # 이용거리 컬럼에 있는 결측치를 모두 "missing"으로 수정


```python
df["이용거리"].fillna("missing")
```


### # 결측치 전체를 평균값으로 대체

```python
df.fillna(df.mean())
```


### # 이용거리 컬럼에 결측치를 평균값으로 대체


```python
df["이용거리"].fillna(df["이용거리"].mean())
```

--------------------------------------------
# 4day_01_이상치_처리

# 이상치 처리하기


```python
import pandas as pd
import numpy as np
```

### # 사용할 데이터 불러오기


```python
# 파일 경로 지정
file_path = "./data/bicycle_out.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)
```

### # 결측치 있는 행 삭제와 확인


```python
df_drop_allrow = df.dropna(axis = 0)

print(df_drop_allrow)

df_drop_allrow.isnull().sum(0)
```

### # 인덱스 번호 재배열
  * 데이터 제거할 때 함께 사라진 인덱스 번호를 다시 부여하려고 할 때
  * drop = True
    - 기존 index 컬럼 삭제


```python
df_drop_allrow = df_drop_allrow.reset_index(drop=True)

df_drop_allrow
```

### # 이상치 그림으로 확인


```python
import matplotlib as mpl
import matplotlib.pylab as plt
```

### # 박스플롯 그리기


```python
plt.boxplot(df_drop_allrow["나이"])
plt.show()
```

### # boxplot에서 max 값과 describe(기초통계 함수)에서 max 값의 차이점
  * boxplot()에서 max 값은 75%값에 중앙값의 1.5배를 더한 값
  * describe()에서 max 값은 값들 중에 실제 가장 높은 수

```python
df_drop_allrow["나이"].describe()
```

### # 나이가 100살을 초과하는 데이터 조회

```python
df_drop_allrow[df_drop_allrow["나이"] > 100 ]
```

### # 나이가 10살 이하의 데이터 조회

```python
df_drop_allrow[df_drop_allrow["나이"] <= 10 ]
```

### # 나이가 100살을 초과하거나 10살 이하인 데이터 조회


```python
df_drop_allrow[(df_drop_allrow["나이"] > 100) | (df_drop_allrow["나이"] <= 10)]
```

## [최대값/최소값 계산하여 이상치 제거]

### # q1(25%), q3(75%) 확인


```python
np.percentile(df_drop_allrow["나이"], [25, 75])
```

### # 여러 값을 return 받기

```python
q1, q3 = np.percentile(df_drop_allrow["나이"], [25, 75])
```

###  # iqr(interquartile, 중간값) 구하기

```python
iqr = q3 - q1

iqr
```
### # 최대값 = q3 + (iqr * 1.5)

```python
upper_bound = q3 + (iqr * 1.5)

upper_bound
```

### # 최소값 = q1 - (iqr * 1.5)

```python
lower_bound = q1 - (iqr * 1.5)

lower_bound
```

### # 이상치 데이터 찾아보기

```python
df_drop_allrow[(df_drop_allrow["나이"] > upper_bound) | (df_drop_allrow["나이"] < lower_bound)]
```

### # 이상치를 찾는 함수로 만들기('나이'컬럼 기준만)
  * 매개변수가 없이


```python
def outliers_iqr() : 
    q1, q3 = np.percentile(df_drop_allrow["나이"], [25, 75])    
    print(q1)
    print(q3)
    
    iqr = q3 - q1    
    print(iqr)
    
    upper_bound = q3 + (iqr * 1.5)
    print(upper_bound)
    
    lower_bound = q1 - (iqr * 1.5)
    print(lower_bound)
    
    df_temp = df_drop_allrow[(df_drop_allrow["나이"] > upper_bound) | (df_drop_allrow["나이"] < lower_bound)]
    print(len(df_temp))
    print(df_temp)

outliers_iqr()
```

### # 매개변수가 있는 함수 만들기
  * 데이터를 넘겨주는 대로 이상치 값을 출력


```python
def outliers_iqr2(data) : 
    q1, q3 = np.percentile(data, [25, 75])    
    print(q1)
    print(q3)
    
    iqr = q3 - q1    
    print(iqr)
    
    upper_bound = q3 + (iqr * 1.5)
    print(upper_bound)
    
    lower_bound = q1 - (iqr * 1.5)
    print(lower_bound)
    
    df_temp = df_drop_allrow[(data > upper_bound) | (data < lower_bound)]
    print(len(df_temp))
    print(df_temp)

outliers_iqr2(df_drop_allrow["나이"])
```

### # 매개변수가 두 개인 함수


```python
def outliers_iqr3(dframe, data) : 
    q1, q3 = np.percentile(data, [25, 75])    
    print(q1)
    print(q3)
    
    iqr = q3 - q1    
    print(iqr)
    
    upper_bound = q3 + (iqr * 1.5)
    print(upper_bound)
    
    lower_bound = q1 - (iqr * 1.5)
    print(lower_bound)
    
    df_temp = dframe[(data > upper_bound) | (data < lower_bound)]
    print(len(df_temp))
    print(df_temp)

outliers_iqr3(df_drop_allrow, df_drop_allrow["나이"])
```

### # 만든 함수 모듈로 만들기
  * 정의된 함수 문장만 따로 .py 파이썬 확장자로 만들기
  * 작업하고 있는 문서가 있는 폴더로 이동

```python
outliers.outliers_iqr3(df_drop_allrow, df_drop_allrow["나이"])
```

```python
((df_drop_allrow["나이"] > 61.5) | (df_drop_allrow["나이"] < 1.5))
```

### # 행 번호만 조회


```python
np.where((df_drop_allrow["나이"] > 61.5) | (df_drop_allrow["나이"] < 1.5))
```

### # 이상치가 있는 데이터 index 번호만 조회


```python
def get_outliers_data(data) : 
    q1, q3 = np.percentile(data, [25, 75])    
    print(q1)
    print(q3)
    
    iqr = q3 - q1    
    print(iqr)
    
    upper_bound = q3 + (iqr * 1.5)
    print(upper_bound)
    
    lower_bound = q1 - (iqr * 1.5)
    print(lower_bound)
    
    '''
    df_temp = dframe[(data > upper_bound) | (data < lower_bound)]
    print(len(df_temp))
    print(df_temp)
    '''
    
    return np.where((data > 61.5) | (data < 1.5))
```


```python
get_outliers_data(df_drop_allrow["나이"])
```

### # 이상치가 있는 데이터를 행번호로 찾아서 전체 데이터프레임 출력

```python
df_drop_allrow.loc[get_outliers_data(df_drop_allrow["나이"])]
```



### # 이상치 제거하기
  * 이상치 아닌 값만 추출해서 따로 저장

#### # for 문 돌리기 전 작업

```python
age_oulier_index = get_outliers_data(df_drop_allrow["나이"])
```

```python
df_drop_allrow.loc[age_oulier_index]
```

```python
age_oulier_index.index
```

```python
age_oulier_index
```

```python
df_drop_allrow.index
```

#### * for문 돌리기

```python
age_non_outlier_index = []

for idx in df_drop_allrow.index : 
    
    if idx not in age_oulier_index[0] : # age_oulier_index를 출력해보면 0번째 인덱스에 값들이 모여 있다. 1번째 인덱스에는 dtype=int64 이 있다.
        age_non_outlier_index.append(idx)
        
age_non_outlier_index
```

### # 정상 데이터만 행번호로 조회


```python
df_new = df_drop_allrow.loc[age_non_outlier_index]
```

### # 인덱스 번호 재배열하고 변수에 저장하고 조회


```python
df_new = df_new.reset_index(drop=True)

df_new
```

-----

[5day_01_중복데이터_처리하기]

# 중복 데이터 처리하기

### # 데이터 가져오기


```python
import pandas as pd
import numpy as np
```


```python
# 파일 경로 지정
file_path = "./data/bicycle_dup.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)

df
```



### # 1개 컬럼 기준으로 중복데이터 찾기
  * duplicated에 keep을 지정 안하면
    - 중복값 중에 첫번째 값은 False로 표시된다
      + 삭제작업 시 기준이 되는 첫번째 값은 남겨야 되기 때문
    - 그 외에 중복되는 값들은 True로 표시된다.


```python
# 둘 다 같은 의미

print(df.duplicated("이용거리"))

print(df["이용거리"].duplicated())
```



### # 이용거리, 나이 컬럼에 동시에 중복되는 값 체크


```python
print(df.duplicated(["이용거리", "나이"]))

print(df[["이용거리", "나이"]].duplicated())
```

    

### # 중복이 있는 데이터 조회


```python
print(df[df.duplicated(["이용거리", "나이"])])

print(df.loc[df[["이용거리", "나이"]].duplicated()])
```


### # duplicated 에 keep = "first"는 기본값
  * 생략가능하지만 쓰는 버릇 들이기


```python
df.duplicated(["이용거리"], keep="first")
```



### # keep = "last"
  * 첫번째 값을 기준으로 중복값을 조회하지만 맨 마지막에 중복값 위로는 True 처리


```python
df.duplicated(["이용거리"], keep = "last")
```


### # keep = False
  * 첫번째 값을 기준으로 중복되는 값을 조회할 때, 첫번째 값도 True 처리


```python
df.duplicated(["이용거리"], keep = False)
```


### # 이용거리, 나이 2개 컬럼을 기준으로 중복되는 모든 데이터 조회


```python
df[df.duplicated(["이용거리", "나이"], keep = False)]
```


```python
len(df[df.duplicated(["이용거리", "나이"], keep = False)])
```



```python
df_dup = df[df.duplicated(["이용거리", "나이"], keep = False)]
```


```python
len(df_dup)
```


## 중복데이터 제거

### # 첫번째 중복값만 남기고 나머지 중복 데이터 제거
  * 실행결과는 제거된 호의 정상데이터만 조회


```python
df.drop_duplicates(["이용거리"], keep = "first")
```


### # 마지막에 조회된 중복값만 남기고, 나머지 제거


```python
df.drop_duplicates(["이용거리"], keep = "last")
```


### # 중복된 데이터 전체 삭제


```python
df.drop_duplicates(["이용거리"], keep = False)
```


```python
df_dup = df.drop_duplicates(["이용거리"], keep = False)

df_dup
```

### # 중복 검증


```python
df_dup[df_dup.duplicated(["이용거리"], keep="first")]
```

### # 현재 최종 결과물(데이터프레임)에 대한 기초통계 조회


```python
df_dup.describe()
```


### # 중복데이터 확인하는 방법


```python
df2 = df.duplicated(["이용거리"], keep = "first")

df2
```


### # 중복함수를 describe()하면
  * unique = true, false 이렇게 2개 있다는 소리
  * 맨위 값 = false
  * freq = True(중복되는 값) 빈도 


```python
df2.describe()
```


```python
df[df2]
```



```python
len(df) - 163
```


### # 빈도분석을 이용해서 중복데이터 확인


```python
df2.value_counts()
```

-----

[5day_01_중복데이터_처리하기]

# 데이터 탐색하기

## 1. 데이터 그룹분석

### # 데이터 가져오기


```python
import pandas as pd
import numpy as np
```


```python
# 파일 경로 지정
file_path = "./data/exam_sample.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)

df
```


```python
df.describe()
```


### # 반별 그룹화


```python
df1 = df.groupby(["class"])
```


```python
df1.head()
```


### # 반별 그룹화 확인
  * 그룹별로 첫번째 데이터 출력


```python
df1.head(1)
```



```python
df1.head(2)
```



### # 특정 그룹 데이터 조회


```python
print(df.groupby(["class"]).get_group("A"))

# ----- 혹은

df1 = df.groupby(["class"])

print(df1.get_group("A"))
```


### # 반별 그룹 평균
  * 숫자값이 있는 컬럼만 처리됨


```python
df.groupby("class").mean()
```


### # 성별로 그룹화


```python
df.groupby(["sex"])
```


```python
df.groupby(["sex"]).head(1)
```


### # 반별 및 성별로 그룹화


```python
df.groupby(["class", "sex"])
```


```python
df.groupby(["class", "sex"]).head(1)
```


### # 성별 평균


```python
df.groupby(["sex"]).mean()
```


### # 반별 및 성별 평균


```python
df.groupby(["class", "sex"]).mean()
```

### # 반별 수학점수의 평균
  * df 전체 데이터를 사용


```python
df.groupby("class")["math"].mean()
```


```python
df["math"].groupby(df["class"]).mean()
```


```python
df.groupby("class").mean()[["math"]]
```



### # 반별로 수학 응시생 수 조회


```python
df.groupby("class").count()[["math"]]
```

### # 성별 수학점수 평균 조회


```python
df.groupby("sex").mean()[["math"]]
```


```python
sex_group = df.groupby("sex")
```


```python
sex_group.head(1)
```


### # 실제 데이터가 어떻게 구성되어 있는지 확인


```python
sex_group.groups
```

### # 성별 그룹 기준 남학생만 조회


```python
sex_group.get_group("m")
```

### # 성별 그룹 기준 남학생 수학평균


```python
m = sex_group.get_group("m")

m
```


```python
type(m)
```


```python
m[["math", "sex"]].mean()
```


## 2. 재구조화

### # cut : 데이터 구간화
  * 범주형 데이터로 만들기 위해


```python
# 3구간으로 나누기

df1 = pd.cut(df["math"], 3)

df1
```


```python
df2 = df["math"].groupby(df1)

df2.head()
```


### # 그룹변수를 기초통계


```python
df3 = df2.agg(["count", "mean", "std", "min", "max"])

df3
```


### # qcut() : 동일 데이터 개수로 구간을 나누기


```python
pd.qcut(df["math"], 3)
```


### # labels = False : 범주의 번호 표시
  * 해당 데이터가 어느 구간에 속하는지 숫자로 표시


```python
df4 = pd.qcut(df["math"], 3, labels = False)

df4
```


### # np.arange() : 구간 숫자 재지정


```python
df5 = pd.qcut(df["math"], 3, labels = np.arange(3, 0, -1))

df5
```


### # range( , , )
  * 첫번째 값 : 시작값
  * 두번째 값 : 끝값 -1 
  * 세번째 값 : 증가값 or 감소값


```python
for i in range(0,3,1) :
    print(i)

print("---------")

for j in range(3,0,-1) :
    print(j)
```
    


```python
for i in np.arange(0,3,1) :
    print(i)

print("---------")

for j in np.arange(3,0,-1) :
    print(j)
```
    

### # qcut 기초통계


```python
df6 = df["math"].groupby(df5)

df6.head()
```



```python
df7 = df6.agg(["count", "mean", "std", "min", "max"])

df7
```


## 3. get_dummis() : 원-핫 인코딩
  * 보통 get_dummies() 함수는 숫자값을 제외한 object(문자) 데이터 타입에 대해 자동으로 나눈다.
  * 범주형이 아닌 컴럼에 대해서 범주형 만들면 가능
  * 해당 one-hot 인코딩 되는 원본 컬럼은 없엊고, 해당 '컬럼명_범주명'으로 컬럼이 만들어진다.

### # df의 데이터 타입 확인


```python
df.dtypes
```




```python
df_onehot = pd.get_dummies(df)

df_onehot
```


### # get_dummies()


```python
df_onehot2 = pd.get_dummies(df["sex"])

df_onehot2
```


## 4. 데이터 전치
### # 행열 전환
  * 컬럼 -> 행 인덱스로 바뀌고
  * 행 인덱스 번호 -> 컬럼명으로 바뀐다.


```python
df.T
```

### # 피봇 테이블


```python
pd.pivot_table(df, index = "class",
               columns = "sex",
               values = "science")
```


```python
pd.pivot_table(df, index = "sex",
               columns = "class",
               values = "science")
```
------

[6day_01_시계열데이터]

# 시계열 데이터 탐색

## 시간 조작


```python
import pandas as pd
```

### # 시간 유형 데이터 만들기


```python
dates = ["2020-01-01", "2020-03-01", "2021-09-01"]

dates
```


### # 날짜 타입으로 변환(형변환)


```python
ts_dates = pd.to_datetime(dates)

ts_dates
```

### # 년월일 단위로 추출


```python
pr_day = ts_dates.to_period(freq = "D")

pr_day
```


### # 년월 단위로 추출


```python
pr_month = ts_dates.to_period(freq = "M")

pr_month
```


### # 년 단위로 추출


```python
pr_year = ts_dates.to_period(freq = "Y")

pr_year
```


### # 타임스탬프


```python
# timeseries.csv 파일 불러오기

# 파일 경로 지정
file_path = "./data/timeseries.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)

df
```


```python
df.info()
```


### # 문제
  * new_Date 컬럼을 새로 만든다.
  * Data 컬럼의 유형을 날짜 타입으로 변환
  * new_Data 컬럼에 삽입


```python
df["new_Date"] = pd.to_datetime(df["Date"])
```


### # 문제
  * new_Date 컬럼의 0번째 값을 조회
  * 0번째 값의 일반타입도 조회


```python
df["new_Date"][0]

df["new_Date"].iloc[0]

df["new_Date"].loc[0]
```

```python
type(df["new_Date"][0])
```

### # Date 컬럼 지우기


```python
df.drop("Date", axis = 1, inplace = True)
```


### # 시계열 기준으로 데이터프레임을 짜고 싶을 때는
  * index를 날짜 타입으로 대체하는 게 좋다.

#### * index 설정


```python
df.set_index("new_Date", inplace = True)
```


```python
dates = ["2020-01-01", "2020-03-01", "2021-09-01"]

dates
```


```python
ts_dates = pd.to_datetime(dates)
```

### # 날짜 추출


```python
pr_year = ts_dates.to_period(freq = "Y")

# 혹은

pr_year = ts_dates.to_period(freq = "A")

pr_year
```


```python
pr_month = ts_dates.to_period(freq = "M")

pr_month
```


```python
pr_day = ts_dates.to_period(freq = "D")

pr_day
```


### # pd.date_range : 기간 설정
  * start : 기간의 시작 값
  * end : 기간의 끝 값
  * periods : 생성할 기간의 개수
  * freq : 시간 간격 설정
  * tz : timezone

#### * 2020년 1월 1을 시작으로, 종료 년도 없고, 6개 구간으로 나눈다. 시간 간격은 월단위. 시간대는 아시아/서울.


```python
timestamp_df = pd.date_range(start = "2020-01-01", 
                             end = None, 
                             periods = 6,
                             freq = "M",
                             tz = "Asia/Seoul"
                            )
```

### # period_range로 기간 설정
  * 2년 단위로 기간 설정


```python
pr_y = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2Y",
                      )

pr_y
```

  * 2개월 단위로 기간 설정


```python
pr_m = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2M",
                      )

pr_m
```

  * 2일 단위로 기간 설정


```python
pr_d = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2D",
                      )

pr_d
```

  * 2시간 단위로 기간 설정


```python
pr_h = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2H",
                      )

pr_h
```


  * 2분 단위로 기간 설정


```python
pr_min = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2MIN",
                      )

pr_min
```

  * 2초 단위로 기간 설정


```python
pr_s = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2S",
                      )

pr_s
```

### # 문제
  * 2일 2시간 2분 2초 단위로 
  * 3개의 구간을 생성
  * 시작값은 2020-01-01


```python
pr_2D2H2MIN2S = pd.period_range(start = "2020-01-01",
                      end = None,
                      periods = 3,
                      freq = "2D+2H+2MIN+2S"
                    # freq = "2D 2H 2MIN 2S"
                      )

pr_2D2H2MIN2S
```


### # 컬럼 단위로 년/월/일 분리


```python
# timeseries.csv 파일 불러오기

# 파일 경로 지정
file_path = "./data/timeseries.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)

df
```


```python
df["new_Date"] = pd.to_datetime(df["Date"])
```

### # 년도만 추출


```python
df["Year"] = df["new_Date"].dt.year
```

### # 월 추출


```python
df["Month"] = df["new_Date"].dt.month
```

### # 일 추출


```python
df["Day"] = df["new_Date"].dt.day
```

### # 기간 설정


```python
df["Date_yr"] = df["new_Date"].dt.to_period(freq = "Y")
```


```python
df["Date_m"] = df["new_Date"].dt.to_period(freq = "M")                                         
```


```python
df["Date_d"] = df["new_Date"].dt.to_period(freq = "D")
```

### # new_Data 컬럼 인덱스로 설정


```python
df.set_index("new_Date", inplace = True)
```


### # 날짜 인덱스값을 이용해서 데이터 조회
  * 2015년 7월 25일에 대한 데이터 조회


```python
print(df.iloc[0])

df.loc["2015-07-02"]
```


```python
# 앞으로 사용불가하지만 이제까지는 가능했던 방법

df["2015-07"]
```

### # 인덱스 기간으로 조회


```python
df.loc["2018-06-25" : "2019-06-28"]
```


```python
# timeseries.csv 파일 불러오기

# 파일 경로 지정
file_path = "./data/timeseries.csv"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df= pd.read_csv(file_path)

df
```

```python
df["new_Date"] = pd.to_datetime(df["Date"])
```


```python
df.set_index("new_Date", inplace = True)
```

### # 시계열 데이터 시각화


```python
df.plot()
```

-----
# [6day_02_데이터시각화]

# 데이터 시각화

### # 판다스 기본 설치되어 있는 시각화 함수
  * line = 선
  * kde = 커널 밀도 그래프
  * bar = 수직 막대 그래프
  * area = 면적 그래프
  * barh = 수평 막대 그래프
  * pie = 파이 그래프
  * hist = 히스토그램
    - 변수가 하나인 데이터의 빈도수
  * scatter = 산점도 그래프
  * box = 박스 플롯
  * hexbin = 고밀도 산점도 그래프

### # matplotlib 은 한글 폰트를 지원하지 않는다
  * 코드를 미리 적용해야 깨지지 않는다


```python
# 윈도우
plt.rc('font', family = 'Malgun Gothic')

# Mac
plt.rc('font', family = 'AppleGothic')
```


### # 시본(seaborn) 라이브러리에 있는 내장 데이터셋 중에 anscombe 데이터셋 읽어오기


```python
import seaborn as sns

ans = sns.load_dataset("anscombe")
```


### # 문제
  * dataset 컬럼 값을 기준으로 그룹화
  * 변수명은 ans_group


```python
ans_group = ans.groupby(["dataset"])

ans_group.head()
```



```python
ans_group.describe()
```


### # 시각화 라이브러리(matplotlib.pyplot) 불러들이기


```python
import matplotlib.pyplot as plt
```

### # 문제
  * ans 데이터프레임을 사용
  * dataset 데이터 값 중에 1인 값만 조회
  * 변수는 filter_row_chk 사용


```python
filter_row_chk = (ans["dataset"] == "I")

filter_row_chk.head()
```


### # 문제
  * 위에서 필터링한 결과를 기준으로 데이터 조회
  * 변수는 data1


```python
data1 = ans[filter_row_chk]

data1
```


### # 선그래프


```python
plt.plot(data1["x"], data1["y"])
```


### # 산점도로 표현


```python
plt.plot(data1["x"], data1["y"], "o")
```



```python
plt.plot(data1["x"], data1["y"], "x")
```



### # 문제
  * dataset 안에 있는 II, III, IV에 대해서도 필터링 후
  * data2, data3, data4 변에 각각 넣기


```python
data2 = ans[ans["dataset"] == "II"]

data3 = ans[ans["dataset"] == "III"]

data4 = ans[ans["dataset"] == "IV"]
```


```python
print(data2)
print(data3)
print(data4 )
```


### # 하나의 그래프에 4개의 sub 그래프 그리기
  1. 그래프 객체 가지고 오기


```python
fig = plt.figure()
```

  2. 4개의 작은 그래프 만들기


```python
ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)
ax4 = fig.add_subplot(2, 2, 4)

fig
```

### # 각각의 그래프에 데이터 넣어주기

  * 그래프 제목 만들기


```python
ax1.set_title("Data1")
ax2.set_title("Data2")
ax3.set_title("Data3")
ax4.set_title("Data4")

fig
```

  * 그래프 간격 조절


```python
fig.tight_layout()

fig
```

### # 기본 시각화 그리기


```python
import matplotlib as mpl
import matplotlib.pylab as plt
```


```python
# 리스트 1,2,3,4 를 만들어서 l(소문자 엘) 변수에 넣기

l = [1,2,3,4]
```

#### cf) plot에는 리스트 형태를 넣을 수 있다.


```python
plt.plot(l)
```

### # 시각화 옵션들


```python
plt.title("Line")

plt.plot([1,2,3], [1,2,3], marker="s")

plt.show()
```


### # 범례 추가 및 출력
  * 그래프 관련 문장은 한 cell 안에서 다 써야한다.
    - 예) plt.legend(), plt.show()


```python
plt.title("Legend")
plt.plot([1,2,3,4], label="asc")
plt.plot([4,3,2,1], label="desc")

plt.legend() # 범례 표시
plt.show() # 그래프 출력
```

### # 선 색 지정
  * default는 파랑색


```python
plt.plot([1,2,3], [1,2,3], color="red")

plt.show()
```

### # x, y축 이름 지정


```python
plt.plot([1,2,3], [1,2,3], color="red")

plt.xlabel("X Value")

plt.ylabel("Y Value")

plt.show()
```

### # 선 색상, 선 스타일 변경


```python
plt.plot([1,2,3,4], color="r", linestyle = "-", label = "line")

plt.plot([4,3,2,1], color="g", linestyle = "--", label = "dashed")

plt.plot([2,1,1,2], color="b", linestyle = ":", label = "datted")

# 범레 출연
plt.legend()
plt.show()
```


### # x,y축 범위 지정

  * c : 색상
  * lw : 선의 굵기
  * ls : 선의 스타일
  * marker : 표시할 형태
  * ms : 마커의 전체 크기
  * mec : 마커의 데두리 색상
  * mew : 마커의 테두리 사이즈
  * mfc : 마커 내부의 채우기 색상


```python
# 한글 폰트 안깨지게 하기
plt.rc('font', family = 'Malgun Gothic')

plt.title("x, y 레인지")

plt.plot([10,20,30,40],
         [1,4,9,16],
         c = "b", lw=5, ls="--", marker = "o", ms = 15,
         mec="g", mew = 5, mfc = "r")

# x축의 범위 지정
plt.xlim(0,50)

# y축의 범위 지정
plt.ylim(-10,30)

plt.show()
```
   

### # tips 데이터셋 불러드리기


```python
tips = sns.load_dataset("tips")

tips
```


```python
tips.plot()
```




### #  선그래프


```python
tips.plot(kind = "line")
```


### # 히스토그램 그래프


```python
tips.plot(kind = "hist")
```


### # 박스플롯 그래프


```python
tips.plot(kind = "box")
```


### # 특정 컬럼 그래프


```python
plt.plot(tips["total_bill"])
```


### # x,y 축을 특정 컬럼으로 지정하고 막대그래프 시각화


```python
plt.bar(tips["sex"], tips["total_bill"])
```


### # 산점도 그래프


```python
plt.scatter(tips["total_bill"], tips["tip"], marker = "*")
```

### # 히스토그램
  * 히스토그램은 하나의 컬럼에 대해서만 사용가능


```python
plt.hist(tips["total_bill"])
```

```python
plt.hist(tips["day"])
```

### # 붓꽃, 타이타닉호, tips, 여객운송 데이터셋 불러드리기


```python
iris = sns.load_dataset("iris")

titanic = sns.load_dataset("titanic")

tips = sns.load_dataset("tips")

flights = sns.load_dataset("flights")
```


```python
print(iris)
print(titanic)
print(tips)
print(flights)
```

### # sns.set_palette(" ") 색깔 종류
  * deep, muted, paste, bright, dar, colorblind


```python
sns.set_palette("dark")

sns.stripplot(data=tips, x="day", y="total_bill")

plt.title("팁 데이터셋")

plt.ylabel("요금")

plt.xlabel("요일")
```

### # sns 막대그래프
  * 오차막대(error bar) : 오차 막대의 길이는 작을수록 좋다.


```python
sns.set_palette("pastel")

sns.barplot(data = tips, x="sex", y="tip")


# 오차막대를 지우는 방법
# sns.barplot(data = tips, x="sex", y="tip", estimator = len)
```

### # barplot에서 x,y축 기본에 분류를 한 개 더 추가하고 싶을 때
  * 1개까지만 추가 가능


```python
sns.barplot(data = tips, x="sex", y="tip", hue="day")
```


### # count 그래프


```python
sns.catplot("day",  kind = "count", data = tips)
```

```python
sns.boxplot(x="sex", y="tip", data=tips)
```



### # 수직, 수평 조정


```python
sns.boxplot(data=tips, orient="h")

# sns.boxplot(data=tips, orient="v")
```


### # 러그(rug)플롯
  * 데이터 위치를 x축 위에 작은 선분(rug)으로 나타내어 실제 데이터들의 위치를 보여준다.


```python
sns.rugplot(tips["tip"], height=0.5)
```


### # 커널밀도 그래프


```python
sns.kdeplot(tips["tip"])

sns.distplot(tips["tip"])
```
-----
# [01_Data_Preprocessing]

# 관광객 데이터 전처리

### # 데이터 불러오기
  * kto_201901.xlsx 파일 불러오기
  * 컬러명과 컬럼에 대한 데이터만 불러오기


```python
import pandas as pd
```


```python
# [자동화할 예정]

# 파일 경로 지정
file_path = "./files/kto_201901.xlsx"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
kto_201901 = pd.read_excel(file_path,
                           header=1, # 컬럼명 위치. 기본값은 0.
                          skipfooter = 4, # 제일 밑 행에서 부터 삭제할 행 번호
                           usecols = "A:G" # 사용할 열 선택
                          ) 
```


### # 결측치 유무 확인


```python
kto_201901.info()
```


### # 기초통계 확인
  * 의심스러운 값 확인
    - 이 경우 최소값에 0이 보인다.


```python
kto_201901.describe()
```




### # 0인 값을 가진 데이터 조회
  * \ : jupyter에서 줄바꿈 명령어


```python
condition = (kto_201901["관광"] == 0) \
           | (kto_201901["상용"] == 0) \
           | (kto_201901["공용"] == 0) \
           | (kto_201901["유학/연수"] == 0)

condition
```



```python
kto_201901[condition]
```


### # 다른 파일들 합치기
  * 년월로 구분되어 있기 때문에 합쳤을 때 데이터를 구분하기 위해 년월 데이터를 추가한다.
    - 컬럼명 : 기준년월
    - 값 : 2019-01


```python
# [자동화할 예정]

kto_201901["기준년월"] = "2019-01"
```


## 특정 데이터 삭제
  * 국적 컬럼에 국가가 아닌 데이터들이 보인다.\
    eg) 아시아주, 교포 소계 등

### # 국적 컬럼의 값에서 고유한 값(중복값 제거)들만 조회


```python
kto_201901["국적"].unique()
```

    array(['아시아주', '일본', '대만', '홍콩', '마카오', '태국', '말레이시아', '필리핀', '인도네시아',
           '싱가포르', '미얀마', '베트남', '인도', '스리랑카', '파키스탄', '방글라데시', '캄보디아', '몽골',
           '중국', '이란', '이스라엘', '터키', '우즈베키스탄', '카자흐스탄', 'GCC', '아시아 기타', '미주',
           '미국', '캐나다', '멕시코', '브라질', '미주 기타', '구주', '영국', '독일', '프랑스',
           '네덜란드', '스웨덴', '스위스', '이탈리아', '덴마크', '노르웨이', '벨기에', '오스트리아', '스페인',
           '그리스', '포르투갈', '핀란드', '아일랜드', '우크라이나', '러시아', '크로아티아', '루마니아',
           '불가리아', '폴란드', '구주 기타', '대양주', '오스트레일리아', '뉴질랜드', '대양주 기타',
           '아프리카주', '남아프리카공화국', '아프리카 기타', '기타대륙', '국적미상', '교포소계', '교포'],
          dtype=object)



### # 대륙의 값들을 관리하는 목록 만들기
  * 기준이 없기 때문에 기준을 만들어야 한다.
  * 삭제할 데이터 값을 리스트로 만들기


```python
# [자동화할 예정]

continents_list = ["아시아주", "미주", "구주", "대양주",
                   "아프리카주", "기타대륙", "교포소계"]
```

### # 만들어 놓은 리스트에 포함되어 있는 값 조회


```python
# [자동화할 예정]

condition = kto_201901["국적"].isin(continents_list)
```

### # 만들어 놓은 리스트에 포함되어 있는 값을 제외하고 조회


```python
# [자동화할 예정]

kto_201901[condition == False]
```



```python
# [자동화할 예정]

kto_201901_country = kto_201901[condition == False]
```


```python
kto_201901_country["국적"].unique()
```




    array(['일본', '대만', '홍콩', '마카오', '태국', '말레이시아', '필리핀', '인도네시아', '싱가포르',
           '미얀마', '베트남', '인도', '스리랑카', '파키스탄', '방글라데시', '캄보디아', '몽골', '중국',
           '이란', '이스라엘', '터키', '우즈베키스탄', '카자흐스탄', 'GCC', '아시아 기타', '미국',
           '캐나다', '멕시코', '브라질', '미주 기타', '영국', '독일', '프랑스', '네덜란드', '스웨덴',
           '스위스', '이탈리아', '덴마크', '노르웨이', '벨기에', '오스트리아', '스페인', '그리스', '포르투갈',
           '핀란드', '아일랜드', '우크라이나', '러시아', '크로아티아', '루마니아', '불가리아', '폴란드',
           '구주 기타', '오스트레일리아', '뉴질랜드', '대양주 기타', '남아프리카공화국', '아프리카 기타',
           '국적미상', '교포'], dtype=object)



### # 삭제한 데이터로 인해 인덱스 번호가 비어있는 행이 보인다.
  * 인덱스 번호 재배열(0부터 순서대로)
  * kto_201901_country_newindex 변수에 저장한다


```python
# [자동화할 예정]

kto_201901_country_newindex = kto_201901_country.reset_index(drop=True)
```


```python
kto_201901_country_newindex
```

## 국가별 대륙 정보 추가

### # 대륙별 국가 수를 세어서 컬럼 직접 만들기


```python
asia = ['일본', '대만', '홍콩', '마카오', '태국', '말레이시아', '필리핀', '인도네시아', '싱가포르',
       '미얀마', '베트남', '인도', '스리랑카', '파키스탄', '방글라데시', '캄보디아', '몽골', '중국',
       '이란', '이스라엘', '터키', '우즈베키스탄', '카자흐스탄', 'GCC', '아시아 기타']

america = ['미국', '캐나다', '멕시코', '브라질', '미주 기타']

europe = [ '영국', '독일', '프랑스', '네덜란드', '스웨덴','스위스', '이탈리아', '덴마크', '노르웨이', '벨기에', '오스트리아', '스페인', '그리스', '포르투갈',
       '핀란드', '아일랜드', '우크라이나', '러시아', '크로아티아', '루마니아', '불가리아', '폴란드',
       '구주 기타']

oceania = ['오스트레일리아', '뉴질랜드', '대양주 기타']

africa = ['남아프리카공화국', '아프리카 기타']

etc = ['국적미상']

gyopo = ['교포']

print(len(asia))
print(len(america))
print(len(europe))
print(len(oceania))
print(len(africa))
print(len(etc))
print(len(gyopo))

# 아시아(25), 아메리카(5), 유럽(23), 오세아니아(3), 아프리카(2), 기타대륙, 교포
```


### # 문자열 * 숫자 = 문자열 반복


```python
# [자동화할 예정]

continents = ["아시아"] * 25 + ["아메리카"] * 5 + ["유럽"] * 23 + ["오세아니아"] * 3 + \
["아프리카"] * 2 + ["기타대륙"] + ["교포"]
```

### # '대륙' 컬럼 추가


```python
# [자동화할 예정]

kto_201901_country_newindex["대륙"] = continents
```

### # 국가별 관광객 비율
  * "관광객비율(%)" 이름으로 컬럼 만든다.
  * 비율값은 소수점 1자리까지만


```python
# [자동화할 예정]

kto_201901_country_newindex["관광객비율(%)"] = round(
                                                    kto_201901_country_newindex["관광"] /
                                                    kto_201901_country_newindex["계"] * 100,
                                                    1)
```


### # 전체 관광객 대비 국가별 관광객 수 비율
  * 컬럼명 : 전체비율(%)
  * 값 : 각 국가 관강객 수 / 전세계 관광객 수 * 100
  * 소수점 1자리까지


```python
# [자동화할 예정]

kto_201901_country_newindex["전체비율(%)"] = round(kto_201901_country_newindex["관광"]/
                                                    sum(kto_201901_country_newindex["관광"]) * 100,
                                                    1)
```

### # 국가별 관광을 목적으로 입국하는 비율이 높은 상위 5개 나라 조회


```python
kto_201901_country_newindex.sort_values(by = ["전체비율(%)"], axis = 0, ascending = False).head(5)
```


## 115개 파일을 합치기 자동화
  * 파일 불러오기
    - 파일 이름 패턴 파악
      + kto_201001.xlsx
  * 자동화가 필요한 커리마다 '# [자동화할 예정]' 표시해두기

### # 년월 목록 출력


```python
for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        yymm = "{}{}".format(yy, mm)
        print(yymm)
```


### # yyyymm 형태로 출력하기 위해 zfill 함수를 사용
  * 20101 형태로 나오기 때문
    - 201001 형태로 나와야 한다.


```python
for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        yymm = "{}{}".format(yy, str(mm).zfill(2))
        print(yymm)
```

### # 116개 파일 불러오기
  * 파일을 하나씩 파일 불러온 후 df라는 데이터프레임 변수에 저장
  * len(df)로 각각의 행의 개수를 출력


```python
for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        file_path = "./files/kto_{}{}.xlsx".format(yy, str(mm).zfill(2))
        df = pd.read_excel(file_path,
                           header = 1,
                           skipfooter = 4,
                           usecols = "A:G")
        print(len(df))
```


### # '# [자동화할 예정]'이라고 표시해둔 쿼리 하나씩 적용


```python
for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        file_path = "./files/kto_{}{}.xlsx".format(yy, str(mm).zfill(2))
        df = pd.read_excel(file_path,
                           header = 1,
                           skipfooter = 4,
                           usecols = "A:G")
        
        df["기준년월"] = "{}-{}".format(yy, str(mm).zfill(2))
        
        continents_list = ["아시아주", "미주", "구주", "대양주",
                   "아프리카주", "기타대륙", "교포소계"]
        
        condition = df["국적"].isin(continents_list)
        
        df[condition == False]
        
        df_country = df[condition == False]
        
        df_country_newindex = df_country.reset_index(drop=True)
        
        continents = ["아시아"] * 25 + ["아메리카"] * 5 + ["유럽"] * 23 + ["오세아니아"] * 3 + \
["아프리카"] * 2 + ["기타대륙"] + ["교포"]
        
        df_country_newindex["대륙"] = continents
        
        df_country_newindex["관광객비율(%)"] = round(
                                                   df_country_newindex["관광"] /
                                                    df_country_newindex["계"] * 100,
                                                    1)
        
        df_country_newindex["전체비율(%)"] = round(df_country_newindex["관광"]/
                                                    sum(df_country_newindex["관광"]) * 100,
                                                    1)
        print(df_country_newindex.head(1))
```


### # 마지막에 2019년 9월 파일이 없어서 불러드릴 수 없다는 오류 수정
  * FileNotFoundError: [Errno 2]  No such file or directory: './files/kto_201909.xlsx'
  * try except 함수 
    - for문에서 오류없이 진행할 수 있는 커리만 진행


```python
for yy in range(2010, 2020) :
    for mm in range(1,13) : 

##### 오류가 있을만한 쿼리에 시작

        try :
            file_path = "./files/kto_{}{}.xlsx".format(yy, str(mm).zfill(2))
            df = pd.read_excel(file_path,
                               header = 1,
                               skipfooter = 4,
                               usecols = "A:G")

            df["기준년월"] = "{}-{}".format(yy, str(mm).zfill(2))

            continents_list = ["아시아주", "미주", "구주", "대양주",
                       "아프리카주", "기타대륙", "교포소계"]

            condition = df["국적"].isin(continents_list)

            df[condition == False]

            df_country = df[condition == False]

            df_country_newindex = df_country.reset_index(drop=True)

            continents = ["아시아"] * 25 + ["아메리카"] * 5 + ["유럽"] * 23 + ["오세아니아"] * 3 + \
    ["아프리카"] * 2 + ["기타대륙"] + ["교포"]

            df_country_newindex["대륙"] = continents

            df_country_newindex["관광객비율(%)"] = round(
                                                       df_country_newindex["관광"] /
                                                        df_country_newindex["계"] * 100,
                                                        1)

            df_country_newindex["전체비율(%)"] = round(df_country_newindex["관광"]/
                                                        sum(df_country_newindex["관광"]) * 100,
                                                        1)
            print(df_country_newindex.head(1))

##### 오류가 있을 때 무시

        except : 
            pass
```


### # 모든 파일 다 붙이기
  * append : 데이터를 밑으로 붙이기
    - concat 하고 차이점 : concat은 자신의 인덱스 번호 그대로 가져오게 된다.
    - merge 하고 차이점 : merge는 옆으로 붙이는 함수


```python
##### 비어있는 데이터 프레임 만들어 놓기

df_all = pd.DataFrame()

for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        try :
            file_path = "./files/kto_{}{}.xlsx".format(yy, str(mm).zfill(2))
            df = pd.read_excel(file_path,
                               header = 1,
                               skipfooter = 4,
                               usecols = "A:G")

            df["기준년월"] = "{}-{}".format(yy, str(mm).zfill(2))

            continents_list = ["아시아주", "미주", "구주", "대양주",
                       "아프리카주", "기타대륙", "교포소계"]

            condition = df["국적"].isin(continents_list)

            df[condition == False]

            df_country = df[condition == False]

            df_country_newindex = df_country.reset_index(drop=True)

            continents = ["아시아"] * 25 + ["아메리카"] * 5 + ["유럽"] * 23 + ["오세아니아"] * 3 + \
    ["아프리카"] * 2 + ["기타대륙"] + ["교포"]

            df_country_newindex["대륙"] = continents

            df_country_newindex["관광객비율(%)"] = round(
                                                       df_country_newindex["관광"] /
                                                        df_country_newindex["계"] * 100,
                                                        1)

            df_country_newindex["전체비율(%)"] = round(df_country_newindex["관광"]/
                                                        sum(df_country_newindex["관광"]) * 100,
                                                        1)
            
##### for문이 한 번 돌 때마다 생기는 데이터를 자기 자신에게 붙이는 작업
            df_all = df_all.append(df_country_newindex, ignore_index = True)
            
        except : 
            pass
```


### # 이 작업을 함수로 만든다.
  * 함수이름 : create_kot_data


```python
def create_kot_data(yy,mm) :
    file_path = "./files/kto_{}{}.xlsx".format(yy, str(mm).zfill(2))
    df = pd.read_excel(file_path,
                       header = 1,
                       skipfooter = 4,
                       usecols = "A:G")

    df["기준년월"] = "{}-{}".format(yy, str(mm).zfill(2))

    continents_list = ["아시아주", "미주", "구주", "대양주",
               "아프리카주", "기타대륙", "교포소계"]

    condition = df["국적"].isin(continents_list)

    df[condition == False]

    df_country = df[condition == False]

    df_country_newindex = df_country.reset_index(drop=True)

    continents = ["아시아"] * 25 + ["아메리카"] * 5 + ["유럽"] * 23 + ["오세아니아"] * 3 + \
["아프리카"] * 2 + ["기타대륙"] + ["교포"]

    df_country_newindex["대륙"] = continents

    df_country_newindex["관광객비율(%)"] = round(
                                               df_country_newindex["관광"] /
                                                df_country_newindex["계"] * 100,
                                                1)

    df_country_newindex["전체비율(%)"] = round(df_country_newindex["관광"]/
                                                sum(df_country_newindex["관광"]) * 100,
                                                1)
    return df_country_newindex

##### print(df_country_newindex) 를 하게 되면 출력을 여러 번 하는 거지 데이터를 합치는 작업을 하지는 못한다.
##### return은 데이터 자체를 보내주는 작업
```


```python
df_all = pd.DataFrame()

for yy in range(2010, 2020) :
    for mm in range(1,13) : 
        try :
            temp = create_kot_data(yy,mm)
            
            df_all = df_all.append(temp, ignore_index = True)
        except :
            pass
```



### # 최종본 저장
  * 파일 이름 : kto_total.xlsx


```python
df_all.to_excel("./files/kto_total.xlsx", index = False)
```


```python
df_temp = pd.read_excel("./files/kto_total.xlsx")

df_temp
```
-----

# [02_Visualization]

# 데이터 시각화 및 인사이트 도출

### # 데이터 불러오기


```python
import pandas as pd
```


```python
file_path = "./files/kto_total.xlsx"

# 파일을 읽어 들여서 DataFrame 형태로 읽어드리기
df = pd.read_excel(file_path) 
```

## 시각화에 필요한 라이브러리들 장착

### # 시각화 라이브러리 추가


```python
import matplotlib.pyplot as plt
```

### # 한글처리 라이브러리 추가
  * 1번 혹은 2번 중에 하나만 실행하면 된다.

#### 1. 


```python
plt.rc('font', family = 'Malgun Gothic')
```

#### 2. 그래프에 있는 한글이 깨지지 않도록 하는 라이브러리


```python
from matplotlib import font_manager, rc
```

### # 시스템 OS 확인을 위한 라이브러리


```python
import platform
```

### # 운영체제별 폰트 정의


```python
if platform.system() == "Windows" :
    path = "c:/Windows/Fonts/malgun.ttf"
    font_name = font_manger.FontProperties(fname=path).get_name()
    rc("font", family = font_name)
    
elif platform.system() == "Darwin" :
    rc("font", family = "AppleGothic")
    # plt.rcParams['axes.unicode_minus'] = False   # 맥(ios)을 쓰는 경우 써야되는 문장
            
else : 
    print("Check your OS system...")
```

### # 중국 국적 데이터 조회


```python
condition = (df["국적"] == "중국")
```

### # 중국 관광객에 대한 년월별 추이 시각화분석
  * 시계열 그래프 사용


```python
plt.plot(df_filter["기준년월"], df_filter["관광"])

plt.show()
```

### # 그래프 꾸미기


```python
plt.figure(figsize = (12, 4)) # 그래프 크기 조절 (너비, 높이)
plt.plot(df_filter["기준년월"], df_filter["관광"]) # 그래프에 데이터 넣기
plt.title("중국 국적에 대한 관광객 추이 분석") # 그래프 제목 넣기
plt.xlabel("기준년월") # x축에 대한 라벨 추가
plt.ylabel("관광객수") # y축에 대한 라벨 추가
plt.xticks(["2010-01", "2011-01", "2012-01", "2013-01", "2014-01",
           "2015-01", "2016-01", "2017-01", "2018-01", "2019-01"]) # x축에 대한 눈금 조정
plt.show() # 그래프 출력
```

### # 전체대비 관광객 비율 top5


```python
df.sort_values(by = ["전체비율(%)"], axis = 0, ascending = False).head(5)
```


### # 중국, 일본, 대만, 미국, 홍콩 각각에 대한 기준년월별 관광객 추이 분석

#### 1. 하나하나 직접 만든다.


```python
condition = (df["국적"] == "일본")
condition

df_filter = df[condition]

plt.rc('font', family = 'Malgun Gothic')
plt.figure(figsize = (12, 4))
plt.plot(df_filter["기준년월"], df_filter["관광"])
plt.title("일본에 대한 기준년월별 관광객 추이 분석")
plt.xlabel("기준년월")
plt.ylabel("관광객수")

plt.xticks(["2010-01", "2011-01", "2012-01", "2013-01", "2014-01",
           "2015-01", "2016-01", "2017-01", "2018-01", "2019-01"])

plt.show()
```

#### 2. for문을 돌린다.

  * "{변수1}{변수2}".format(변수1, 변수2)


```python
# 기준 만들기

cntry_list = ["중국", "일본", "대만", "미국", "홍콩"]

for cntry in cntry_list :
    
    condition = (df["국적"] == cntry)
    condition

    df_filter = df[condition]

    plt.rc('font', family = 'Malgun Gothic')
    plt.figure(figsize = (12, 4))
    plt.plot(df_filter["기준년월"], df_filter["관광"])
    plt.title("[{}]에 대한 기준년월별 관광객 추이 분석".format(cntry))
    plt.xlabel("기준년월")
    plt.ylabel("관광객수")

    plt.xticks(["2010-01", "2011-01", "2012-01", "2013-01", "2014-01",
               "2015-01", "2016-01", "2017-01", "2018-01", "2019-01"])

    plt.show()
    
```


```python
country = ("중국", "일본", "대만", "미국", "홍콩")

for aa in country :
    condition = (df["국적"] == aa)
    df_filter = df[condition]
    plt.rc('font', family = 'Malgun Gothic')
    plt.figure(figsize = (12, 4))
    plt.plot(df_filter["기준년월"], df_filter["관광"])
    plt.title(aa + "에 대한 기준년월별 관광객 추이 분석")
    plt.xlabel("기준년월")
    plt.ylabel("관광객수")
    plt.xticks(["2010-01", "2011-01", "2012-01", "2013-01", "2014-01",
               "2015-01", "2016-01", "2017-01", "2018-01", "2019-01"])
    plt.show()
```

### # 히트맵 : 전체 시계열 데이터에 대한 이슈를 한눈에 보기
  * 변수 : 3개 필요

### # 년도와 월만 조회
  * 문자열 자르기


```python
df["년도"] = df["기준년월"].str.slice(0,4)
df["월"] = df["기준년월"].str.slice(5,7)
```

### # 히트맵 그리는 순서
  1. 피봇으로 데이터 집계
  2. 피봇 결과를 히트맵에 적용

### # 피봇 데이터 만들기


```python
df_pivot = df_filter.pivot_table(values = "관광",
                     index = "년도",
                     columns = "월")
```

### # 히트맵 그리기
  * 시본(seaborn) 라이브러리를 함께 사용해야 한다.


```python
import seaborn as sns
```


```python
plt.figure(figsize = (16, 10)) # 그래프 크기 설정

sns.heatmap(df_pivot, # 피봇 데이터 넣어서 그래프 그리기
            annot = True, # True = 수치 표시, False = 수치 생략
            fmt = ".0f", # fmt=".0f" 옵션을 하면 소숫점 0자리, "0.1f"는 소숫점 1자리까지 표현.
            cmap = "rocket_r") 

plt.title("년/월별 [중국] 관광객 히트맵 시각화 분석") # 타이틀 넣기
          
plt.show() # 보여주기
```

### # "중국", "일본", "대만", "미국", "홍콩" 히트맵 자동화


```python
cntry_list = ["중국", "일본", "대만", "미국", "홍콩"]

for cntry in cntry_list :
    
    condition = (df["국적"] == cntry)
    condition

    df_filter = df[condition]
    
    df_pivot = df_filter.pivot_table(values = "관광",
                     index = "년도",
                     columns = "월")

    plt.figure(figsize = (10, 10)) # 그래프 크기 설정

    sns.heatmap(df_pivot, # 피봇 데이터 넣어서 그래프 그리기
                annot = True,
                fmt = ".0f",
                cmap = "rocket_r") 

    plt.title("년/월별 [{}] 관광객 히트맵 시각화 분석".format(cntry)) # 타이틀 넣기

    plt.show() # 보여주기
```



## 해석

### # 트랜드 : 
### # 계절적 :
### # 이벤트(인사이트, 이슈) : 

-----

# [01_데이터이해_및_분석요소도출]

# txt 파일 읽어 들이기


```python
import pandas as pd
```


```python
# 20Table

df_20TABLE = pd.read_csv("./files_org/SAMPLE_DB_20TABLE_2013.txt",
                         sep = ",") # 쉼표로 구분한다.

# 30Table

df_30TABLE = pd.read_csv("./files_org/SAMPLE_DB_30TABLE_2013.txt",
                         sep = ",") # 쉼표로 구분한다.

# 40Table

df_40TABLE = pd.read_csv("./files_org/SAMPLE_DB_40TABLE_2013.txt",
                         sep = ",") # 쉼표로 구분한다.

# 53Table

df_53TABLE = pd.read_csv("./files_org/SAMPLE_DB_53TABLE_2013.txt",
                         sep = ",") # 쉼표로 구분한다.
```

## 컬럼명 일괄 변경
  * 메타정의서에 있는 데이터랑 mapping

### # 메타정의서에서 컬럼명 가지고 오기


```python
df_20TABLE_col = pd.read_excel("./files_org/표본자료 변수 테이블(2012-2013).xlsx",
                              sheet_name = "20table_명세서일반내역", # 사용할 sheet 이름 지정
                              usecols = "A, D") # 사용할 특정 열 지정

df_30TABLE_col = pd.read_excel("./files_org/표본자료 변수 테이블(2012-2013).xlsx",
                              sheet_name = "30table_진료내역", # 사용할 sheet 이름 지정
                              usecols = "A, D") # 사용할 특정 열 지정

df_40TABLE_col = pd.read_excel("./files_org/표본자료 변수 테이블(2012-2013).xlsx",
                              sheet_name = "40table_상병", # 사용할 sheet 이름 지정
                              usecols = "A, D") # 사용할 특정 열 지정

df_53TABLE_col = pd.read_excel("./files_org/표본자료 변수 테이블(2012-2013).xlsx",
                              sheet_name = "53table_처방전상세내역", # 사용할 sheet 이름 지정
                              usecols = "A, D") # 사용할 특정 열 지정
```

### # 데이터프레임 형태를 딕셔너리 형태로 변환


```python
df_20TABLE_col.to_dict("records")
```



### # 딕셔너리 형태로 전환한 데이터를 새로운 변수에 저장


```python
df_20TABLE_col_list = df_20TABLE_col.to_dict("records")
```

### # 딕셔너리에 새로운 key 값과 value 값을 만드는 방법

1.


```python
d = dict(a=1, b=2, c=3)
```

2.


```python
d = {}

d["key1"] = 3
d["key2"] = 4
```


```python
d
```




    {'key1': 3, 'key2': 4}



### # for문으로 자동화

#### 방법 1.


```python
df_20TABLE_col_dict = {} # 새로운 딕셔너리 만들기


for idx in range(0, len(df_20TABLE_col_list)) :
    df_20TABLE_col_dict[df_20TABLE_col_list[idx]["변수명"]] = df_20TABLE_col_list[idx]["표준한글컬럼명"]
```

#### 방법 2.


```python
new_dict_20 = {}

for dict_kv in df_20TABLE_col_list :
    new_dict_20[dict_kv["변수명"]] = dict_kv["표준한글컬럼명"]
```

### # rename 함수로 컬럼명 일괄 변경


```python
df_20TABLE_kor = df_20TABLE.rename(columns = new_dict_20)
```

### # 파일로 저장
  * 인덱스 번호 새로 부여 하지 않기


```python
df_20TABLE_kor.to_excel("./files_new/df_20TABLE_kor_명세서일반내역.xlsx",
                        index = False)
```

### # 나머지도 변경 및 저장


```python
# 30TABLE 

df_30TABLE_col.to_dict("records") #딕셔너리 형태로 전환

df_30TABLE_col_list = df_30TABLE_col.to_dict("records") # 딕셔너리 형태로 전환한 데이터를 새로운 변수에 저장

new_dict_30 = {}

for dict_kv in df_30TABLE_col_list :
    new_dict_30[dict_kv["변수명"]] = dict_kv["표준한글컬럼명"] # for문으로 자동화

df_30TABLE_kor = df_30TABLE.rename(columns = new_dict_30) # rename 함수로 컬럼명 일괄 변경

# 40TABLE

df_40TABLE_col.to_dict("records") #딕셔너리 형태로 전환

df_40TABLE_col_list = df_40TABLE_col.to_dict("records") # 딕셔너리 형태로 전환한 데이터를 새로운 변수에 저장

new_dict_40 = {}

for dict_kv in df_40TABLE_col_list :
    new_dict_40[dict_kv["변수명"]] = dict_kv["표준한글컬럼명"] # for문으로 자동화

df_40TABLE_kor = df_40TABLE.rename(columns = new_dict_40) # rename 함수로 컬럼명 일괄 변경

# 53TABLE

df_53TABLE_col.to_dict("records") #딕셔너리 형태로 전환

df_53TABLE_col_list = df_53TABLE_col.to_dict("records") # 딕셔너리 형태로 전환한 데이터를 새로운 변수에 저장

new_dict_53 = {}

for dict_kv in df_30TABLE_col_list :
    new_dict_53[dict_kv["변수명"]] = dict_kv["표준한글컬럼명"] # for문으로 자동화

df_53TABLE_kor = df_53TABLE.rename(columns = new_dict_53) # rename 함수로 컬럼명 일괄 변경

# 파일로 저장

df_30TABLE_kor.to_excel("./files_new/df_30TABLE_kor_진료내역.xlsx", index = False)
df_40TABLE_kor.to_excel("./files_new/df_40TABLE_kor_상병.xlsx", index = False)
df_53TABLE_kor.to_excel("./files_new/df_53TABLE_kor_처방전상세내역.xlsx", index = False)
```

-----

# [02 데이터전처리_가공]

# 데이터 전처리 및 가공
  * 전처리(cleansing)
    - 이상치, 결측치, 중복데이터

### # 파일 불러오기
  * df_20TABLE_kor_명세서일반내역.xlsx


```python
import pandas as pd
```


```python
# 20Table

df_20TABLE_org = pd.read_excel("./files_org/df_20TABLE_kor_명세서일반내역.xlsx")
```


```python
df_20TABLE_org
```


### # 여러 컬럼 한 번에 불러오기
  * 수진자 연령, 요양개시 일자, 심결본인부담금


```python
df_20TABLE_org[["수진자연령", "요양개시일자", "심결본인부담금"]]
```


### # 데이터프레임 새로 만들기
  * 데이터프레임 이름 : df_month_age

방법 1 : 직접 만들기


```python
df_month_age = pd.DataFrame()

df_month_age["수진자연령"] = df_20TABLE_org["수진자연령"]
df_month_age["요양개시일자"] = df_20TABLE_org["요양개시일자"]
df_month_age["심결본인부담금"] = df_20TABLE_org["심결본인부담금"]
```

방법 2 : 변수 만들어서 넣기


```python
df_month_age = df_20TABLE_org[["수진자연령", "요양개시일자", "심결본인부담금"]]
```

방법 3 : pd.DataFrame 함수 사용


```python
df_month_age = pd.DataFrame(df_20TABLE_org, 
                            columns = ["수진자연령", "요양개시일자", "심결본인부담금"])
```
    

### # 연령대 나누기
  * 9세 이하부터 10살 단위로 100세 이상까지로 
  * 조건식 묶는 방법
    - tips[(tips["sex"] == 'Male') & (tips["smoker"] == 'No')]


```python
df_month_age[(df_month_age["수진자연령"] < 10)]
df_month_age[(df_month_age["수진자연령"] >= 10) & (df_month_age["수진자연령"] < 20)]
df_month_age[(df_month_age["수진자연령"] >= 20) & (df_month_age["수진자연령"] < 30)]
df_month_age[(df_month_age["수진자연령"] >= 30) & (df_month_age["수진자연령"] < 40)]
df_month_age[(df_month_age["수진자연령"] >= 40) & (df_month_age["수진자연령"] < 50)]
df_month_age[(df_month_age["수진자연령"] >= 50) & (df_month_age["수진자연령"] < 60)]
df_month_age[(df_month_age["수진자연령"] >= 60) & (df_month_age["수진자연령"] < 70)]
df_month_age[(df_month_age["수진자연령"] >= 70) & (df_month_age["수진자연령"] < 80)]
df_month_age[(df_month_age["수진자연령"] >= 80) & (df_month_age["수진자연령"] < 90)]
df_month_age[(df_month_age["수진자연령"] >= 90) & (df_month_age["수진자연령"] < 100)]
df_month_age[(df_month_age["수진자연령"] >= 100)]
```

### # 9세 이하 만들기


```python
df_9under = df_month_age[(df_month_age["수진자연령"] < 10)] 

# 인덱스 재배열
df_9under = df_9under.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값은 모두 "9세이하" 넣기

df_9under["연령대"] = "9세이하"

```


### # 20대~ 90대까지 만들기
  * 컬럼값 : 10대, 20대 ... 90대
  * 변수명 : df_10, df_20 ... df_90


```python
# 10대
df_10 = df_month_age[(df_month_age["수진자연령"] >= 10) & (df_month_age["수진자연령"] < 20)]

# 인덱스 재배열
df_10 = df_10.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값 넣기
df_10["연령대"] = "10대"

# -----

# 20대
df_20 = df_month_age[(df_month_age["수진자연령"] >= 20) & (df_month_age["수진자연령"] < 30)]

# 인덱스 재배열
df_20 = df_20.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_20["연령대"] = "20대"

# -----

# 30대
df_30 = df_month_age[(df_month_age["수진자연령"] >= 30) & (df_month_age["수진자연령"] < 40)]

# 인덱스 재배열
df_30 = df_30.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_30["연령대"] = "30대"

# -----

# 40대
df_40 = df_month_age[(df_month_age["수진자연령"] >= 40) & (df_month_age["수진자연령"] < 50)]

# 인덱스 재배열
df_40 = df_40.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_40["연령대"] = "40대"

# -----

# 50대
df_50 = df_month_age[(df_month_age["수진자연령"] >= 50) & (df_month_age["수진자연령"] < 60)]

# 인덱스 재배열
df_50 = df_50.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_50["연령대"] = "50대"

# -----

# 60대
df_60 = df_month_age[(df_month_age["수진자연령"] >= 60) & (df_month_age["수진자연령"] < 70)]

# 인덱스 재배열
df_60 = df_60.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_60["연령대"] = "60대"

# -----

# 70대
df_70 = df_month_age[(df_month_age["수진자연령"] >= 70) & (df_month_age["수진자연령"] < 80)]

# 인덱스 재배열
df_70 = df_70.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_70["연령대"] = "70대"

# -----

# 80대
df_80 = df_month_age[(df_month_age["수진자연령"] >= 80) & (df_month_age["수진자연령"] < 90)]

# 인덱스 재배열
df_80 = df_80.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_80["연령대"] = "80대"

# -----

# 90대
df_90 = df_month_age[(df_month_age["수진자연령"] >= 90) & (df_month_age["수진자연령"] < 100)]

# 인덱스 재배열
df_90 = df_90.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_90["연령대"] = "90대"

# -----

# 100세 이상
df_100over = df_month_age[(df_month_age["수진자연령"] >= 100)]

# 인덱스 재배열
df_100over = df_100over.reset_index(drop=True)

# "연령대" 컬럼 추가 후 값넣기
df_100over["연령대"] = "100세이상"
```

### #  변수들 합치기
  * 새 변수명 : df_month_age_any
  * df_9under ~ df_90 까지 모두 행단위로 추가
  * 인덱스 reset

방법 1. concat 사용


```python
df_month_age_any = pd.concat([df_9under,
                              df_10,
                              df_20,
                              df_30,
                              df_40,
                              df_50,
                              df_60,
                              df_70,
                              df_80,
                              df_90,
                              df_100over], axis = 0)

df_month_age_any = df_month_age_any.reset_index(drop = True)

df_month_age_any
```


방법 2. append 사용


```python
df_month_age_any1 = pd.DataFrame()

df_month_age_any1 = df_month_age_any1.append([df_9under,
                              df_10,
                              df_20,
                              df_30,
                              df_40,
                              df_50,
                              df_60,
                              df_70,
                              df_80,
                              df_90,
                              df_100over])

df_month_age_any1 = df_month_age_any1.reset_index(drop = True)

df_month_age_any1
```

### # 위에 작업 코드 줄여보기


```python
df = pd.DataFrame()

# 9세 이하
df = df_month_age[(df_month_age["수진자연령"] < 10)] 
df["연령대"] = "9세이하"

# 10대 ~ 90대 자동화
for i in range(10,91,10) :
    temp = df_month_age[(df_month_age["수진자연령"] >= i) & (df_month_age["수진자연령"] < i+10)]
    temp["연령대"] = "{}대".format(i)
    df = df.append(temp, ignore_index = True)

# 100세 이상
df_100over = df_month_age[(df_month_age["수진자연령"] >= 100)]
df_100over["연령대"] = "100세이상"
df = df.append(df_100over, ignore_index = True)

# 전체 인덱스 재배열
df = df.reset_index(drop = True)

df
```


# 요양개시일자 처리

### # 요양개시일자에서 월만 추출
  * 값을 문자열로 변환
    - slice는 문자열만 사용 가능

현재 요양개시일자 컬럼은 정수 type이기 때문에 slice 함수를 사용할 수 없다.


```python
df_month_age_any.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 5631 entries, 0 to 5630
    Data columns (total 4 columns):
     #   Column   Non-Null Count  Dtype 
    ---  ------   --------------  ----- 
     0   수진자연령    5631 non-null   int64 
     1   요양개시일자   5631 non-null   object
     2   심결본인부담금  5631 non-null   int64 
     3   연령대      5631 non-null   object
    dtypes: int64(2), object(2)
    memory usage: 176.1+ KB
    

### # apply(str), 혹은 astype(str) 함수 이용


```python
df_month_age_any["요양개시일자"] = df_month_age_any["요양개시일자"].astype(str)
# df_month_age_any["요양개시일자"] = df_month_age_any["요양개시일자"].apply(str)
```

방법 1 : 문자열 타입을 글자 단위로 추출
  * str[ : ]


```python
df_month_age_any["요양개시월"] = df_month_age_any["요양개시일자"].str[4:6]

```



방법 2 : slice 함수 사용


```python
df_month_age_any["요양개시월"] = df_month_age_any["요양개시일자"].str.slice(4, 6)

```

### # 파일로 저장


```python
df_month_age_any.to_excel("./files_org/df_month_age_any_월별연령대별본인부담비용.xlsx", index = False)
```

-----

# [03_데이터시각화]

# 데이터 시각화 분석

### # 월별, 연령대별 본인부담비용 시각화 분석


```python
import pandas as pd
```


```python
df_month_age_any = pd.read_excel("./files_org/df_month_age_any_월별연령대별본인부담비용.xlsx") 

df_month_age_any
```


### # 시각화 라이브러리 


```python
import matplotlib.pyplot as plt
import seaborn as sns
```

### # 월별로 병원을 많이 찾는 연령대 분석
  * 피봇 테이블


```python
pivot_month_age = df_month_age_any.pivot_table(values = "수진자연령",
                            index = "요양개시월",
                            columns = "연령대",
                            aggfunc = "count")
```

### # 피봇테이블에 NaN(결측치) 데이터가 보인다
  * 평균값, 중간값, 0 중에 하나로 대체한다.
  * 0으로 대체한다.


```python
pivot_month_age = pivot_month_age.fillna(0)
```


### # 선그래프


```python
'''
rc가 붙은 함수는 이후에 이 설정을 유지하는 뜻
  * plt.rc("font", family = "Malgun Gothic", size = 10)
'''

# 그래프 크기 지정 (너비, 높이)
plt.rcParams["figure.figsize"] = (20, 10)

# 선의 두께 지정
plt.rcParams["lines.linewidth"] = 2

# 폰트 지정
plt.rc("font", family = "Malgun Gothic", size = 10)

# 데이터 넣기
pivot_month_age.plot()

# y축 이름
plt.ylabel("연령별 수진자수")

# x축 표시할 눈금 범위 지정
plt.xticks([1,2,3,4,5,6,7,8,9,10,11,12])

# 그래프 제목
plt.title("연령 및 월별로 병원을 많이 찾는 연령대 분석")

# 그래프에 grid 선 그리기
plt.grid(True)

# 범례 표시
plt.legend(loc="upper right")

# 그래프 출력
plt.show()
```

### # 히트맵 그리기


```python
plt.figure(figsize = (16, 10)) # 그래프 크기 설정

sns.heatmap(pivot_month_age, # 피봇 데이터 넣어서 그래프 그리기
            annot = True, # True = 수치 표시, False = 수치 생략
            fmt = ".0f", # fmt=".0f" 옵션을 하면 소숫점 0자리, "0.1f"는 소숫점 1자리까지 표현.
            cmap = "rocket_r") 

plt.title("연령 및 월별로 병원을 많이 찾는 연령대 분석") # 타이틀 넣기
          
plt.show() # 보여주기
```


### # 월별 연령대별 본인부담금을 많이 내는 연령대 분석
  * 결과에 대한 해석


```python
pivot_month_age_self = df_month_age_any.pivot_table(values = "심결본인부담금",
                            index = "요양개시월",
                            columns = "연령대",
                            aggfunc = "sum") # 평균을 내면 인원수가 달라지기 때문에 수치에 왜곡이 있을 수 있다.

pivot_month_age_self["90대"] = pivot_month_age_self["90대"].fillna(pivot_month_age_self["90대"].mean())

# 선그래프

# 그래프 크기 지정 (너비, 높이)
plt.rcParams["figure.figsize"] = (20, 10)

# 선의 두께 지정
plt.rcParams["lines.linewidth"] = 2

# 폰트 지정
plt.rc("font", family = "Malgun Gothic", size = 10)

# 데이터 넣기
pivot_month_age_self.plot()

# y축 이름
plt.ylabel("연령별 수진자수")

# x축 표시할 눈금 범위 지정
plt.xticks([1,2,3,4,5,6,7,8,9,10,11,12])

# 그래프 제목
plt.title("연령 및 월별로 병원을 많이 찾는 연령대 분석")

# 그래프에 grid 선 그리기
plt.grid(True)

# 범례 표시
plt.legend(loc="upper right")

# 그래프 출력
plt.show()


# 히트맵
plt.figure(figsize = (16, 10)) # 그래프 크기 설정

sns.heatmap(pivot_month_age_self, # 피봇 데이터 넣어서 그래프 그리기
            annot = True, # True = 수치 표시, False = 수치 생략
            fmt = ".0f", # fmt=".0f" 옵션을 하면 소숫점 0자리, "0.1f"는 소숫점 1자리까지 표현.
            cmap = "rocket_r") 

plt.title("월별 연령대별 본인부담금을 많이 내는 연령대 분석") # 타이틀 넣기
          
plt.show() # 보여주기
```


### # 해석
  * 본인부담금을 가장 많이 내는 연령대는 60대, 70대, 50대, 40대 순이다.
  * 50 ~ 70대는 10 ~ 12월에 본인부담금을 많이 내는 반면, 20대는 1월 ~ 3월, 40대는 8월과 12월에 많이 낸다.
  * 10대에서 부터 서서히 본인부담은 많아지다가 60대에 최고치에 도달하고, 80대부터 본인부담금이 현저히 줄어든다.

-----

# [10day_교통데이터전처리]

## 컬럼명 한글명으로 변환
  * 샘플 trfcard(0) 폴더에 있는 파일을 기준으로 우선 변환


```python
import pandas as pd
```


```python
trfcard = pd.read_csv("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard.csv")

```




```python
# 메타정의서 불러오기
trfcard_col = pd.read_excel("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard_columns.xlsx",
                            header=2,
                            sheet_name = "컬럼 정의서", # 사용할 sheet 이름 지정
                            usecols = "B, C") # 사용할 특정 열 지정

# 메타정의서 데이터를 딕셔너리 형태로 형변환
trfcard_col_list = trfcard_col.to_dict("records")

# 영문 컬럼명과 한글 컬럼명만 출력되도록 딕셔너리 변수 한 개 더 생성

trfcard_col_dict = {}

for idx in range(0, len(trfcard_col_list)) :
    trfcard_col_dict[trfcard_col_list[idx]["컬럼명 (영문)"]] = trfcard_col_list[idx]["컬럼명 (한글)"]
    
# 만들어진 최종 영문 컬럼명별 한글 컬럼명 딕셔너리 변수를 원본 데이터에 일괄 변환
trfcard_kor = trfcard.rename(columns = trfcard_col_dict)

# 엑셀 파일로 최종 저장
trfcard_kor.to_excel("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard_kor.xlsx",
                        index = False)

# 최종 파일 확인
trfcard_kor = pd.read_excel("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard_kor.xlsx")

```


### # 다른 파일 합치기


```python
trfcard_kor_all = pd.DataFrame()

for idx in range(0, 100) :
    trfcard = pd.read_csv("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard ({})/trfcard.csv".format(idx))
        
    trfcard_kor = trfcard.rename(columns = trfcard_col_dict)

    trfcard_kor_all = trfcard_kor_all.append(trfcard_kor, ignore_index = True)

# 인덱스 재배열
trfcard_kor_all = trfcard_kor_all.reset_index(drop=True)

# 엑셀 파일로 최종 저장
trfcard_kor_all.to_csv("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard_kor_최종.csv")

# 최종 파일 확인
trfcard_kor_all = pd.read_csv("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard_kor_최종.csv")
```


### # 주제 선정
  * 노선별 승객연령
  * 승차정류장별 환승

### # 위에 코딩 정답


```python
df_bus_card_org = pd.read_csv("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard.csv")

# 메타정의서 불러오기
trfcard_col = pd.read_excel("./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard (0)/trfcard_columns.xlsx",
                            header=2,
                            sheet_name = "컬럼 정의서", # 사용할 sheet 이름 지정
                            usecols = "B, C") # 사용할 특정 열 지정

# 메타정의서 데이터를 딕셔너리 형태로 형변환
df_bus_card_col_org_dict = trfcard_col.to_dict("records")
```


```python
df_bus_card_col_new_dict = {}

for i in range(0, len(df_bus_card_col_org_dict)) :
    df_bus_card_col_new_dict[df_bus_card_col_org_dict[i]["컬럼명 (영문)"]] = \
    df_bus_card_col_org_dict[i]["컬럼명 (한글)"]
```


```python
df_bus_card_kor = df_bus_card_org.rename(columns = df_bus_card_col_new_dict)
```

### # 분석 주제 정하기 : 분석 요소(컬럼)
  [버스 이용량 분석]
  1. 기준월 및 기준일자별 버스 이용량 분석 비교
  2. 기준일 및 시간대별 버스 이용량 분석 비교
  3. 기준시간 및 시간(분)별 버스 이용량 분석 비교
  
 [버스 내 체류시간]
 
 [승차정류장별 버스내 체류시간]

### # 승차시각 및 하차시각에 대해서 월/일/시간/분을 추출
  * int64 타입이기 때문에 문자타입으로 변환


```python
df_bus_card_kor = df_bus_card_kor.astype({"승차시각" : "str"})

df_bus_card_kor = df_bus_card_kor.astype({"하차시각" : "str"})
```


### # 분석 요서(컬럼)을 추출하여 저장할 데이터프레임 생성


```python
df_bus_card = pd.DataFrame()

df_bus_card["승차시각"] = pd.to_datetime(df_bus_card_kor["승차시각"])

df_bus_card["하차시각"] = pd.to_datetime(df_bus_card_kor["하차시각"])

df_bus_card["승객구분"] = df_bus_card_kor["승객연령"]

df_bus_card["환승여부"] = df_bus_card_kor["환승여부"]

df_bus_card["추가운임여부"] = df_bus_card_kor["추가운임여부"]

df_bus_card["승차정류장"] = df_bus_card_kor["승차정류장"]

df_bus_card["하차정류장"] = df_bus_card_kor["하차정류장"]

df_bus_card
```

### # 버스내 체류시간(분) 컬럼 만들기
  * 버스내체류시간(분) = 하차시간(분) - 승차시각(분)
  * 분만 추출


```python
df_bus_card["버스내체류시간(분)"] = pd.to_datetime(df_bus_card["하차시각"]).dt.minute - \
                                    pd.to_datetime(df_bus_card["승차시각"]).dt.minute

# 이미 승하차 시각을 날짜 타입으로 가져왔기 대문에 pd.to_datetime을 안해도 된다.

# df_bus_card["버스내체류시간(분)"] = (df_bus_card["하차시각"].dt.minute - df_bus_card["승차시각"].dt.minute)

print(df_bus_card.info())
print(df_bus_card.describe())
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 4983 entries, 0 to 4982
    Data columns (total 8 columns):
     #   Column      Non-Null Count  Dtype         
    ---  ------      --------------  -----         
     0   승차시각        4983 non-null   datetime64[ns]
     1   하차시각        4983 non-null   datetime64[ns]
     2   승객구분        4983 non-null   object        
     3   환승여부        4983 non-null   object        
     4   추가운임여부      4983 non-null   object        
     5   승차정류장       4983 non-null   object        
     6   하차정류장       4983 non-null   object        
     7   버스내체류시간(분)  4983 non-null   int64         
    dtypes: datetime64[ns](2), int64(1), object(5)
    memory usage: 311.6+ KB
    None
            버스내체류시간(분)
    count  4983.000000
    mean      0.147702
    std      24.124315
    min     -59.000000
    25%      -5.000000
    50%       8.000000
    75%      15.000000
    max      52.000000
    

### # 최소값에 음수가 보인다(=이상치 발견)

### # 버스체류시간 중에서 음수 개수 확인


```python
df_bus_card[df_bus_card["버스내체류시간(분)"] < 0]
```


### # 이상치 정상화 공식
  * 음수로 나오는 값들 중에서
  * 60 - (원래시간 * -1)


```python
 # loc[행, 열]

df_bus_card.loc[df_bus_card["버스내체류시간(분)"] < 0,
                "버스내체류시간(분)"] \
                                        = 60 - (df_bus_card["버스내체류시간(분)"] * -1)
```


```python
df_bus_card[df_bus_card["버스내체류시간(분)"] < 0]
```


### # 기준년도 데이터 추출해서 새로운 컬럼 만들기
  * 년도, 월, 일 따로


```python
df_bus_card["기준년도"] = df_bus_card["승차시각"].dt.year

df_bus_card["기준월"] = df_bus_card["승차시각"].dt.month

df_bus_card["기준일"] = df_bus_card["승차시각"].dt.day

df_bus_card["기준시간"] = df_bus_card["승차시각"].dt.hour

df_bus_card["기준시간(분)"] = df_bus_card["승차시각"].dt.minute

```

## 모든 데이터셋을 위의 방식으로 통합


```python
from datetime import datetime
```

### # 실행시간 체크 -> 시작시간

### # 여기에 통합할 프로그램 작성


```python
start_date = datetime.today().strftime("%Y-%m-%d %H:%M:%S")

df_bus_card_tot = pd.DataFrame()

for i in range(0, 100, 1) :
    
    # 1. csv, excel 파일 불러오기
    
    file_path1 = "./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard ({})/trfcard.csv".format(i)
    file_path2 = "./01_data_원본/포항시_버스_사용자_교통카드_사용_내역/trfcard ({})/trfcard_columns.xlsx".format(i)
    
    df_bus_card_org = pd.read_csv(file_path1)
    df_bus_card_col_org = pd.read_excel(file_path2, header = 2, usecols="B:C")
    
    # 2. 컬럼명 한글로 바꾸기
    
    df_bus_card_col_org_dict = df_bus_card_col_org.to_dict("records")
    
    df_bus_card_col_new_dict = {}
    
    for i in range(0, len(df_bus_card_col_org_dict), 1) : 
        df_bus_card_col_new_dict[df_bus_card_col_org_dict[i]["컬럼명 (영문)"]] = \
            df_bus_card_col_org_dict[i]["컬럼명 (한글)"]
        
    df_bus_card_kor = df_bus_card_org.rename(columns = df_bus_card_col_new_dict)
    
    # 3. 분석요소 추출 및 추가하기
    
    df_bus_card_kor = df_bus_card_kor.astype({"승차시각" : "str"})
    df_bus_card_kor = df_bus_card_kor.astype({"하차시각" : "str"})
    
    df_bus_card = pd.DataFrame()
    
    df_bus_card["승차시각"] = pd.to_datetime(df_bus_card_kor["승차시각"])
    df_bus_card["하차시각"] = pd.to_datetime(df_bus_card_kor["하차시각"])
    df_bus_card["승객구분"]     = df_bus_card_kor["승객연령"]
    df_bus_card["환승여부"]     = df_bus_card_kor["환승여부"]
    df_bus_card["추가운임여부"] = df_bus_card_kor["추가운임여부"]
    df_bus_card["승차정류장"]   = df_bus_card_kor["승차정류장"]
    df_bus_card["하차정류장"]   = df_bus_card_kor["하차정류장"]
    
    df_bus_card["버스내체류시간(분)"] = df_bus_card["하차시각"].dt.minute - df_bus_card["승차시각"].dt.minute
    
    df_bus_card.loc[(df_bus_card["버스내체류시간(분)"] < 0), "버스내체류시간(분)"] = \
        60 - (df_bus_card["버스내체류시간(분)"] * -1)
    
    df_bus_card["기준년도"]     = df_bus_card["승차시각"].dt.year
    df_bus_card["기준월"]       = df_bus_card["승차시각"].dt.month
    df_bus_card["기준일"]       = df_bus_card["승차시각"].dt.day
    df_bus_card["기준시간"]     = df_bus_card["승차시각"].dt.hour
    df_bus_card["기준시간(분)"] = df_bus_card["승차시각"].dt.minute
    
    # 4. 데이터 추가(통합)하기
    #  * ignore_index = True : 인덱스번호를 자동으로 증가
    
    df_bus_card_tot = df_bus_card_tot.append(df_bus_card, ignore_index=True)


end_date = datetime.today().strftime("%Y-%m-%d %H:%M:%S")

print("전체 실행 시간 : (", start_date, ") ~ (", end_date, ")")

print("전체 데이터셋 개수 : ", len(df_bus_card_tot))
df_bus_card_tot.head()
```

    전체 실행 시간 : ( 2022-03-07 13:49:18 ) ~ ( 2022-03-07 13:51:17 )
    전체 데이터셋 개수 :  1057872
    


### # 파일 저장


```python
df_bus_card_tot.to_csv("./02_data_통합본/df_bus_card_tot.csv", index = None)
```

-----

# [02_교통데이터_시각화분석]

### # 통합본 파일 불러오기


```python
import pandas as pd
```


```python
df_bus_card_tot = pd.read_csv("./02_data_통합본/df_bus_card_tot.csv")

len(df_bus_card_tot)
```


## 데이터 시각화 분석


```python
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns

from matplotlib import font_manager, rc

import platform

plt.rc('font', family = 'Malgun Gothic')
```

### 1. 기준월 및 기준일자별 버스 이용량 분석 비교
  * 사용할 분석요소 : 기준월, 기준일, 승객구분
  * 사용할 함수 : count

### # 피봇 테이블 만들기


```python
df_pivot = df_bus_card_tot.pivot_table(values = "승객구분",
                                        index = "기준월",
                                        columns = "기준일",
                                        aggfunc = "count")

df_pivot
```





### # 결측치 처리


```python
df_pivot = df_pivot.fillna(0)

df_pivot
```



### # 히트맵 만들기


```python
plt.figure(figsize = (20, 10)) # 그래프 크기 설정

sns.heatmap(df_pivot, # 피봇 데이터 넣어서 그래프 그리기
            annot = True, # True = 수치 표시, False = 수치 생략
            fmt = ".0f", # fmt=".0f" 옵션을 하면 소숫점 0자리, "0.1f"는 소숫점 1자리까지 표현.
            cmap = "rocket_r") 

plt.title("기준월 및 기준일자별 버스 이용량 분석 비교") # 타이틀 넣기
          
plt.show() # 보여주기
```
    


### 2. 기준일별 시간대별 버스 이용량 분석


```python
df_pivot = df_bus_card_tot.pivot_table(values = "승객구분",
                                      index = "기준일",
                                      columns = "기준시간",
                                      aggfunc = "count")
# 결측치 = 0
df_pivot = df_pivot.fillna(0)

# 히트맵
plt.figure(figsize = (16,10))

sns.heatmap(df_pivot, annot = True, fmt = ".0f", cmap = "rocket_r")

plt.title("기준일 및 시간대별 버스 이용량 분석")

plt.show()
```



### 3. 기준시간 및 분별 버스 이용량 분석


```python
df_pivot = df_bus_card_tot.pivot_table(values = "승객구분",
                                      index = "기준시간",
                                      columns = "기준시간(분)",
                                      aggfunc = "count")

# 결측치 = 0

df_pivot = df_pivot.fillna(0)

# 히트맵

plt.figure(figsize = (20,15))

sns.heatmap(df_pivot, annot = True, fmt = ".0f", cmap = "rocket_r")

plt.title("기준시간 및 분별 버스 이용량 분석")

plt.show()
```


### 4. 기준일별 시간대별 버스내 체류시간(분) 분석


```python
df_pivot = df_bus_card_tot.pivot_table(values = "버스내체류시간(분)",
                                      index = "기준일",
                                      columns = "기준시간",
                                      aggfunc = "mean")

# 결측치 = 0

df_pivot = df_pivot.fillna(0)

# 히트맵

plt.figure(figsize = (20,15))

sns.heatmap(df_pivot, annot = True, fmt = ".0f", cmap = "rocket_r")

plt.title("기준일별 시간대별 버스내 체류시간(분) 분석")

plt.show()
```


### 5. 시간대별 승객구분별 버스내 체류시간(분) 분석
  * 승객구분 컬럼은 범주형 데이터를 가지고 있어서 '막대그래프'나 '선그래프'가 적당하다


```python
df_temp = pd.DataFrame()

df_temp["기준시간"] = df_bus_card_tot["기준시간"]

df_temp["승객구분"] = df_bus_card_tot["승객구분"]

df_temp["버스내체류시간"] = df_bus_card_tot["버스내체류시간(분)"]

df_temp
```


### # 범주형 데이터값 종류 확인


```python
df_temp.drop_duplicates(["승객구분"])
```

### # 그룹 짓기


```python
df_temp2 = (df_temp.groupby(["기준시간", "승객구분"], as_index = False).sum()).\
            sort_values(by = ["버스내체류시간"], ascending = False)
```

### # 행렬 위치 변경


```python
df_temp2.head(10).transpose()
```

### # 그래프화


```python
fig = plt.figure(figsize = (25, 10))

sns.barplot(x = "기준시간", y = "버스내체류시간", hue = "승객구분", data = df_temp2)

plt.title("시간대별 승객구분별 버스내 체류시간(분) 분석")

plt.show()
```

### # 시간 및 승객구분별 빈도분석


```python
plt.figure(figsize = (12,4))

g = sns.histplot(data = df_temp2,
                x = "기준시간",
                bins = 30, # bin 개수
                kde = True, # 막대그래프에 선그리기(밀도표시선)
                hue = "승객구분",
                multiple = 'stack', # dodge
                stat = "density", # 비율로 확인하고자 할 때
                shrink = 0.6)

plt.title("시간 및 승객구분별 빈도분석")

plt.xlabel("기준시간")
plt.ylabel("rate")

plt.show()
```

### # 승하차정류장별 버스내 체류시간(분) 상위 30건 분석 비교


```python
df_temp = pd.DataFrame()

df_temp["승하차정류장"] = df_bus_card_tot["승차정류장"] + " --> " + \
                            df_bus_card_tot["하차정류장"]

df_temp["승객구분"] = df_bus_card_tot["승객구분"]

df_temp["버스내체류시간"] = df_bus_card_tot["버스내체류시간(분)"]

df_temp
```



```python
# 승하차정류장 및 승객구분별로 버스내체류시간의 sum 구하기

df_temp_sel = (df_temp.groupby(["승하차정류장", "승객구분"],
                              as_index = False).sum()).sort_values(by=["버스내체류시간"],
                                                                   ascending = False).head(30)

df_temp_sel
```


```python
# 그래프 사이즈 지정
plt.figure(figsize = (12,4))

# 데이터 x축, y축 넣기
plt.plot(df_temp_sel["승하차정류장"], df_temp_sel["버스내체류시간"])

# 그래프 제목
plt.title("승하차정류장별 버스내 체류시간(분) 상위 30건 분석")

# x축 제목
plt.xlabel("승하차정류장")

# y축 제목
plt.ylabel("버스내체류시간")

# x축 표시값을 90도 수직으로 표현
plt.xticks(rotation = 70)

# 그래프내 그리드선 표시
plt.grid(True)

plt.show()
```
-----

# [웹크롤링 - 멜론 사이트]

### # 웹 브라우저 조작 라이브러리
  * 웹 브라우저에 보이는 HTML 태그 속에서 텍스트 데이터를 분리해서 가지고 오는 라이브러리


```python
from selenium import webdriver 
```

### # 위에 명령어를 실행하면 오류가 난다. (설치가 안되어 있기 때문)
  * selenium 설치 방법
  * 보통은 !pip install 이라는 명령어로 selenium을 주피터 노트북에서 바로 설치하지만, 가끔 오류가 나서 아래의 방법으로 실행
  * 아나콘다 프롬프트 관리자 권한으로 실행
      - C:\Users\Admin
      - conda install -c conda-forge selenium
      - yes
  * 만약 위의 방법으로 설치가 안되면, 프롬프트 상에서
    - pip install selenium

### # 크롬 드라이버 설치
  * https://sites.google.com/chromium.org/driver/
  * 내 크롬 버전(크롬 - 도움말 - chrome 정보) 에 맞는 걸로 다운로드
  * 다운받은 폴더 이름 "ChromeDriver_exe"으로 변경
  * 다운받은 파일 이름 "chrome_버젼번호_driver.exe
    - chrome_99_driver.exe
  * 폴더 자체를 컴퓨터 C 드라이브에 복사


```python
driver = webdriver.Chrome("C:/ChromeDriver_exe/chrome_99_driver.exe")
```

    

### # 크롬 창 하나가 뜬다.
  * 지금부터 주피터 노트북으로 driver를 사용해 크롬을 제어할 수 있게 된다.

### # 웹 url로 접근하기


```python
url = "http://www.naver.com"

driver.get(url)
```

### # 페이지 소스 불러들이기


```python
html = driver.page_source

html
```


### # html 예시


```python
<html>
    <head>
    </head>
    <body> # 여기서부터 화면에 보이는 본문 부분
        <h1> 우리동네시장</h1>
            <div class = 'sale'>
                <p id='fruits1' class='fruits'>
                    <span class = 'name'> 바나나 </span>
                    <span class = 'price'> 3000원 </span>
                    <span class = 'inventory'> 500개 </span>
                    <span class = 'store'> 가나다상회 </span>
                    <a href = 'http://bit.ly/forPlaywithData' > 홈페이지 </a>
                </p>
            </div>
            <div class = 'prepare'>
                <p id='fruits2' class='fruits'>
                    <span class ='name'> 파인애플 </span>
                </p>
            </div>
    </body>
</html>
```

### # 문단을 문자열로 만드는 방법
  * """ ~ """
  * ''' ~ '''


```python
html = '''
    <html>
        <head>
        </head>
        <body> # 여기서부터 화면에 보이는 본문 부분
            <h1> 우리동네시장</h1>
                <div class = 'sale'>
                    <p id='fruits1' class='fruits'>
                        <span class = 'name'> 바나나 </span>
                        <span class = 'price'> 3000원 </span>
                        <span class = 'inventory'> 500개 </span>
                        <span class = 'store'> 가나다상회 </span>
                        <a href = 'http://bit.ly/forPlaywithData' > 홈페이지 </a>
                    </p>
                </div>
                <div class = 'prepare'>
                    <p id='fruits2' class='fruits'>
                        <span class ='name'> 파인애플 </span>
                    </p>
                </div>
        </body>
    </html>
'''
```

### # 현재 html 변수는 문자열을 저장한 상태
   * 컴퓨터는 html 언어라는 걸 인지하지 못한다.


```python
html
```


### # html 언어라는 걸 인지시키는 작업
  * BeautifulSoup 라이브러리
    - 문자열 데이터를 HTML 형식으로 읽어드리고, 정보를 쉽게 찾을 수 있도록 도와주는 라이브러리
    - HTML 문서 해석


```python
from bs4 import BeautifulSoup
```


```python
soup = BeautifulSoup(html, "html.parser")
```


```python
soup
```




    <html>
    <head>
    </head>
    <body> # 여기서부터 화면에 보이는 본문 부분
            <h1> 우리동네시장</h1>
    <div class="sale">
    <p class="fruits" id="fruits1">
    <span class="name"> 바나나 </span>
    <span class="price"> 3000원 </span>
    <span class="inventory"> 500개 </span>
    <span class="store"> 가나다상회 </span>
    <a href="http://bit.ly/forPlaywithData"> 홈페이지 </a>
    </p>
    </div>
    <div class="prepare">
    <p class="fruits" id="fruits2">
    <span class="name"> 파인애플 </span>
    </p>
    </div>
    </body>
    </html>



### # span 태그 모두 가져오기


```python
tags_span = soup.select("span")
```


```python
tags_span
```




    [<span class="name"> 바나나 </span>,
     <span class="price"> 3000원 </span>,
     <span class="inventory"> 500개 </span>,
     <span class="store"> 가나다상회 </span>,
     <span class="name"> 파인애플 </span>]



### # p 태그 모두 가져오기


```python
tags_p = soup.select("p")
```


```python
tags_p
```




    [<p class="fruits" id="fruits1">
     <span class="name"> 바나나 </span>
     <span class="price"> 3000원 </span>
     <span class="inventory"> 500개 </span>
     <span class="store"> 가나다상회 </span>
     <a href="http://bit.ly/forPlaywithData"> 홈페이지 </a>
     </p>,
     <p class="fruits" id="fruits2">
     <span class="name"> 파인애플 </span>
     </p>]



### # p태그 중에서도 id가 fruits1 에 속한 태그를 가져오기
  * id 검색은 #


```python
ids_fruits1 = soup.select("#fruits1")
```


```python
ids_fruits1
```




    [<p class="fruits" id="fruits1">
     <span class="name"> 바나나 </span>
     <span class="price"> 3000원 </span>
     <span class="inventory"> 500개 </span>
     <span class="store"> 가나다상회 </span>
     <a href="http://bit.ly/forPlaywithData"> 홈페이지 </a>
     </p>]



### # class에 inventory 태그 가져오기
  * class 검색은 .


```python
class_price = soup.select(".price")
```

### # 태그와 class 검색해서 태그 가져오기


```python
soup.select("span.name")
```




    [<span class="name"> 바나나 </span>, <span class="name"> 파인애플 </span>]



### # 태그 구조 중에 자식/자손 의미를 부여하는 기호
  * 자식(>) = 바로 밑, 직계
  * 자손(띄어쓰기) = 내 밑으로 전체

* id 속성이 fruits1인 값을 가지는 자식 중에 span이라는 태그의 속성 중 클래스 이름이 name인 태그를 조회


```python
soup.select("#fruits1>span.name")
```




    [<span class="name"> 바나나 </span>]



### # 문제
  * div 태그의 클래스 속성의 이름이 sale인 자식 중에
  * id의 이름이 fruits1 인 태그의 자식을 찾아서 
  * span 태그의 클래스 속성이 name인 태그를 조회

#### * > 사용 : 직계


```python
soup.select("div.sale > #fruits1 > span.name")
```




    [<span class="name"> 바나나 </span>]



#### * 띄어쓰기 사용 : 자손


```python
soup.select("div.sale span.name")
```




    [<span class="name"> 바나나 </span>]




```python
tags = soup.select("span.name")
```

### # tags 에 있는 값들 하나씩 다 뽑기

#### 방법 1.


```python
for idx in range(0, len(tags)) :
    print(tags[idx])
```

    <span class="name"> 바나나 </span>
    <span class="name"> 파인애플 </span>
    

#### 방법 2.


```python
for tag in tags :
    print(tag)
```

    <span class="name"> 바나나 </span>
    <span class="name"> 파인애플 </span>
    

#### 방법 2.로 하면 tag 는 마지막 값을 가지고 있다


```python
tag
```




    <span class="name"> 파인애플 </span>



### # 뽑힌 값에서 태그를 다 빼고 문자열만 가지고 오기


```python
tag.text
```




    ' 파인애플 '



### # 뽑힌 값에서 클래스 이름을 가지고 오기


```python
tag["class"]
```




    ['name']




```python
tag["class"][0]
```




    'name'



### # a 태그 조회


```python
tags = soup.select("a")

tags
```




    [<a href="http://bit.ly/forPlaywithData"> 홈페이지 </a>]




```python
tags[0].text
```




    ' 홈페이지 '




```python
tag = tags[0]
```


```python
tag.text
```




    ' 홈페이지 '




```python
tag["href"]
```




    'http://bit.ly/forPlaywithData'



## 멜론 노래 순위 정보 크롤링


```python
from selenium import webdriver
```


```python
driver = webdriver.Chrome("C:/ChromeDriver_exe/chrome_99_driver.exe")
```



```python
url = "http://www.melon.com/chart/index.htm"

driver.get(url)
```


```python
from bs4 import BeautifulSoup
```


```python
html = driver.page_source
```


```python
html
```



### 이후
  * 노트패드에 붙여넣기
  * 저장할 때 "파일이름.html"로 저장
  * 플로그인 - XML Tools - pretty print

### # 순위 정보 가져오기


```python
songs = soup.select("tr")
```


```python
len(songs)
```




    101



### # 리스트에서 범위 지정
  * songs의 값들 중에 첫번째 값 제외하고 다시 songs 변수에 담기


```python
songs = songs[1 : ]

# 혹은

songs = soup.select("tr")[1: ]
```


```python
len(songs)
```




    100



### # 샘플 1개 만들기
  * 1위인 태연의 앨범이 a 태그(하이퍼링크가 걸려있는 걸로 보아) 쯤에 있는 걸로 추측


```python
song = songs[0]

song
```




    <tr class="lst50" data-song-no="34626109" id="lst50">
    <td><div class="wrap t_right"><input class="input_check" name="input_check" title="INVU 곡 선택" type="checkbox" value="34626109"/></div></td>
    <td><div class="wrap t_center"><span class="rank">1</span><span class="none">위</span></div></td>
    <!-- 차트순위 추가 -->
    <td><div class="wrap">
    <span class="rank_wrap" title="순위 동일">
    <span class="bullet_icons rank_static"><span class="none">순위 동일</span></span>
    <span class="none">0</span>
    </span>
    </div></td>
    <td><div class="wrap">
    <a class="image_typeAll" href="javascript:melon.link.goAlbumDetail('10863559');" title="INVU - The 3rd Album">
    <img alt="INVU - The 3rd Album - 페이지 이동" height="60" onerror="WEBPOCIMG.defaultAlbumImg(this);" src="https://cdnimg.melon.co.kr/cm2/album/images/108/63/559/10863559_20220214160739_500.jpg/melon/resize/120/quality/80/optimize" width="60"/>
    <span class="bg_album_frame"></span>
    </a>
    </div></td>
    <td><div class="wrap">
    <a class="btn button_icons type03 song_info" href="javascript:melon.link.goSongDetail('34626109');" title="INVU 곡정보"><span class="none">곡정보</span></a>
    </div></td>
    <td><div class="wrap">
    <div class="wrap_song_info">
    <div class="ellipsis rank01"><span>
    <a href="javascript:melon.play.playSong('1000002721',34626109);" title="INVU 재생">INVU</a>
    </span></div><br/>
    <div class="ellipsis rank02">
    <a href="javascript:melon.link.goArtistDetail('236797');" title="태연 (TAEYEON) - 페이지 이동">태연 (TAEYEON)</a><span class="checkEllipsis" style="display: none;"><a href="javascript:melon.link.goArtistDetail('236797');" title="태연 (TAEYEON) - 페이지 이동">태연 (TAEYEON)</a></span>
    </div>
    </div>
    </div></td>
    <td><div class="wrap">
    <div class="wrap_song_info">
    <div class="ellipsis rank03">
    <a href="javascript:melon.link.goAlbumDetail('10863559');" title="INVU - The 3rd Album - 페이지 이동">INVU - The 3rd Album</a>
    </div>
    </div>
    </div></td>
    <td><div class="wrap">
    <button class="button_etc like" data-song-menuid="1000002721" data-song-no="34626109" title="INVU 좋아요" type="button"><span class="odd_span">좋아요</span>
    <span class="cnt">
    <span class="none">총건수</span>
    73,258</span></button>
    </div></td>
    <td><div class="wrap t_center">
    <button class="button_icons play" onclick="melon.play.playSong('1000002721',34626109);" title="듣기" type="button"><span class="none">듣기</span></button>
    </div></td>
    <td><div class="wrap t_center">
    <button class="button_icons scrap" onclick="melon.play.addPlayList('34626109');" title="담기" type="button"><span class="none">담기</span></button>
    </div></td>
    <td><div class="wrap t_center">
    <button class="button_icons download" onclick="melon.buy.goBuyProduct('frm', '34626109', '3C0001', '','0', '1000002721');" title="다운로드" type="button"><span class="none">다운로드</span></button>
    </div></td>
    <td><div class="wrap t_center">
    <button class="button_icons video" onclick="melon.link.goMvDetail('1000002721', '34626109','song');" title="뮤직비디오" type="button"><span class="none">뮤직비디오</span></button>
    </div></td>
    </tr>



### # 노래 제목 가져오기

### div class="ellipsis rank01"
    * 이렇게 적혀 있으면 띄어쓰기는 . 으로 표현하면 된다.


```python
song.select("div.ellipsis.rank01 > span > a")[0].text
```




    'INVU'



### # 가수 이름 가져오기


```python
song.select("div.ellipsis.rank02 > a")[0].text
```




    '태연 (TAEYEON)'



### # 더 높은 단계에서 이름, 노래 제목 찾기


```python
songs[0].select("div.ellipsis.rank01 > span > a")[0].text
```




    'INVU'



### # 문제
  * 100개 데이터의 제목과 가수이름을 출력
  * 출력 형태 : 순위[1], 제목[INVU], 가수[태연]

### 방법 1.


```python
i = 1

for song in songs :
     # 노래 제목만 가지고 오기
    title = song.select("div.ellipsis.rank01 > span > a")[0].text

    # 가수 이름만 가지고 오기
    singer = song.select("div.ellipsis.rank02 > a")[0].text
    
        
   # 조회
    print("순위[{}위], 제목[{}] , 가수[{}]".format(i,title, singer))
    
    # 증가값
    
    i += 1 # i = i + 1 하고 같은 것
```

    순위[1위], 제목[INVU] , 가수[태연 (TAEYEON)]
    순위[2위], 제목[사랑은 늘 도망가] , 가수[임영웅]
    순위[3위], 제목[취중고백] , 가수[김민석 (멜로망스)]
    순위[4위], 제목[듣고 싶을까] , 가수[MSG워너비(M.O.M)]
    순위[5위], 제목[언제나 사랑해] , 가수[케이시 (Kassy)]
    순위[6위], 제목[RUN2U] , 가수[STAYC(스테이씨)]
    순위[7위], 제목[abcdefu] , 가수[GAYLE]
    순위[8위], 제목[ELEVEN] , 가수[IVE (아이브)]
    순위[9위], 제목[너, 너 (N번째 연애 X 휘인 (Whee In))] , 가수[휘인 (Whee In)]
    순위[10위], 제목[SMILEY (Feat. BIBI)] , 가수[YENA (최예나)]
    순위[11위], 제목[Step Back] , 가수[GOT the beat]
    순위[12위], 제목[회전목마 (Feat. Zion.T, 원슈타인) (Prod. Slom)] , 가수[sokodomo]
    순위[13위], 제목[다정히 내 이름을 부르면] , 가수[경서예지]
    순위[14위], 제목[이제 나만 믿어요] , 가수[임영웅]
    순위[15위], 제목[리무진 (Feat. MINO) (Prod. GRAY)] , 가수[BE'O (비오)]
    순위[16위], 제목[호랑수월가] , 가수[탑현]
    순위[17위], 제목[눈이 오잖아(Feat.헤이즈)] , 가수[이무진]
    순위[18위], 제목[신호등] , 가수[이무진]
    순위[19위], 제목[STAY] , 가수[The Kid LAROI]
    순위[20위], 제목[다시 사랑한다면 (김필 Ver.)] , 가수[임영웅]
    순위[21위], 제목[Counting Stars (Feat. Beenzino)] , 가수[BE'O (비오)]
    순위[22위], 제목[그대라는 사치] , 가수[임영웅]
    순위[23위], 제목[어제처럼] , 가수[폴킴]
    순위[24위], 제목[별빛 같은 나의 사랑아] , 가수[임영웅]
    순위[25위], 제목[Next Level] , 가수[aespa]
    순위[26위], 제목[strawberry moon] , 가수[아이유]
    순위[27위], 제목[Dreams Come True] , 가수[aespa]
    순위[28위], 제목[잊었니] , 가수[임영웅]
    순위[29위], 제목[HERO] , 가수[임영웅]
    순위[30위], 제목[사랑인가 봐] , 가수[멜로망스]
    순위[31위], 제목[Weekend] , 가수[태연 (TAEYEON)]
    순위[32위], 제목[잊을 수 있을까] , 가수[노을]
    순위[33위], 제목[드라마] , 가수[아이유]
    순위[34위], 제목[끝사랑] , 가수[임영웅]
    순위[35위], 제목[Can't Control Myself] , 가수[태연 (TAEYEON)]
    순위[36위], 제목[Butter] , 가수[방탄소년단]
    순위[37위], 제목[Dynamite] , 가수[방탄소년단]
    순위[38위], 제목[Savage] , 가수[aespa]
    순위[39위], 제목[겨울잠] , 가수[아이유]
    순위[40위], 제목[노래 (The Song)] , 가수[비투비]
    순위[41위], 제목[바라만 본다] , 가수[MSG워너비(M.O.M)]
    순위[42위], 제목[너를 생각해] , 가수[주시크 (Joosiq)]
    순위[43위], 제목[Permission to Dance] , 가수[방탄소년단]
    순위[44위], 제목[만남은 쉽고 이별은 어려워 (Feat. Leellamarz) (Prod. TOIL)] , 가수[베이식 (Basick)]
    순위[45위], 제목[Bk Love] , 가수[임영웅]
    순위[46위], 제목[OHAYO MY NIGHT] , 가수[디핵 (D-Hack)]
    순위[47위], 제목[라일락] , 가수[아이유]
    순위[48위], 제목[My Universe] , 가수[Coldplay]
    순위[49위], 제목[서랍] , 가수[10CM]
    순위[50위], 제목[Christmas Tree] , 가수[V]
    순위[51위], 제목[Celebrity] , 가수[아이유]
    순위[52위], 제목[언덕나무] , 가수[이승윤]
    순위[53위], 제목[문득] , 가수[BE'O (비오)]
    순위[54위], 제목[우리가 헤어져야 했던 이유] , 가수[비비 (BIBI)]
    순위[55위], 제목[너 아니면 안돼] , 가수[먼데이 키즈 (Monday Kiz)]
    순위[56위], 제목[사이렌 Remix (Feat. UNEDUCATED KID, Paul Blanco)] , 가수[호미들]
    순위[57위], 제목[Bad Habits] , 가수[Ed Sheeran]
    순위[58위], 제목[그래서 그래 (Feat. 윤하)] , 가수[에픽하이 (EPIK HIGH)]
    순위[59위], 제목[흰눈] , 가수[먼데이 키즈 (Monday Kiz)]
    순위[60위], 제목[낙하 (with 아이유)] , 가수[AKMU (악뮤)]
    순위[61위], 제목[찰나가 영원이 될 때 (The Eternal Moment)] , 가수[마크툽 (MAKTUB)]
    순위[62위], 제목[헤픈 우연] , 가수[헤이즈 (Heize)]
    순위[63위], 제목[계단말고 엘리베이터] , 가수[임영웅]
    순위[64위], 제목[밤하늘의 별을(2020)] , 가수[경서]
    순위[65위], 제목[네가 없는 밤 (Feat. ASH ISLAND) (Prod. GRAY)] , 가수[BE'O (비오)]
    순위[66위], 제목[봄날] , 가수[방탄소년단]
    순위[67위], 제목[내 생에 아름다운] , 가수[이예준]
    순위[68위], 제목[모든 날, 모든 순간 (Every day, Every Moment)] , 가수[폴킴]
    순위[69위], 제목[Blueming] , 가수[아이유]
    순위[70위], 제목[어떻게 이별까지 사랑하겠어, 널 사랑하는 거지] , 가수[AKMU (악뮤)]
    순위[71위], 제목[내 손을 잡아] , 가수[아이유]
    순위[72위], 제목[너의 모든 순간] , 가수[성시경]
    순위[73위], 제목[Off My Face] , 가수[Justin Bieber]
    순위[74위], 제목[롤린 (Rollin')] , 가수[브레이브걸스]
    순위[75위], 제목[존재만으로] , 가수[원슈타인]
    순위[76위], 제목[고백] , 가수[멜로망스]
    순위[77위], 제목[Stronger (What Doesn't Kill You)] , 가수[Kelly Clarkson]
    순위[78위], 제목[불협화음 (Feat. AKMU) (Prod. GRAY)] , 가수[Mudd the student]
    순위[79위], 제목[오늘도 빛나는 너에게 (To You My Light) (Feat.이라온)] , 가수[마크툽 (MAKTUB)]
    순위[80위], 제목[강변북로] , 가수[황인욱]
    순위[81위], 제목[작은 것들을 위한 시 (Boy With Luv) (Feat. Halsey)] , 가수[방탄소년단]
    순위[82위], 제목[사랑이 아니었다고 말하지 마요] , 가수[이예준]
    순위[83위], 제목[Wake Up (Prod. 코드 쿤스트)] , 가수[개코]
    순위[84위], 제목[쉬어 (Feat. MINO) (Prod. GRAY)] , 가수[아넌딜라이트(Anandelight)]
    순위[85위], 제목[Dun Dun Dance] , 가수[오마이걸 (OH MY GIRL)]
    순위[86위], 제목[추억은 만남보다 이별에 남아] , 가수[정동하]
    순위[87위], 제목[그게 더 편할 것 같아 (N번째 연애 X 멜로망스)] , 가수[멜로망스]
    순위[88위], 제목[그런 밤 (Some Nights)] , 가수[태연 (TAEYEON)]
    순위[89위], 제목[대낮에 한 이별] , 가수[선예]
    순위[90위], 제목[밝게 빛나는 별이 되어 비춰줄게] , 가수[송이한]
    순위[91위], 제목[취기를 빌려 (취향저격 그녀 X 산들)] , 가수[산들]
    순위[92위], 제목[Savage Love (Laxed - Siren Beat) (BTS Remix)] , 가수[Jawsh 685]
    순위[93위], 제목[Good Night (Feat. BE'O)] , 가수[쿠기 (Coogie)]
    순위[94위], 제목[Stay Alive (Prod. SUGA of BTS)] , 가수[정국]
    순위[95위], 제목[그날에 나는 맘이 편했을까] , 가수[이예준]
    순위[96위], 제목[손을 잡는다거나, 같이 걷는다거나] , 가수[적재]
    순위[97위], 제목[Starlight] , 가수[태일 (TAEIL)]
    순위[98위], 제목[DM] , 가수[프로미스나인]
    순위[99위], 제목[Dilemma] , 가수[Apink (에이핑크)]
    순위[100위], 제목[이별후회] , 가수[김나영]
    

### 방법 2.


```python
for i in range(0, len(songs)) :
     # 노래 제목만 가지고 오기
    title = songs[i].select("div.ellipsis.rank01 > span > a")[0].text

    # 가수 이름만 가지고 오기
    singer = songs[i].select("div.ellipsis.rank02 > a")[0].text
            
   # 조회
    print("순위[{}위], 제목[{}] , 가수[{}]".format(i+1,title, singer))
```

    순위[1위], 제목[INVU] , 가수[태연 (TAEYEON)]
    순위[2위], 제목[사랑은 늘 도망가] , 가수[임영웅]
    순위[3위], 제목[취중고백] , 가수[김민석 (멜로망스)]
    순위[4위], 제목[듣고 싶을까] , 가수[MSG워너비(M.O.M)]
    순위[5위], 제목[언제나 사랑해] , 가수[케이시 (Kassy)]
    순위[6위], 제목[RUN2U] , 가수[STAYC(스테이씨)]
    순위[7위], 제목[abcdefu] , 가수[GAYLE]
    순위[8위], 제목[ELEVEN] , 가수[IVE (아이브)]
    순위[9위], 제목[너, 너 (N번째 연애 X 휘인 (Whee In))] , 가수[휘인 (Whee In)]
    순위[10위], 제목[SMILEY (Feat. BIBI)] , 가수[YENA (최예나)]
    순위[11위], 제목[Step Back] , 가수[GOT the beat]
    순위[12위], 제목[회전목마 (Feat. Zion.T, 원슈타인) (Prod. Slom)] , 가수[sokodomo]
    순위[13위], 제목[다정히 내 이름을 부르면] , 가수[경서예지]
    순위[14위], 제목[이제 나만 믿어요] , 가수[임영웅]
    순위[15위], 제목[리무진 (Feat. MINO) (Prod. GRAY)] , 가수[BE'O (비오)]
    순위[16위], 제목[호랑수월가] , 가수[탑현]
    순위[17위], 제목[눈이 오잖아(Feat.헤이즈)] , 가수[이무진]
    순위[18위], 제목[신호등] , 가수[이무진]
    순위[19위], 제목[STAY] , 가수[The Kid LAROI]
    순위[20위], 제목[다시 사랑한다면 (김필 Ver.)] , 가수[임영웅]
    순위[21위], 제목[Counting Stars (Feat. Beenzino)] , 가수[BE'O (비오)]
    순위[22위], 제목[그대라는 사치] , 가수[임영웅]
    순위[23위], 제목[어제처럼] , 가수[폴킴]
    순위[24위], 제목[별빛 같은 나의 사랑아] , 가수[임영웅]
    순위[25위], 제목[Next Level] , 가수[aespa]
    순위[26위], 제목[strawberry moon] , 가수[아이유]
    순위[27위], 제목[Dreams Come True] , 가수[aespa]
    순위[28위], 제목[잊었니] , 가수[임영웅]
    순위[29위], 제목[HERO] , 가수[임영웅]
    순위[30위], 제목[사랑인가 봐] , 가수[멜로망스]
    순위[31위], 제목[Weekend] , 가수[태연 (TAEYEON)]
    순위[32위], 제목[잊을 수 있을까] , 가수[노을]
    순위[33위], 제목[드라마] , 가수[아이유]
    순위[34위], 제목[끝사랑] , 가수[임영웅]
    순위[35위], 제목[Can't Control Myself] , 가수[태연 (TAEYEON)]
    순위[36위], 제목[Butter] , 가수[방탄소년단]
    순위[37위], 제목[Dynamite] , 가수[방탄소년단]
    순위[38위], 제목[Savage] , 가수[aespa]
    순위[39위], 제목[겨울잠] , 가수[아이유]
    순위[40위], 제목[노래 (The Song)] , 가수[비투비]
    순위[41위], 제목[바라만 본다] , 가수[MSG워너비(M.O.M)]
    순위[42위], 제목[너를 생각해] , 가수[주시크 (Joosiq)]
    순위[43위], 제목[Permission to Dance] , 가수[방탄소년단]
    순위[44위], 제목[만남은 쉽고 이별은 어려워 (Feat. Leellamarz) (Prod. TOIL)] , 가수[베이식 (Basick)]
    순위[45위], 제목[Bk Love] , 가수[임영웅]
    순위[46위], 제목[OHAYO MY NIGHT] , 가수[디핵 (D-Hack)]
    순위[47위], 제목[라일락] , 가수[아이유]
    순위[48위], 제목[My Universe] , 가수[Coldplay]
    순위[49위], 제목[서랍] , 가수[10CM]
    순위[50위], 제목[Christmas Tree] , 가수[V]
    순위[51위], 제목[Celebrity] , 가수[아이유]
    순위[52위], 제목[언덕나무] , 가수[이승윤]
    순위[53위], 제목[문득] , 가수[BE'O (비오)]
    순위[54위], 제목[우리가 헤어져야 했던 이유] , 가수[비비 (BIBI)]
    순위[55위], 제목[너 아니면 안돼] , 가수[먼데이 키즈 (Monday Kiz)]
    순위[56위], 제목[사이렌 Remix (Feat. UNEDUCATED KID, Paul Blanco)] , 가수[호미들]
    순위[57위], 제목[Bad Habits] , 가수[Ed Sheeran]
    순위[58위], 제목[그래서 그래 (Feat. 윤하)] , 가수[에픽하이 (EPIK HIGH)]
    순위[59위], 제목[흰눈] , 가수[먼데이 키즈 (Monday Kiz)]
    순위[60위], 제목[낙하 (with 아이유)] , 가수[AKMU (악뮤)]
    순위[61위], 제목[찰나가 영원이 될 때 (The Eternal Moment)] , 가수[마크툽 (MAKTUB)]
    순위[62위], 제목[헤픈 우연] , 가수[헤이즈 (Heize)]
    순위[63위], 제목[계단말고 엘리베이터] , 가수[임영웅]
    순위[64위], 제목[밤하늘의 별을(2020)] , 가수[경서]
    순위[65위], 제목[네가 없는 밤 (Feat. ASH ISLAND) (Prod. GRAY)] , 가수[BE'O (비오)]
    순위[66위], 제목[봄날] , 가수[방탄소년단]
    순위[67위], 제목[내 생에 아름다운] , 가수[이예준]
    순위[68위], 제목[모든 날, 모든 순간 (Every day, Every Moment)] , 가수[폴킴]
    순위[69위], 제목[Blueming] , 가수[아이유]
    순위[70위], 제목[어떻게 이별까지 사랑하겠어, 널 사랑하는 거지] , 가수[AKMU (악뮤)]
    순위[71위], 제목[내 손을 잡아] , 가수[아이유]
    순위[72위], 제목[너의 모든 순간] , 가수[성시경]
    순위[73위], 제목[Off My Face] , 가수[Justin Bieber]
    순위[74위], 제목[롤린 (Rollin')] , 가수[브레이브걸스]
    순위[75위], 제목[존재만으로] , 가수[원슈타인]
    순위[76위], 제목[고백] , 가수[멜로망스]
    순위[77위], 제목[Stronger (What Doesn't Kill You)] , 가수[Kelly Clarkson]
    순위[78위], 제목[불협화음 (Feat. AKMU) (Prod. GRAY)] , 가수[Mudd the student]
    순위[79위], 제목[오늘도 빛나는 너에게 (To You My Light) (Feat.이라온)] , 가수[마크툽 (MAKTUB)]
    순위[80위], 제목[강변북로] , 가수[황인욱]
    순위[81위], 제목[작은 것들을 위한 시 (Boy With Luv) (Feat. Halsey)] , 가수[방탄소년단]
    순위[82위], 제목[사랑이 아니었다고 말하지 마요] , 가수[이예준]
    순위[83위], 제목[Wake Up (Prod. 코드 쿤스트)] , 가수[개코]
    순위[84위], 제목[쉬어 (Feat. MINO) (Prod. GRAY)] , 가수[아넌딜라이트(Anandelight)]
    순위[85위], 제목[Dun Dun Dance] , 가수[오마이걸 (OH MY GIRL)]
    순위[86위], 제목[추억은 만남보다 이별에 남아] , 가수[정동하]
    순위[87위], 제목[그게 더 편할 것 같아 (N번째 연애 X 멜로망스)] , 가수[멜로망스]
    순위[88위], 제목[그런 밤 (Some Nights)] , 가수[태연 (TAEYEON)]
    순위[89위], 제목[대낮에 한 이별] , 가수[선예]
    순위[90위], 제목[밝게 빛나는 별이 되어 비춰줄게] , 가수[송이한]
    순위[91위], 제목[취기를 빌려 (취향저격 그녀 X 산들)] , 가수[산들]
    순위[92위], 제목[Savage Love (Laxed - Siren Beat) (BTS Remix)] , 가수[Jawsh 685]
    순위[93위], 제목[Good Night (Feat. BE'O)] , 가수[쿠기 (Coogie)]
    순위[94위], 제목[Stay Alive (Prod. SUGA of BTS)] , 가수[정국]
    순위[95위], 제목[그날에 나는 맘이 편했을까] , 가수[이예준]
    순위[96위], 제목[손을 잡는다거나, 같이 걷는다거나] , 가수[적재]
    순위[97위], 제목[Starlight] , 가수[태일 (TAEIL)]
    순위[98위], 제목[DM] , 가수[프로미스나인]
    순위[99위], 제목[Dilemma] , 가수[Apink (에이핑크)]
    순위[100위], 제목[이별후회] , 가수[김나영]
    

## 웹 크롤링 방식 2가지

1. BeautifulSoup 방식
2. selenium 방식

### 1. BeautifulSoup 방식
  * select() 함수를 이요하여 태그 정보 가지고 온다.


```python
from selenium import webdriver 

driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")

url = "http://www.melon.com/chart/index.htm"

driver.get(url)

html = driver.page_source

# BeautifulSoup 방식 적용

from bs4 import BeautifulSoup

soup = BeautifulSoup(html, "html.parser")

'''
### 이후
  * 노트패드에 붙여넣기
  * 저장할 때 "파일이름.html"로 저장
  * 플로그인 - XML Tools - pretty print
'''

# 순위 top10 뽑기

songs = soup.select("tr")[1 : 11]

for i in range(0, len(songs)) :
     # 노래 제목만 가지고 오기
    title = songs[i].select("div.ellipsis.rank01 > span > a")[0].text

    # 가수 이름만 가지고 오기
    singer = songs[i].select("div.ellipsis.rank02 > a")[0].text
            
   # 조회
    print("순위[{}위], 제목[{}] , 가수[{}]".format(i+1,title, singer))
```

    C:\Users\admin\AppData\Local\Temp/ipykernel_12704/1864681130.py:1: DeprecationWarning: executable_path has been deprecated, please pass in a Service object
      driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")
    

    순위[1위], 제목[INVU] , 가수[태연 (TAEYEON)]
    순위[2위], 제목[사랑은 늘 도망가] , 가수[임영웅]
    순위[3위], 제목[취중고백] , 가수[김민석 (멜로망스)]
    순위[4위], 제목[듣고 싶을까] , 가수[MSG워너비(M.O.M)]
    순위[5위], 제목[언제나 사랑해] , 가수[케이시 (Kassy)]
    순위[6위], 제목[RUN2U] , 가수[STAYC(스테이씨)]
    순위[7위], 제목[abcdefu] , 가수[GAYLE]
    순위[8위], 제목[ELEVEN] , 가수[IVE (아이브)]
    순위[9위], 제목[너, 너 (N번째 연애 X 휘인 (Whee In))] , 가수[휘인 (Whee In)]
    순위[10위], 제목[SMILEY (Feat. BIBI)] , 가수[YENA (최예나)]
    

### 2. selenium 방식
  * find_elements_by_css_selector() 함수 사용


```python
from selenium import webdriver

driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")

url = "http://www.melon.com/chart/index.htm"

driver.get(url)

# selenium 방식

# 순위 top10 뽑기

songs = driver.find_elements_by_css_selector("tr")[1 : 11]

for i in range(0, len(songs)) :
     # 노래 제목만 가지고 오기
    title = songs[i].find_elements_by_css_selector("div.ellipsis.rank01 > span > a")[0].text

    # 가수 이름만 가지고 오기
    singer = songs[i].find_elements_by_css_selector("div.ellipsis.rank02 > a")[0].text
            
   # 조회
    print("순위[{}위], 제목[{}] , 가수[{}]".format(i+1,title, singer))
```

    C:\Users\admin\AppData\Local\Temp/ipykernel_12704/565403675.py:1: DeprecationWarning: executable_path has been deprecated, please pass in a Service object
      driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")
    C:\Users\admin\AppData\Local\Temp/ipykernel_12704/565403675.py:11: DeprecationWarning: find_elements_by_* commands are deprecated. Please use find_elements() instead
      songs = driver.find_elements_by_css_selector("tr")[1 : 11]
    

    순위[1위], 제목[INVU] , 가수[태연 (TAEYEON)]
    순위[2위], 제목[사랑은 늘 도망가] , 가수[임영웅]
    순위[3위], 제목[취중고백] , 가수[김민석 (멜로망스)]
    순위[4위], 제목[듣고 싶을까] , 가수[MSG워너비(M.O.M)]
    순위[5위], 제목[언제나 사랑해] , 가수[케이시 (Kassy)]
    순위[6위], 제목[RUN2U] , 가수[STAYC(스테이씨)]
    순위[7위], 제목[abcdefu] , 가수[GAYLE]
    순위[8위], 제목[ELEVEN] , 가수[IVE (아이브)]
    순위[9위], 제목[너, 너 (N번째 연애 X 휘인 (Whee In))] , 가수[휘인 (Whee In)]
    순위[10위], 제목[SMILEY (Feat. BIBI)] , 가수[YENA (최예나)]
    

### # 원하는 사이트에서 크롤링하기


```python
from selenium import webdriver

driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")

url = "https://www.youtube.com/"

driver.get(url)

html = driver.page_source

# BeautifulSoup 방식 적용

from bs4 import BeautifulSoup

soup = BeautifulSoup(html, "html.parser")
```

    C:\Users\admin\AppData\Local\Temp/ipykernel_12704/2885334508.py:1: DeprecationWarning: executable_path has been deprecated, please pass in a Service object
      driver = webdriver.Chrome("c://ChromeDriver_exe/chrome_99_driver.exe")
    


```python
soup.select("h3 > a")[8]
```




    <a aria-label="아니 사진을 이렇게 찍으면 게시자: 너덜트 3일 전 3분 30초 조회수 1,531,655회" class="yt-simple-endpoint style-scope ytd-rich-grid-media" href="/watch?v=yK9bhwuBidA" id="video-title-link" title="아니 사진을 이렇게 찍으면"><yt-formatted-string aria-label="아니 사진을 이렇게 찍으면 게시자: 너덜트 3일 전 3분 30초 조회수 1,531,655회" class="style-scope ytd-rich-grid-media" id="video-title">아니 사진을 이렇게 찍으면</yt-formatted-string></a>

-----
# 통계분석

### # 사용되는 라이브러리


```python
# scipy > stats : t검정에 사용

from scipy import stats

import numpy
```

### # 학생 키에 대한 데이터 생성


```python
height_list = numpy.array([169, 167, 175, 166, 162,
                         180, 172, 162, 173, 162,
                         181, 175, 181, 181, 162,
                         165, 172, 176, 167, 165])
```


```python
type(height_list)
```




    numpy.ndarray



### # t-검정


```python
tTestResult = stats.ttest_1samp(height_list, 170)

print(tTestResult)

print("t검정통계량 = %.3f, p-value = %.3f" % (tTestResult))
```

    Ttest_1sampResult(statistic=0.42270173526659166, pvalue=0.6772582597305596)
    t검정통계량 = 0.423, p-value = 0.677
    

### # 용어
  * statistic + pvalue = 1
    - statistic = 검정통계량(정확도)
    - pvalue(p-value) = 유의수준(오차)
  
  * 170 : 귀무가설에서 채택한 값
    = '집단의 키 평균은 170이다'
    
  * height_list 에 있는 값들은 표본 : 대립가설 증명을 위해 모은 표본
    
  * T-검정을 수행
    - T-검정의 목적 : 귀무가설이 참인지 확인
      + p-value < 0.05 채택
      + p-value >= 0.05 기각
  
  * pvalue = 0.67... 
    - 0.05보다 크기 때문에 귀무가설 170은 기각.
  
  * 만약 0.05 미만이여서 귀무가설이 채택이 되었다면, 대립가설을 위해 모은 표본 height_list는 진행을 할 수 있게 된다.
  
### # 해석(문장 형태로)
  * 귀무가설에서 채택한 값은 170이다. 표본 값들은 height_list 변수(표본집단)에 넣었다. height_list를 t-검정을 통해 p-value 값을 확인했다. p-value가 0.05보다 크기 때문에 height_list 귀무가설 170은 기각. 이후 대립가설을 진행할 수 있게 되었다.

### # 두집단간 평균비교


```python
group1Heights = numpy.array([162, 168, 169, 165, 166, 168,
                            162, 172, 157, 173, 158, 169,
                            164, 170, 163, 175, 177, 162,
                            175, 177])

group2Heights = numpy.array([180, 181, 163, 164, 174, 169,
                            164, 172, 162, 171, 180, 168,
                            164, 169, 178, 177, 167, 179,
                            172, 169])

# 두집단간 평균비교
tTestResult = stats.ttest_ind(group1Heights, group2Heights)

tTestResult
```




    Ttest_indResult(statistic=-1.8253194633881713, pvalue=0.07582039848129221)



### # 대응되는 두 집단. 가중치 부여된 특정 집단과의 분석


```python
# 20개의 체중 데이터

beforeWeights = numpy.array([80, 82, 76, 82, 65, 73, 77,
                            78, 61, 81, 80, 70, 60, 83,
                            89, 84, 85, 81, 67, 60])

# 20개의 랜던값 생성

temp_list = []

for i in beforeWeights :
    # 랜덤한 가중치 부여
    temp_list.append( i * numpy.random.normal(0.99, 0.02) )
    
afterWeights = numpy.array(temp_list)

tTestResult = stats.ttest_rel(beforeWeights, afterWeights)

tTestResult
```




    Ttest_relResult(statistic=2.748931032383186, pvalue=0.012764513003338501)
