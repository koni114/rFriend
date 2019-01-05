# write.table() : ������ ��ü(dataframe)�� txt ���Ϸ� ���� ----
data1 <- iris 
write.table(data1,
            "C:/rfriend/iris.txt",
            row.names = FALSE,  # FALSE : row �̸� ����. 
            quote = FALSE,      # FALSE : ���� �̸�, �� ��ȣ�� �ο� ��ȣ ���� TRUE�� �� ��ȣ
            append = TRUE,      # TRUE  : ���� txt�� ��� ���. 
            na = "NA"           # ������ ��� �ش� ���ڿ��� ��ü�� �� ����
)
  

# cat() : �м� ���(����)�� ���ڿ��� �����Ͽ� �ܺ� ���Ϸ� ���� ----
data2 <- c(1:10)
cat("Data result is :", "\n", data2,
    file = "C:/rfriend/iris2.txt",
    append = TRUE
    )

# capture.output() : �м� ���(����Ʈ)�� �ܺ� ���Ϸ� ���� ----
# linear regression result(list) �� �ܺ� ���Ϸ� ������ ����

# 1. �ǽ� ������ ���� : height, weight�� ������ dataFrame ����
height <- c(175, 159, 166, 189, 171, 173, 179, 167, 182, 170)
weight <- c(62, 55, 59, 75, 61, 64, 63, 65, 70, 60)
d.f_h_w <- data.frame(height, weight)

# 2. ��� �� lm.result�� ����(list)
lm.result <- lm(weight ~ height, d.f_h_w)
summary(lm.result)  

# 3. �ش� list�� �ܺ� ����(txt)�� ����
capture.output(summary(lm.result),
               file = "C:/rfriend/lm.result.txt",
               append = TRUE
               )


# str(), class(), dim(), head(), tail(), length(), names() : ��ü�� �����ϴ� �Լ� ----
# �������� ������ �ſ� ���� ��, �ش� function�� �̿��Ͽ� �ľ��ϴ� ���� �߿�!
# R ���� �ǽ� �������� mtcars �� �ش� function�� �̿��ؼ� Ȯ���غ���

str(mtcars)    # DF�� column type �� �뷫���� ������ Ȯ���� �� �ִ�
class(mtcars)  # ��ü ��ü�� ���� class(type) �� Ȯ���� �� �ִ�
dim(mtcars)    # ��ü�� ���� dimension �� Ȯ���� �� �ִ�
head(mtcars)   # ���� 6���� ���� data ������ Ȯ���� �� �ִ�
tail(mtcars)   # ���� 6���� ���� data ������ Ȯ���� �� �ִ�
length(mtcars) # ��ü�� ���� ��� ������ Ȯ���� �� �ִ�
names(mtcars)  # ��ü�� name(df -> �÷���)�� Ȯ�� �� �� �ִ�

# dataFrame ������ Ȱ���ϴ� ��� 3���� ----
# 1. with(), attach() & detach() : ������ ������ ������ �� �� �ȵǴ� ��� Ȱ��ȭ �Ͽ� ���

# 1.1 with() : ���ɹ��� �� ���� ��� ���
# dataFrame���� ������� �ʰ�, ���������� �̿��Ͽ� mpg�� 0-1 ǥ�� ��ȯ �غ���
with(mtcars, ((max(mpg) - mpg) / (max(mpg) - min(mpg))))

# 1.2 attach(), detach() : �ϳ��� ������ �������� �̿��Ͽ� �ټ��� ���ɾ ����� ��,
# attach() : dataFrame Ȱ��ȭ, detach() : dataFrame �� Ȱ��ȭ
attach(mtcars)
((max(mpg) - mpg) / (max(mpg) - min(mpg)))
detach(mtcars)

# ** ������ ��(�߿�)
# attach �� Ư�� �������������� Ȱ��ȭ ��Ų �Ŀ�, ���� �̸��� ���������� ���͸� �����ϸ�,
# �ش� ������ dataFrame�� ������ �ƴ϶� ���� ������ ���� ���ͷ� ��� �ν��ϰ� ��
# �ذ� ��� : $�� �̿��ؼ� ������ �������ų�, rm() �� �̿��Ͽ� ���� ����, �� �ϸ� �ȴ�

# attach�� dataFrame�� Ȱ��ȭ �� ��, Ȱ��ȭ�� dataFrame�� ������ ���,
# detach �� �� �ٽ� attach �ؼ� �������!

