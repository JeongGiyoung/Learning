install.packages('arules')
library(arules)

dir()
tran = read.transactions("train.txt", format="basket", sep=',')
head(tran)
str(tran)
class(tran)

tran@itemInfo
tran@data@i

# ��� ���� �����ִ� ���ɾ�
 
tran

#
inspect(tran)
str(inspect(tran))

# ��Ģ(rule) �߰�

apriori(tran, parameter=list(supp=0.3, conf=0.1))

rule=apriori(tran, parameter=list(supp=0.3, conf=0.1))

str(rule)

inspect(rule)

# �� �߿� lift(���)�� ���� ���� ����.

# ������ ���ż��� ���� ������ ���� 

# ��Ÿ��, ���� �ŷڵ�
	* ��Ÿ�̾�� ������ ������ / ��Ÿ���� ������
      * ������ ��Ÿ�� ������ / ������ ������
      # 0.5/0.75 => 0.6666...

