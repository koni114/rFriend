# dataFrame$variable, transform() : 데이터프레임 변수 신규 생성 ----
# 실습 예제 : BMI(체질량지수) 추가해보기, BMI -> w / t^2

height <- c(175, 159, 166, 189, 171, 173, 179)
weight <- c(62, 55, 59, 75, 61, 64, 63)
human.data <- data.frame(height, weight)

# 1. dataFrame$variable
human.data$BMI <- weight / (height/100)^2

# 2. transform()
human.data <- transform(human.data, BMI = weight / (height/100)^2 )

# which(), subset(), select : dataFrame 변수 선택 ----
# data : mtcars
# 변속기가 자동(am == 0)이고, 실린더가 4개, 6개인(cyl == c(4,6)) 자동차들의 연비(mpg) 평균은? 

# 1. which() 이용
mean(mtcars[which(mtcars$am == 0 & mtcars$cyl == c(4,6)),]$mpg)

# 2. subset() 이용
mean(subset(mtcars, select = c("mpg", "am", "cyl") , subset = (am == 0 & cyl == c(4,6)))$mpg)

# ** which() VS subset()
# indexing & which 함수를 이용해서 컬럼 변수 1개를 slicing을 하는 경우, return : vector
# subset 함수를 이용해서 컬럼 변수 1개를 slicing 하는 경우, return : dataFrame
# indexing & which 함수를 이용할 때, dataFrame으로 return 하고 싶은 경우, drop = False parameter 지정

# sort(), order(), arrange() : 데이터 정렬 ----
# 1. sort() : 정렬된 값(value) return
test <- c(1,4,7,3,10,9,15)
sort(test)
 
# order() : 정렬에 대한 index return
#           sort()은 dataFrame에 사용될 수 없으나, order는 사용 가능
order(test)
test[order(test)]  # sort(test)와 같은 값 return

v123 <- data.frame(v1 = c(40, 30, 50, 50, 90), v2 = c(5100, 6500, 2000, 2000, 9000), v3 = c("A", "B", "B", "A", "B"))
v123.order <- v123[order(v123$v1, -v123$v2, v123$v3), ]  # v1 이 같은 값인 경우, v2 내림차순을 정렬해주는 방법

# plyr::arrange(dataframe, var1, desc(var2)...)
library(plyr)
plyr::arrange(v123, v1, desc(v2), v3)

# merge() : 동일 key 값 기준 결합 ----
#           3개 이상 결합 시, error

# merge 함수의 join 종류
# merge(A, B, by = 'key')               # inner join
# merge(A, B, by = 'key', all = TRUE)   # Outer join
# merge(A, B, by = 'key', all.x = TRUE) # left Outer join
# merge(A, B, by = 'key', all.y = TRUE) # right Outer join

data1 <- data.frame(A1 = c(1,2,3), B1 = c("A", "B", "A"))
data2 <- data.frame(A1 = c(2,3,4), C1 = c("C", "C", "B"))
merge(data1, data2, by = "A1", all = TRUE)

# 데이터 변환(data transformation) ----
# 데이터 변환은 모델링을 하는데 있어 유의미하고, 적합한 파생변수를 생성하고,
# input data로 넣는 것이 정말 중요함. 이 때 필요한  6가지 카테고리 변환 작업을 알아보자

# (1).  데이터 변환 : 표준화 ----

# (2).  표준정규분포 z 변환
f <- function(x) x^2
tt <- 'test'
is.function(tt)

objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)

f_arg_length <- sapply(funs, function(x) length(formals(x)))
f_arg_length[which.max(f_arg_length)]