# read.fwf() : ������ ������ �����͸� ������ ũ��� �߶� ������ �� ----
# fwf : fixed width file�� ����

# 1~2�ڸ�, 3~5�ڸ�, 6~8�ڸ��� ������ �������� �Ǿ��ִ� ������ �ҷ����� : data_fwf.txt
# 2, 3, 3 �������� Var_1, Var_2, Var_3 ������ ����� dataFrame�� ������ ��
read.fwf("C:/r/data_fwf.txt",
         widths = c(2, 3, 3),
         col.names = c("Var_1", "Var_2", "Var_3")         
         )


# rep(), seq() : ������ ����/������ ������ ����
# 1. rep() : repeat(?)�� �ǹ���. 
# ���� ���̴� case 4���� ����

rep("a", 5)              # ������ a�� 5�� �ݺ��� ��
rep(1, 10)               # ���� 1�� 10�� �ݺ��� ��
rep(c("a", 1), 5)        # a�� 5�� "�����ư���" 5���� �ݺ��� �� : 1�� ���������� ��ȯ 
rep(c("a", 1), c(5, 5))  # a�� 5�� 5���� �ݺ��� �� 
rep(1:3, each = 3)       # 1���� 3�� 3���� �ݺ��� ��

# 1����� 20����� �ִ� ������ �����ӿ��� 1���� 5������ �ݺ��ϴ� ���ڸ� �� �������� �ݺ��ϴ� ����
x <- rep(1:5, each = 5)
dim(x) <- c(5,5)
x

# 2. seq() : ������ ����/������ ������ ����
# seq -> sequence�� ���Ӹ�: �������̴��� �ǹ�

seq(from = 1, to = 10)  # 1���� 10���� 1�� ����(default)
seq(from = 1, to = 10, by = 2) # 1���� 10���� 2�� ����
seq(from = 1, to = 10, length = 5)  # 1���� 10���� 5 ������� ��Ÿ�� ��
seq(from = 1, by = 2, length.out = 10)  # length.out : �ִ� ����

# abs(x), sqrt(x), ceiling(x), floor(x), trunc(x), round(x), log(x), exp(x), factorial(x) : �������� �ٷ�� �Լ���
abs(-10)  # -> 10
sqrt(10)  # -> ��Ʈ 10
sqrt(-10) # -> ����� NaN
ceiling(6.8)  # -> �ø�(������ �������)
floor(6.7)    # -> ����(������ �������)
trunc(5.6666) # -> �Ҽ����� �߶� ����
round(3.6, digit = 0)    # -> �ݿø�. digit = 0 �� ����
log(10, base = 1)  # ���� 1�� log10�� �ǹ�
exp(10)  # e^10 �� �ǹ�
factorial(10)  # 10! �ǹ�

# mean(), median(), range(), sd(), var(), min(), max(), IQR(),
# diff(), length(), rank()

# fBasics::skewness, fBasics:::kurtosis  
# -> �ֵ�(skewness), ÷��(kurtosis)
install.packages("fBasics")
skewness(mtcars$mpg) 
kurtosis(mtcars$mpg)

diff(c(1,2,3), lag = 1) # 1�� ����
diff(c(3,4,5), lag = 2) # 2�� ����
rank(c(1,2,3))  # ����! ranking ���� �˷��ִ� ���� �ƴ϶�, ranking�� ���� index return

# ������ �ִ�, �ּ� ���Ҷ� Tip!!
# min, max function�� �̿��� ��, "����ġ"(NA)�� ���ԵǾ� �ִ� ���, NA return
# --> which.min, which.max�� �̿��Ͽ� idx�� ���� ���� �������� NA �� ���� �ִ�, �ּ� ���� ���� �� ����!!
test.minMax <- c(1,2,3,10,7,-3, NA)

# min() : NA, which.min : -3
min(test.minMax)  
test.minMax[which.min(test.minMax)]

# max() : NA, which.max : 10
max(test.minMax)
test.minMax[which.max(test.minMax)]

# matrix 
matrix(1:16, 4, byrow = T)  # byrow : row ���� ������ �ش� vector ���ڸ� matrix�� ä�� ����

# R, Python ���� ���� vs ��Į��, ���� vs ���͸� ���� �����ڸ� �̿��ؼ� �񱳰� �����ϴ�
test <- c(1,2,3,4,5)
test < 3  # ������ ��(T, F)�� return

