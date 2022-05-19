# 파일쓰기

f = open('writefile.txt', 'w', encoding = 'utf-8')

f.write('저는 한국사람입니다.\n')

texts = ['저는 한국사람이죠\n', '이번에 2022년이 되었습니다.\n']
f.writelines(texts)

f.close()

# 'a' : 파일 수정

f = open('writefile.txt', 'a', encoding = 'utf-8')

f.write('내용 추가할게요')

f.close()
