# write.table() : 데이터 객체(dataframe)를 txt 파일로 저장 ----
data1 <- iris 
write.table(data1,
            "C:/rfriend/iris.txt",
            row.names = FALSE,  # FALSE : row 이름 생략. 
            quote = FALSE,      # FALSE : 변수 이름, 행 번호에 인용 번호 생략 TRUE면 행 번호
            append = TRUE,      # TRUE  : 기존 txt에 계속 덮어씀. 
            na = "NA"           # 결측인 경우 해당 문자열로 대체할 수 있음
)
  

# cat() : 분석 결과(벡터)를 문자열과 결합하여 외부 파일로 저장 ----
data2 <- c(1:10)
cat("Data result is :", "\n", data2,
    file = "C:/rfriend/iris2.txt",
    append = TRUE
    )

# capture.output() : 분석 결과(리스트)를 외부 파일로 저장 ----
# linear regression result(list) 를 외부 파일로 저장해 보기

# 1. 실습 데이터 편성 : height, weight를 가지는 dataFrame 편성
height <- c(175, 159, 166, 189, 171, 173, 179, 167, 182, 170)
weight <- c(62, 55, 59, 75, 61, 64, 63, 65, 70, 60)
d.f_h_w <- data.frame(height, weight)

# 2. 결과 값 lm.result에 저장(list)
lm.result <- lm(weight ~ height, d.f_h_w)
summary(lm.result)  

# 3. 해당 list를 외부 파일(txt)로 저장
capture.output(summary(lm.result),
               file = "C:/rfriend/lm.result.txt",
               append = TRUE
               )


# str(), class(), dim(), head(), tail(), length(), names() : 객체를 관찰하는 함수 ----
# 데이터의 개수가 매우 많을 때, 해당 function을 이용하여 파악하는 것이 중요!
# R 내장 실습 데이터인 mtcars 를 해당 function을 이용해서 확인해보자

str(mtcars)    # DF의 column type 과 대략적인 값들을 확인할 수 있다
class(mtcars)  # 객체 자체에 대한 class(type) 을 확인할 수 있다
dim(mtcars)    # 객체에 대한 dimension 을 확인할 수 있다
head(mtcars)   # 상위 6개에 대한 data 정보를 확인할 수 있다
tail(mtcars)   # 하위 6개에 대한 data 정보를 확인할 수 있다
length(mtcars) # 객체에 대한 요소 개수를 확인할 수 있다
names(mtcars)  # 객체의 name(df -> 컬럼명)을 확인 할 수 있다

# dataFrame 변수를 활용하는 방법 3가지 ----
# 1. with(), attach() & detach() : 데이터 프레임 변수가 몇 개 안되는 경우 활성화 하여 사용

# 1.1 with() : 명령문이 한 줄인 경우 사용
# dataFrame명을 사용하지 않고, 변수명만을 이용하여 mpg의 0-1 표준 변환 해보기
with(mtcars, ((max(mpg) - mpg) / (max(mpg) - min(mpg))))

# 1.2 attach(), detach() : 하나의 데이터 프레임을 이용하여 다수의 명령어를 사용할 때,
# attach() : dataFrame 활성화, detach() : dataFrame 비 활성화
attach(mtcars)
((max(mpg) - mpg) / (max(mpg) - min(mpg)))
detach(mtcars)

# ** 주의할 점(중요)
# attach 로 특정 데이터프레임을 활성화 시킨 후에, 같은 이름의 변수명으로 벡터를 생성하면,
# 해당 변수는 dataFrame의 변수가 아니라 새로 생성된 변수 벡터로 계속 인식하게 됨
# 해결 방법 : $를 이용해서 변수를 가져오거나, rm() 을 이용하여 변수 삭제, 를 하면 된다

# attach로 dataFrame을 활성화 한 뒤, 활성화된 dataFrame을 변경한 경우,
# detach 한 뒤 다시 attach 해서 사용하자!

# read.fwf() : 일정한 간격의 데이터를 일정한 크기로 잘라서 가져올 때 ----
# fwf : fixed width file의 약자

