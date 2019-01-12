# lasso 모형 - 변수 선택 예제 : lasso 모형을 만들고 변수 선택하기
# 스위스 47개주의 다양한 지표들을 이용해서 출산율 예측하기 - lasso 모형 이용
# glmnet()  : lasso 모형 function
install.packages("glmnet")
library(glmnet)

# 예제 데이터 : 1888경 프랑스어를 사용하는 스위스 내 47개 주의 출산율과 사회 경제적 지표(농업 종사자 비율, 군 입대 시험 성적, 교육 등)
# Fertility : 출산율
# Agriculture : 농업 종사자 비율
# Examination : 군 입대 시험 성적
# Education   : 교육
# Catholic    : 종교(?)
# Infant.Mortality : 유아 사망율

swiss <- datasets::swiss
head(swiss)

# 1. x,y 변수 생성. y : fertility
x <- model.matrix(Fertility ~., swiss)[,-1]
y <- swiss$Fertility

# 2. trainset, testset 생성
set.seed(1001)
train <- sample(1:nrow(x), nrow(x)/2, replace = F)
test <- (-train)

xTrain <- x[train, ]
xTest  <- x[test,  ]

yTrain <- y[train]
yTest  <- y[test]

# 3. glmnet을 이용한 lasso 모형 생성
fit.lasso <- cv.glmnet(xTrain, yTrain, alpha = 1)
plot(fit.lasso)
fit.lasso.param <- fit.lasso$lambda.min
fit.lasso.tune  <- glmnet(xTrain, yTrain, lambda = fit.lasso.param)
coef(fit.lasso.tune)

# 4. lars를 이용한 lasso 모형
install.packages("lars")
library(lars)

object <- lars(xTrain, yTrain, type = "lasso")
plot(object)
coef(object, s = 4)  # 4면 변수 3개 선택

## 요인 분석(factor analysis)
#  등간 척도(비율 척도)로 측정한 두 개 이상의 다수의 변수들에 잠재되어 있는 공통 인자를 찾아내는 기법
#  통계학자 spearman이 학생들의 시험 성적(Math, english, French) 간의 상관 관계를 보다가 어떻게 하면 연관성 있는 변수를 묶어주는
#  내재하는 속성을 뽑아 낼 수 있을까에서 출발

## ** 요인분석과 주성분분석의 관계(꼭 제대로 알아두기)
# 두 분석이 깊은 관계를 가지고 있지만, 완전히 같은 것은 아니다ㅜ
# 요인 분석을 수행하기 위해서, 즉 몇 개의 잠재 변수를 뽑아 내기 위해서 여러 가지 분석 기법을 사용할 수 있지만
# 그 중에서 가장 많이 사용되는 것이 주성분 분석(PCA) 이다. 하지만 포함 관계는 아니다

# ** 공통점
# 1. 모든 데이터를 축소한다
# 2. 원래 데이터의 몇 개의 변수들로 만들어 낸다

# *** 차이점
# 1. 생성되는 변수의 수
# FA  : 몇 개라고 지정할 수 없다. 데이터의 의미에 따라 다르다. 3개가 될 수도 있고 4개가 될 수도 있다 
# PCA : 주성분이라고 하며, 보통 2개를 찾는다

# 2.  생성되는 변수의 이름
# FA  : 분석가가 적절한 이름을 붙여 줄 수 있다. 자동으로 붙여주진 않는다
# PCA : 적절한 이름을 붙여주는게 쉽진 않다. (할 수는 있다). 의미 중심으로 붙여졌기 보다는 성능 위주로 되어있기 때문.


# 3. 생성된 변수들의 관계
# FA  : 서로 동등한 관계를 가지고 있다. 어떤 것이 더 중요하다는 의미는 요인분석에서는 없다 
# PCA : 제 1주성분이 가장 중요하고, 다음은 제2주성분이 중요하게 취급 된다 

# 4. 분석 방법의 의미
# FA  : 목표 필드를 고려하지 않는다(비지도 학습의 일종)
# PCA : 목표 변수를 고려한다(지도 학습)

# 요인 추출 방법으로 주성분 분석이 많이 사용
# 요인 분석을 할 때 초기 값 m을 어떻게 잡아주느냐가 굉장히 중요한데,
# 보통 반응 변수(종속 변수)의 변동량을 대부분 설명할 수 있는 eigenvector, eigenvalue의 수는 몇개인가 결정할 수 있는
# 주성분 분석을 사용