test2 <- c(3,3,3,4,4)
test < test2  # ���� ���� ���� �����ڷ� �񱳰� ����

# any() : ���� ������ ��, �ϳ��� TRUE�� TRUE�� return
any(test < test2)  # 1,2�� index�� TRUE �̹Ƿ�, TRUE ��Į�� ���� return

# all() : ���� ������ ��, �ϳ��� FALSE �̸�, FASLE�� return
all(test < test2)  # 3,4,5�� FALSE �̹Ƿ�, FALSE return

# �Ϲ������� �����ͼ��� ������, �ش� �����ͼ��� ����(str), ����(class) �� �ľ��ϴ� ���� �߿�
# �̿� ���� �м��� �ٸ��� �� �� ����. ���� �����ͼ��� �ҷ� �� ��, �ش� ������ �ľ��Ͽ� ������ ����ȯ�� ���� ���� �߿�

# tapply(), sapply(), lapply(): ������ ������ ���� ������ �Լ� ���ÿ� �����ϱ� ----
# apply �迭 3�ѻ��� t, s, l�� �˾ƺ���

# 1. tapply() 
# ����(factor)�� ����(level)���� Ư�� ���Ϳ� �Լ� ���ɾ ���ÿ� ����
#         ������� : tapply(����, ����, �Լ�)
#         ���     : ���� �Ǵ� ���

# Cars93 �����͸� ������ ���� ����(Type)�� ���ӵ��� ����(MPG.highway)�� ��հ� ǥ�������� tapply()�� Ȱ���� ���غ���
library(MASS)

# Cars93 ���� �ľ�
str(Cars93)

# sapply�� �̿��Ͽ� type �� ���� ��� ���ϱ�
with(Cars93, tapply(MPG.highway, Type, mean))  # Type �� ���� ����� ���� ���� �� ����

# 2. sapply()
# ������ ������ ���� ������ �Լ� ���� ���� -> **����� ���� �Ǵ� ���
Sapply.cars93 <- sapply(Cars93, class)  # �ش� ����(�÷�)�� class ���ϱ�
class(Sapply.cars93)

# 3. lapply()
# ������ ������ ���� ������ �Լ� ���� ����(sapply�Լ��� ���� ��� ����) -> ** ��� ���� ����Ʈ
lapply(Cars93, class)  # ��� �� list. -> indexing �ϱ� ����

# is.na(), sum(is.na()), na.rm = TRUE, na.omit(), complete.cases() : ����ġ Ȯ�� �� ó�� ----
# �Ϲ�������, ������ ������ ������ �ľ�������, �������� EDA�� �����ϴµ� �̶� ������ ���� Ȯ���Ѵ�.
# why ? : �켱������ ������ ���Ե� ���¿��� �м��� �����ϰ� �Ǹ� ��� ���� NA�� ������ ��찡 ����. ���� ó���� �ʿ��ѵ�,
#         �Ϲ������� �Լ����� na.rm = T�� ����ϰų�, is.na(x) �� �̿��� ���Ÿ� �Ѵ�.
# �̷� �� ����ϴ� �Լ����� �ϳ��� �˾ƺ���

# is.na() : �������� ���ԵǾ� �ִ��� Ȯ��
x <- c(1, 2, 3, 4, NA, 6, 7, 8, 9, 10)
is.na(x)  # NA�� ��� TRUE�� return

# sum(is.na()) : ���� �� ���� Ȯ��
sum(is.na(x))  # �� ���� �� ������ 1������ Ȯ��

# colSums() : ������ ������ �ټ� ������ ���� ���� ���� ����
colSums(is.na(Cars93))  # mtcars dataSet�� ������ ����ġ ������ �� �� ����

# na.rm = T : ��� �м� ��, ���� ���� �����ϰ� ���
sum(x) # NA�� ������ Ȯ��
sum(x, na.rm = T)  # ���� ���� �� ��� �� ���

# na.omit() : �������� ���ԵǾ� �ִ� ���� ������ �� ��ü���� ����
nrow(Cars93)          # ���� �� ���� �� �� ���� -> 93�� 
nrow(na.omit(Cars93)) # ���� ���� ���ԵǾ� �ִ� �� ���� �� -> 82��

# complete.cases() : Ư�� ��, ��(����)�� ���Ե� ����ġ�� ��,���� �����ϰ� ���� ��

# Cars93 ������ �������� "Rear.seat.room" Į�� �� �������� �ִ� �� ��ü �����غ���
Cars93[complete.cases(Cars93[,"Rear.seat.room"]),]