# 1~2자리, 3~5자리, 6~8자리로 일정한 간격으로 되어있는 데이터 불러오기 : data_fwf.txt
# 2, 3, 3 간격으로 Var_1, Var_2, Var_3 변수로 나누어서 dataFrame을 형성할 때
read.fwf("C:/r/data_fwf.txt",
         widths = c(2, 3, 3),
         col.names = c("Var_1", "Var_2", "Var_3")         
         )


# rep(), seq() : 일정한 구조/순차적 데이터 생성
# 1. rep() : repeat(?)를 의미함. 
# 자주 쓰이는 case 4가지 예시

rep("a", 5)              # 문자형 a를 5번 반복할 때
rep(1, 10)               # 숫자 1을 10번 반복할 때
rep(c("a", 1), 5)        # a와 5를 "번갈아가며" 5번씩 반복할 때 : 1은 문자형으로 변환 
rep(c("a", 1), c(5, 5))  # a와 5를 5번씩 반복할 때 
rep(1:3, each = 3)       # 1부터 3을 3번씩 반복할 때

# 1행부터 20행까지 있는 데이터 프레임에서 1부터 5까지의 반복하는 숫자를 행 기준으로 반복하는 예제
x <- rep(1:5, each = 5)
dim(x) <- c(5,5)
x

# 2. seq() : 일정한 구조/순차적 데이터 생성
# seq -> sequence의 줄임말: 순차적이다의 의미

seq(from = 1, to = 10)  # 1부터 10까지 1씩 증가(default)
seq(from = 1, to = 10, by = 2) # 1부터 10까지 2씩 증가
seq(from = 1, to = 10, length = 5)  # 1에서 10까지 5 등간격으로 나타낼 때
seq(from = 1, by = 2, length.out = 10)  # length.out : 최대 개수

# abs(x), sqrt(x), ceiling(x), floor(x), trunc(x), round(x), log(x), exp(x), factorial(x) : 숫자형을 다루는 함수들
abs(-10)  # -> 10
sqrt(10)  # -> 루트 10
sqrt(-10) # -> 허수는 NaN
ceiling(6.8)  # -> 올림(정수로 만들어줌)
floor(6.7)    # -> 내림(정수로 만들어줌)
trunc(5.6666) # -> 소숫점은 잘라서 버림
round(3.6, digit = 0)    # -> 반올림. digit = 0 이 기준
log(10, base = 1)  # 밑이 1인 log10을 의미
exp(10)  # e^10 을 의미
factorial(10)  # 10! 의미

# mean(), median(), range(), sd(), var(), min(), max(), IQR(),
# diff(), length(), rank()

# fBasics::skewness, fBasics:::kurtosis  
# -> 왜도(skewness), 첨도(kurtosis)
install.packages("fBasics")
skewness(mtcars$mpg) 
kurtosis(mtcars$mpg)

diff(c(1,2,3), lag = 1) # 1차 차분
diff(c(3,4,5), lag = 2) # 2차 차분
rank(c(1,2,3))  # 조심! ranking 값을 알려주는 것이 아니라, ranking에 대한 index return

# 벡터의 최대, 최소 구할때 Tip!!
# min, max function을 이용할 때, "결측치"(NA)가 포함되어 있는 경우, NA return
# --> which.min, which.max를 이용하여 idx를 통해 값을 가져오면 NA 를 피해 최대, 최소 값을 구할 수 있음!!
test.minMax <- c(1,2,3,10,7,-3, NA)

# min() : NA, which.min : -3
min(test.minMax)  
test.minMax[which.min(test.minMax)]

# max() : NA, which.max : 10
max(test.minMax)
test.minMax[which.max(test.minMax)]

# matrix 
matrix(1:16, 4, byrow = T)  # byrow : row 방향 순서로 해당 vector 숫자를 matrix에 채워 넣음

# R, Python 등은 벡터 vs 스칼라, 벡터 vs 벡터를 논리 연산자를 이용해서 비교가 가능하다
test <- c(1,2,3,4,5)
test < 3  # 논리형 값(T, F)로 return

test2 <- c(3,3,3,4,4)
test < test2  # 벡터 별로 논리 연산자로 비교가 가능