# 용어 설명(참조)
# 요인점수 (Factor Score) : 각 관측치의 요인 점수는 요인 점수 계수(Standardized Scoring Coefficients)와 실제 (표준화된) 관측치의 값의 곱으로 
#                           구하며 요인별로 이를 summation하면 요인별 요인점수가 됨.

# 요인패턴 (Factor Loading) :  각 요인이 각 변수에 미치는 효과.  변수와 요인의 상관 행렬

# 공통 분산치 (Communality) : 요인에 의해 설명될 수 있는 변수의 분산량

# 요인회전 (Factor Rotation) : p개의 변수들을 m개의 요인(factor)로 묶어주기 편리하게 혹은 해석하기 쉽게하도록 축을 회전시키는 것. 직교회전에 
#                              varimax, transvarimax 등이 있고 비직교회전방법도 있으며, 보통 분산을 최대화하는 직교회전방법 varimax 를 많이 씀

# 앞서 PCA에서 사용했던 데이터 그대로 이용
# R로 외부 csv 데이터 불러오기, 표준화 변환, 부채비율 방향 변환, 변수 선택, 상관계수분석, 산포도행렬은 동일
setwd("C:/rfriend")
secu_com_finance_2007 <- read.csv("secu_com_finance_2007.csv",
                                            header = TRUE, 
                                            stringsAsFactors = FALSE)
# V1 : 총자본순이익율
# V2 : 자기자본순이익율
# V3 : 자기자본비율
# V4 : 부채비율
# V5 : 자기자본회전율
 
 
# 표준화 변환 (standardization)
secu_com_finance_2007 <- transform(secu_com_finance_2007, 
                                          V1_s = scale(V1), 
                                          V2_s = scale(V2), 
                                          V3_s = scale(V3), 
                                          V4_s = scale(V4),
                                          V5_s = scale(V5))

# 부채비율(V4_s)을 방향(max(V4_s)-V4_s) 변환
secu_com_finance_2007 <- transform(secu_com_finance_2007, 
                                       V4_s2 = max(V4_s) - V4_s)
 
# variable selection 
secu_com_finance_2007_2 <- secu_com_finance_2007[,c("company", "V1_s", "V2_s", "V3_s", "V4_s2", "V5_s")]
 
# Correlation analysis
cor(secu_com_finance_2007_2[,-1])

# 반올림
round(cor(secu_com_finance_2007_2[,-1]), digits=3)

# factanal() : 요인 분석 실시
# factanal(data, factors = 요인 개수 지정, ratation = 회전 방법(?) 지정, scores = 요인 점수 계산 방법 지정)

# rotation = "varimax"

# 요인 3개 이상 할당하면, warning
secu_factanal <- factanal(secu_com_finance_2007_2[,2:6], 
                                          factors = 2, 
                                 rotation = "varimax", # "varimax", "promax", "none" 
                                  scores="regression") # "regression", "Bartlett"

print(secu_factanal)

# Loading에서 비어있는 값은 cutoff = 0으로 해주면 보임
# Factor1 : V3_s, V4_s2 이 같이 묶임
# Factor2 : V1_s, V2_s  이 같이 묶임
# V5는 좀 애매하긴 하지만, Factor1은 -값을 가지고 있으므로 Factor2에 포함

print(secu_factanal$loadings, cutoff = 0)

# biplot 그리기 : PCA 처럼 바로 그릴수 있는 함수는 없음
# 직접 만들어서 보아야 함
secu_factanal$scores

# 관측치 plotting
plot(secu_factanal$scores, main="Biplot of the first 2 factors")

# 관측지 별 이름 mapping
text(secu_factanal$scores[,1], secu_factanal$scores[,2], 
                               labels = secu_com_finance_2007$company, 
                               cex = 0.7, pos = 3, col = "blue")


# factor loadings plotting
points(secu_factanal$loadings, pch=19, col = "red")

# factor mapping
text(secu_factanal$loadings[,1], secu_factanal$loadings[,2], 
     labels = rownames(secu_factanal$loadings), 
     cex = 0.8, pos = 3, col = "red")

# plotting lines between (0,0)
segments(0,0,secu_factanal$loadings[1,1], secu_factanal$loadings[1,2])
segments(0,0,secu_factanal$loadings[2,1], secu_factanal$loadings[2,2])
segments(0,0,secu_factanal$loadings[3,1], secu_factanal$loadings[3,2])
segments(0,0,secu_factanal$loadings[4,1], secu_factanal$loadings[4,2])
segments(0,0,secu_factanal$loadings[5,1], secu_factanal$loadings[5,2])

# sqldf package : R에서 SQL 사용 할 수 있음
# but, 성능 문제가 존재하므로, 대량 데이터에서는 사용 안함을 추천!