# Cars93 ������ �������� 23, 24��° Į�� �� �������� �ִ� �� ��ü�� �����غ���
Cars93[complete.cases(Cars93[,c(23,24)]),]

# ����ġ ó�� ���� ������
# �������������� ��� ���� �������� Ư�� ��(����, '0')���� �ϰ� ��ü 
mtcars6 <- mtcars
mtcars6[is.na(Cars93)] <- 0

# �������������� �� ������ �������� �� ���� �� ��հ����� �ϰ� ��ü
sapply(mtcars6, function(x) ifelse(is.na(x), mean(x, na.rm = T), x))

# %any% Ư�� ������ �ٷﺸ�� ----
# %%, %/%, %*%, %in% �� 4 ������ ���ؼ� �ѹ� �˾ƺ���!

# ���� ������
x <- c(1:10)
y <- 5

# 1. %% : ������ ������
x %% y  # x�� y�� ���� ������ ������ ����

# 5�� ���� �������� 0�� ���� ����
x[x %% y == 0]

# 2. %/% : ���� �� ��������
x %/% y  # 1 ~ 10�� ���� 5�� ���� �� ������


# 3. %*% : ��� ���ϱ� ������
c(1, 2, 3) %*% c(4, 5, 6)  # 1*4 + 2*5 + 3*6 -> 32 

# 4. %in% : ���� �� Ư�� �� ���� ���� Ȯ�� ������
x %in% y  # y�� 5�̹Ƿ�, 5 ��° ���� TRUE�� return
           
# R �����Լ� �˾ƺ���
# nchar(), substr(), paste(), sub(), gsub(), grep(), regexp(), gregexpr()

# 1. nchar() : ������ ������ ���� ��� ����(���ڿ� ����) ����
x <- c("Seoul", "New York", "London", "1234")
nchar(x)  # �ش� ����� ���ڿ� ���̸� vector ������ return

# 2. substr() : ������ ������ start, stop ������ ���ڿ� �߶� ����
#               �Ϲ������� ��¥������ �ش� ��, ��, ���� ������ �� ���.

time_stamp <- c("201507251040", "201507251041", "201507251042", "201507251043", "201507251044")
yyyymm <- substr(time_stamp, 1, 6)

# 3. paste() : ������ ���� x�� y�� ���̱�
paste("I", "LOVE", "YOU")
paste("I", "LOVE", "YOU", sep = "," )

# 4. strsplit() : ������ ���͸� split �������� �ڸ���
#                 ��� ���� list
name <- c("Chulsu, Kim", "Younghei, Lee", "Dongho, Choi")
strsplit(name, split = ",")  

# �����������ӿ��� ���ڿ��� ������ �������� ������ ���
df.name <- data.frame(ID = c(1:3), name = c("Chulsu/Kim", "Younghei/Lee", "Dongho/Choi"))
data.frame(do.call('rbind',
                   strsplit(as.character(df.name$name), split = "/", fixed = TRUE)
                   ))           

# 5. sub(old, new, x)  : ������ ���� x���� ������ old ���ڸ� new ���ڷ� �ѹ��� �ٲٱ�
x <- c("My name is Chulsu. What's your name?")
sub("name", "age", x)

# 6. gsub(old, new, x) : ������ ���� x���� ������ old ���ڸ� '����' new ���ڷ� �ٲٱ�
x <- c("My name is Chulsu. What's your name?")
gsub("name", "girlFriend name", x)

# 7. grep(pattern, x) : x ���ڿ� ���Ϳ��� Ư�� �κ� ���ڿ� ���� ã��
grep("1010", c("101010", "0101010", "110011"))

# 8. regexpr()  : text �� ������ ���� ���� ������ ��ġ ã��
regexpr("NY", "I love NY and I'm from NY")

# 9. gregexpr() : text �� ���� ������ ������ ��� ��ġ ã��
gregexpr("NY", "I love NY and I'm from NY")


# ������ ������ ������ ������ ��ȯ�ϴ� 3���� ��� ----

# ������ �غ� : ��� ���� ���� (stat_score)
student_id <- c("s01", "s02", "s03", "s04", "s05", "s06", "s07", "s08", "s09", "s10")
stat_score <- c(56, 94, 82, 70, 64, 82, 78, 80, 76, 78)
mean(stat_score)
hist(stat_score)

# ������ ������ ����
score.d.f <- data.frame(student_id, stat_score)
rm(student_id, stat_score)