# any() : 논리 연산자 중, 하나라도 TRUE면 TRUE를 return
any(test < test2)  # 1,2번 index에 TRUE 이므로, TRUE 스칼라 값을 return

# all() : 논리 연산자 중, 하나라도 FALSE 이면, FASLE를 return
all(test < test2)  # 3,4,5가 FALSE 이므로, FALSE return

# 일반적으로 데이터셋이 들어오면, 해당 데이터셋의 구조(str), 유형(class) 를 파악하는 것이 중요
# 이에 따라서 분석이 다르게 될 수 있음. 따라서 데이터셋을 불러 온 후, 해당 변수를 파악하여 데이터 형변환이 들어가는 것이 중요

# tapply(), sapply(), lapply(): 데이터 프레임 여러 변수에 함수 동시에 적용하기 ----
# apply 계열 3총사인 t, s, l을 알아보자

# 1. tapply() 
# 요인(factor)의 수준(level)별로 특정 벡터에 함수 명령어를 동시에 적용
#         사용형태 : tapply(벡터, 요인, 함수)
#         결과     : 벡터 또는 행렬

# Cars93 데이터를 가지고 차량 유형(Type)별 고속도록 연비(MPG.highway)의 평균과 표준편차를 tapply()를 활용해 구해보기
library(MASS)

# Cars93 구조 파악
str(Cars93)

# sapply를 이용하여 type 별 연비 평균 구하기
with(Cars93, tapply(MPG.highway, Type, mean))  # Type 별 연비 평균을 쉽게 구할 수 있음

# 2. sapply()
# 데이터 프레임 여러 변수에 함수 동시 적용 -> **결과는 벡터 또는 행렬
Sapply.cars93 <- sapply(Cars93, class)  # 해당 변수(컬럼)의 class 구하기
class(Sapply.cars93)

# 3. lapply()
# 데이터 프레임 여러 변수에 함수 동시 적용(sapply함수와 동일 기능 수행) -> ** 결과 값만 리스트
lapply(Cars93, class)  # 결과 값 list. -> indexing 하기 편리

# is.na(), sum(is.na()), na.rm = TRUE, na.omit(), complete.cases() : 결측치 확인 및 처리 ----
# 일반적으로, 데이터 구조나 유형을 파악했으면, 다음으로 EDA를 진행하는데 이때 결측을 많이 확인한다.
# why ? : 우선적으로 결측이 포함된 상태에서 분석을 진행하게 되면 결과 값이 NA가 나오는 경우가 많다. 따라서 처리가 필요한데,
#         일반적으로 함수에서 na.rm = T를 사용하거나, is.na(x) 를 이용해 제거를 한다.
# 이럴 때 사용하는 함수들을 하나씩 알아보자

# is.na() : 결측값이 포함되어 있는지 확인
x <- c(1, 2, 3, 4, NA, 6, 7, 8, 9, 10)
is.na(x)  # NA인 경우 TRUE로 return

# sum(is.na()) : 결측 값 개수 확인
sum(is.na(x))  # 총 결측 값 개수가 1개임을 확인

# colSums() : 데이터 프레임 다수 변수에 대한 결측 개수 제공
colSums(is.na(Cars93))  # mtcars dataSet의 변수별 결측치 개수를 알 수 있음

# na.rm = T : 통계 분석 시, 결측 값을 제외하고 계산
sum(x) # NA가 나옴을 확인
sum(x, na.rm = T)  # 결측 제외 후 통계 값 계산

# na.omit() : 결측값이 포함되어 있는 행을 데이터 셋 전체에서 제거
nrow(Cars93)          # 결측 값 제거 전 행 개수 -> 93개 
nrow(na.omit(Cars93)) # 결측 값이 포함되어 있는 행 제거 후 -> 82개

# complete.cases() : 특정 행, 열(조건)에 포함된 결측치의 행,열을 제거하고 싶을 때

# Cars93 데이터 프레임의 "Rear.seat.room" 칼럼 내 결측값이 있는 행 전체 삭제해보자
Cars93[complete.cases(Cars93[,"Rear.seat.room"]),]