# 실습 : aggregate(), sqldf() 를 비교해 가면서 사용해보기

# 1. aggregate() 함수로 차종(Type) 별 도시 연비(MPG.City) 와
# 고속도로 연비(MPG.highway) 구해 보기
library(MASS)
str(Cars93)
R.aggregate.mean <- aggregate(Cars93[,c(7, 8)], 
                              by = list(Car.type = Cars93$Type),
                              FUN = mean,
                              na.rm = TRUE
                              )

# 2. sqldf pacakge 이용
install.packages("sqldf")
library(sqldf)
R.sqldf.1 <- sqldf('
                   select "Type" as "Car.Type",
                   avg("MPG.city") as "mean.MPG.city",
                   avg("MPG.highway") as "mean.MPG.highway"
                   from Cars93
                   group by Type
                   order by Type
                   ')

# melt(), cast() : 데이터 재 구조화
# 말로 설명하기 힘드므로, 예제를 통해서 확인해보자

library(MASS)
str(Cars93)

# 차종(Type) : Compact, Van 만 선별해서 예제로 만들어 사용
#              그래야 구조 변환을 한눈에 보기 쉬움
Cars93.sample <- subset(Cars93, select = c("Type", "Origin", "MPG.city", "MPG.highway"),
               subset = (Type %in% c("Compact", "Van") )
       )

# 1. melt() : 두 개의 변수를 한곳에 녹이기(melt)
# MPG.city, MPG.highway 컬럼 변수를 녹여보자
# -> id.vars -> 기준 컬럼, measure.vars -> 녹일 컬럼

library(reshape)

Cars93.sample.melt <- melt(data         = Cars93.sample, 
     id.vars      = c("Type", "Origin"),
     measure.vars = c("MPG.city", "MPG.highway"))

# variable이라는 컬럼에 해당 MPG.city, MPG.highway 변수명이 들어가고, 해당 value가 value 컬럼에 들어가 있음을 확인할 수 있다
head(Cars93.sample.melt)

# 2. cast() : melt 된 함수를 다시 columnize 진행
options(digit = 3)

# 해당 TYpe, Origin 을 기준으로 value 값의 mean을 계산
cast(data = Cars93.sample.melt, Type + Origin ~ variable, fun = mean)

# R cleansing of console, environment, Plots
# 1. console
cat("\014")

# 2. Environment
rm(list = ls())

# 3. Plot
dev.off()

# unique(), dataframe[!duplicated(var), ], distinct() : 중복 없는 유일한 관측치 선별하기
# 일반적으로 BigData일때는 R에서 제거

# 1. unique()
# base::unique(), 데이터프레임, 배열, 행렬 모두 사용 가능

# 중복 데이터 생성
a1 <- rep(1:10, each = 2)
a2 <- rep(c(1,3,5,7,9), each = 4)
a3 <- c(1, 1, 1, 1, 3, 3, 3, 3, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10, 11, 12)
a1a2a3 <- data.frame(cbind(a1, a2, a3))

# a1, a2 변수를 기준으로 중복 관측치 제거 
a1a2a3.uniq.var2 <- unique(a1a2a3[, c("a1", "a2")])
a1a2a3.uniq.var2
nrow(a1a2a3.uniq.var2)

# a1, a2, a3 변수를 기준으로 중복 제거
a1a2a3.uniq.var3 <- unique(a1a2a3[,c("a1", "a2", "a3")])
a1a2a3.uniq.var3
nrow(a1a2a3.uniq.var3)

# unique(x, fromLast = TRUE) : 중복된 관측치 중, 
#                   제일 마지막 관측치만 남기고 제거하고 싶을 때
#                   default : FALSE
# 활용 : a1, a2로만 중복 관측치 제거하고, 관측치 중에 a3가 가장 큰 관측치만
#        남기고 싶을 때, 사용

unique(a1a2a3, fromLast = TRUE)

# 2. duplicated() : dataframe에서 중복치를 제거한 나머지 관측치에 대해서
#                   indexing 하고 싶을 때


duplicated(a1a2a3$a1)  # 어떤 값이 TRUE, FALSE 인지 살펴보기

# 활용
a1a2a3[duplicated(a1a2a3$a1), ]

# 3. dplyr::distinct()
# dplyr package 참조


# 결측값 때문에 파일에서 데이터 불러오기가 안되는 경우

# 1. fill = TRUE 매개변수 추가
# 1. read.table("text.txt", header = TRUE, fill = TURE)
# **** 주의! fill = TRUE 시, 제일 마지막 행 값이 NA 처리된다




