# 1. cut() : �ش� �Լ��� �̿��Ͽ� ������ ������ ���� ����
#            breaks -> ������ ���� cut ����
#            right  -> TRUE ��,  a < x <= b ó��,  ������ ������ =�� ����
#            right  -> FALSE ��, a <= x < b ó��,  ���� ������ =�� ����

score.d.f <- transform(score.d.f,
          stat_score_1 = cut(stat_score, breaks = c(0, 60, 70, 80, 90, 100),
                             include.lowest = FALSE,
                             right  = FALSE,
                             labels = c("��", "��", "��", "��", "��")
                             )
          )


# 2. ifelse() : �ܼ� ifelse �� ���ؼ� ������ ������ ���� ����
score.d.f <- transform(score.d.f,
          stat_score_2 = ifelse(stat_score < 60, "��",
                         ifelse(stat_score >= 60 & stat_score < 70, "��",
                                ifelse(stat_score >= 70 & stat_score < 80, "��",
                                ifelse(stat_score >= 80 & stat_score < 90, "��", "��"
                                ))))
)

score.d.f <- within(score.d.f, {
                    stat_score_3 = character(0)
                    stat_score_3[stat_score < 60] = "��"
                    stat_score_3[stat_score >= 60 & stat_score < 70] = "��"
                    stat_score_3[stat_score >= 70 & stat_score < 80] = "��"
                    stat_score_3[stat_score >= 80 & stat_score < 90] = "��"
                    stat_score_3[stat_score >= 90 & stat_score <= 100] = "��"
                    stat_score_3 = factor(stat_score_3, levels = c("��", "��", "��", "��", "��"))
})                               
                                

# +, -, *, /, ^, %*%, cbind(), rbind(), colMeans(), rowMeans(), colSums(), rowSums(), t()  : ��� ����
A <- matrix(1:4, nrow = 2, ncol = 2, byrow = T)
B <- matrix(5:8, nrow = 2, ncol = 2, byrow = T)

# 1. +, -, *, / : �ش� ��� ��ġ ���� ��Ģ ���� ����
A + B
A - B
A * B
A / B

# 2. %*% : ��� ��(�������)
A %*% B

# 3. cbind() : ��� ����(��) ����
cbind(A, B)

# 4. rbind() : ��� ����(��) ����
rbind(A, B)

# 5. colMeans() : ���� ���� ��� �� ���
colMeans(A)
colMeans(B)

# 6. rowMeans() : �࿡ ���� ��� �� ���
rowMeans(A)
rowMeans(B)

# 7. rowSums() :  �࿡ ���� �� ���
rowSums(A)
rowSums(B)

# 8. colSums() :  ���� ���� �� ���
colSums(A)
colSums(B)

# 9. t() : ��ġ��� transpose. ��� ���� ��Ī ����
t(A) 

# names() : dataFrame�� �̸�(��) ����

# ���� MASS ��Ű���� �ִ� Cars93 ������ ������ �� 1~5��° ������ �����ؼ�, base ��Ű���� �ִ� names() �Լ��� �������� ����
library(MASS)
Cars93.subset <- Cars93[,c(1:5)]
names(Cars93.subset) <- c("v1", "v2", "v3", "v4", "v5")
names(Cars93.subset)  # v1 ~ v5�� ���� ��

# rename(): dataFrame ������ ���� 3���� ��� ----
# �߿��� ���� �� packag  ���� rename function�� ������� �ٸ��Ƿ�, �����ؾ��Ѵ�!!

# 1. reshape::rename() 
install.packages("reshape")
library(reshape)
  Cars93_subset <- rename(Cars93_subset, 
                                c(V1 = "V1_Manufacturer", 
                                  V2 = "V2_Model", 
                                  V3 = "V3_Type", 
                                  V4 = "V4_Min.Price", 
                                  V5 = "V5_Price"))

# 2. plyr::rename()
library(plyr)
Cars93_subset <- rename(Cars93_subset, 
                        c("V1_Manufacturer" = "Manufacturer", 
                          "V2_Model" = "Model", 
                          "V3_Type" = "Type", 
                          "V4_Min.Price" = "Min.Price", 
                          "V5_Price" = "Price"))

# 3. dplyr::rename()
Cars93_3 <- rename(Cars93_2, 
                     New_Manufacturer = Manufacturer,
                     New_Model = Model, 
                     New_Type = Type)


  
  