# Cars93 데이터 프레임의 23, 24번째 칼럼 내 결측값이 있는 행 전체를 삭제해보자
Cars93[complete.cases(Cars93[,c(23,24)]),]

# 결측치 처리 예제 더보기
# 데이터프레임의 모든 행의 결측값을 특정 값(가령, '0')으로 일괄 대체 
mtcars6 <- mtcars
mtcars6[is.na(Cars93)] <- 0

# 데이터프레임의 각 변수의 결측값을 각 변수 별 평균값으로 일괄 대체
sapply(mtcars6, function(x) ifelse(is.na(x), mean(x, na.rm = T), x))

# %any% 특별 연산자 다뤄보기 ----
# %%, %/%, %*%, %in% 총 4 종류에 대해서 한번 알아보자!

# 예제 데이터
x <- c(1:10)
y <- 5

# 1. %% : 나머지 연산자
x %% y  # x를 y로 나눈 나머지 값으로 제공

# 5로 나눈 나머지가 0인 값만 추출
x[x %% y == 0]

# 2. %/% : 정수 몫만 가져오기
x %/% y  # 1 ~ 10의 값을 5로 나눈 몫만 가져옴


# 3. %*% : 행렬 곱하기 연산자
c(1, 2, 3) %*% c(4, 5, 6)  # 1*4 + 2*5 + 3*6 -> 32 

# 4. %in% : 벡터 내 특정 값 포함 여부 확인 연산자
x %in% y  # y가 5이므로, 5 번째 값이 TRUE로 return
           
# R 문자함수 알아보기
# nchar(), substr(), paste(), sub(), gsub(), grep(), regexp(), gregexpr()

# 1. nchar() : 문자형 벡터의 구성 요소 개수(문자열 길이) 제공
x <- c("Seoul", "New York", "London", "1234")
nchar(x)  # 해당 요소의 문자열 길이를 vector 값으로 return

# 2. substr() : 문자형 벡터의 start, stop 까지의 문자열 잘라서 제공
#               일반적으로 날짜형에서 해당 년, 월, 일을 추출할 때 사용.

time_stamp <- c("201507251040", "201507251041", "201507251042", "201507251043", "201507251044")
yyyymm <- substr(time_stamp, 1, 6)

# 3. paste() : 문자형 벡터 x와 y를 붙이기
paste("I", "LOVE", "YOU")
paste("I", "LOVE", "YOU", sep = "," )

# 4. strsplit() : 문자형 벡터를 split 기준으로 자르기
#                 결과 값이 list
name <- c("Chulsu, Kim", "Younghei, Lee", "Dongho, Choi")
strsplit(name, split = ",")  

# 데이터프레임에서 문자열을 구분자 기준으로 나누는 방법
df.name <- data.frame(ID = c(1:3), name = c("Chulsu/Kim", "Younghei/Lee", "Dongho/Choi"))
data.frame(do.call('rbind',
                   strsplit(as.character(df.name$name), split = "/", fixed = TRUE)
                   ))           

# 5. sub(old, new, x)  : 문자형 벡터 x에서 나오는 old 문자를 new 문자로 한번만 바꾸기
x <- c("My name is Chulsu. What's your name?")
sub("name", "age", x)

# 6. gsub(old, new, x) : 문자형 벡터 x에서 나오는 old 문자를 '전부' new 문자로 바꾸기
x <- c("My name is Chulsu. What's your name?")
gsub("name", "girlFriend name", x)

# 7. grep(pattern, x) : x 문자열 벡터에서 특정 부분 문자열 패턴 찾기
grep("1010", c("101010", "0101010", "110011"))

# 8. regexpr()  : text 내 패턴이 가장 먼저 나오는 위치 찾기
regexpr("NY", "I love NY and I'm from NY")

# 9. gregexpr() : text 내 에서 패턴이 나오는 모든 위치 찾기
gregexpr("NY", "I love NY and I'm from NY")


# 연속형 변수를 범주형 변수로 변환하는 3가지 방법 ----

# 데이터 준비 : 통계 시험 점수 (stat_score)
student_id <- c("s01", "s02", "s03", "s04", "s05", "s06", "s07", "s08", "s09", "s10")
stat_score <- c(56, 94, 82, 70, 64, 82, 78, 80, 76, 78)
mean(stat_score)
hist(stat_score)

# 데이터 프레임 생성
score.d.f <- data.frame(student_id, stat_score)
rm(student_id, stat_score)


# 1. cut() : 해당 함수를 이용하여 범주형 변수를 생성 가능
#            breaks -> 연속형 변수 cut 구간
#            right  -> TRUE 면,  a < x <= b 처럼,  오른쪽 구간에 =를 포함
#            right  -> FALSE 면, a <= x < b 처럼,  왼쪽 구간에 =를 포함

score.d.f <- transform(score.d.f,
          stat_score_1 = cut(stat_score, breaks = c(0, 60, 70, 80, 90, 100),
                             include.lowest = FALSE,
                             right  = FALSE,
                             labels = c("가", "양", "미", "우", "수")
                             )
          )


# 2. ifelse() : 단순 ifelse 를 통해서 범주형 변수를 생성 가능
score.d.f <- transform(score.d.f,
          stat_score_2 = ifelse(stat_score < 60, "가",
                         ifelse(stat_score >= 60 & stat_score < 70, "양",
                                ifelse(stat_score >= 70 & stat_score < 80, "미",
                                ifelse(stat_score >= 80 & stat_score < 90, "우", "수"
                                ))))
)

score.d.f <- within(score.d.f, {
                    stat_score_3 = character(0)
                    stat_score_3[stat_score < 60] = "가"
                    stat_score_3[stat_score >= 60 & stat_score < 70] = "양"
                    stat_score_3[stat_score >= 70 & stat_score < 80] = "미"
                    stat_score_3[stat_score >= 80 & stat_score < 90] = "우"
                    stat_score_3[stat_score >= 90 & stat_score <= 100] = "수"
                    stat_score_3 = factor(stat_score_3, levels = c("수", "우", "미", "양", "가"))
})                               
                                

# +, -, *, /, ^, %*%, cbind(), rbind(), colMeans(), rowMeans(), colSums(), rowSums(), t()  : 행렬 연산
A <- matrix(1:4, nrow = 2, ncol = 2, byrow = T)
B <- matrix(5:8, nrow = 2, ncol = 2, byrow = T)

# 1. +, -, *, / : 해당 요소 위치 별로 사칙 연산 수행
A + B
A - B
A * B
A / B

# 2. %*% : 행렬 곱(선형대수)
A %*% B

# 3. cbind() : 행렬 세로(열) 결합
cbind(A, B)

# 4. rbind() : 행렬 가로(행) 결합
rbind(A, B)

# 5. colMeans() : 열에 대한 평균 값 계산
colMeans(A)
colMeans(B)

# 6. rowMeans() : 행에 대한 평균 값 계산
rowMeans(A)
rowMeans(B)

# 7. rowSums() :  행에 대한 합 계산
rowSums(A)
rowSums(B)

# 8. colSums() :  열에 대한 합 계산
colSums(A)
colSums(B)

# 9. t() : 전치행렬 transpose. 행과 열을 대칭 변경
t(A) 

# names() : dataFrame의 이름(열) 변경

# 먼저 MASS 패키지에 있는 Cars93 데이터 프레임 내 1~5번째 변수만 선택해서, base 패키지에 있는 names() 함수로 변수명을 변경
library(MASS)
Cars93.subset <- Cars93[,c(1:5)]
names(Cars93.subset) <- c("v1", "v2", "v3", "v4", "v5")
names(Cars93.subset)  # v1 ~ v5로 변경 됨

# rename(): dataFrame 변수명 변경 3가지 방법 ----
# 중요한 것은 각 packag  별로 rename function의 사용방법이 다르므로, 주의해야한다!!

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


  
# 이변량
str(mtcars)
library(MASS)
str(Cars93)
chisq.test(table(Cars93$Origin, Cars93$Make))

library(psych)
cor(iris[,c(1:4)])
psych::corr.test(iris[,c(1:4)])




