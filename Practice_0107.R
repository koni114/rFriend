# dataFrame$variable, transform() : ������������ ���� �ű� ���� ----
# �ǽ� ���� : BMI(ü��������) �߰��غ���, BMI -> w / t^2

height <- c(175, 159, 166, 189, 171, 173, 179)
weight <- c(62, 55, 59, 75, 61, 64, 63)
human.data <- data.frame(height, weight)

# 1. dataFrame$variable
human.data$BMI <- weight / (height/100)^2

# 2. transform()
human.data <- transform(human.data, BMI = weight / (height/100)^2 )

# which(), subset(), select : dataFrame ���� ���� ----
# data : mtcars
# ���ӱⰡ �ڵ�(am == 0)�̰�, �Ǹ����� 4��, 6����(cyl == c(4,6)) �ڵ������� ����(mpg) �����? 

# 1. which() �̿�
mean(mtcars[which(mtcars$am == 0 & mtcars$cyl == c(4,6)),]$mpg)

# 2. subset() �̿�
mean(subset(mtcars, select = c("mpg", "am", "cyl") , subset = (am == 0 & cyl == c(4,6)))$mpg)

# ** which() VS subset()
# indexing & which �Լ��� �̿��ؼ� �÷� ���� 1���� slicing�� �ϴ� ���, return : vector
# subset �Լ��� �̿��ؼ� �÷� ���� 1���� slicing �ϴ� ���, return : dataFrame
# indexing & which �Լ��� �̿��� ��, dataFrame���� return �ϰ� ���� ���, drop = False parameter ����

# sort(), order(), arrange() : ������ ���� ----
# 1. sort() : ���ĵ� ��(value) return
test <- c(1,4,7,3,10,9,15)
sort(test)
 
# order() : ���Ŀ� ���� index return
#           sort()�� dataFrame�� ���� �� ������, order�� ��� ����
order(test)
test[order(test)]  # sort(test)�� ���� �� return

v123 <- data.frame(v1 = c(40, 30, 50, 50, 90), v2 = c(5100, 6500, 2000, 2000, 9000), v3 = c("A", "B", "B", "A", "B"))
v123.order <- v123[order(v123$v1, -v123$v2, v123$v3), ]  # v1 �� ���� ���� ���, v2 ���������� �������ִ� ���

# plyr::arrange(dataframe, var1, desc(var2)...)
library(plyr)
plyr::arrange(v123, v1, desc(v2), v3)

# merge() : ���� key �� ���� ���� ----
#           3�� �̻� ���� ��, error

# merge �Լ��� join ����
# merge(A, B, by = 'key')               # inner join
# merge(A, B, by = 'key', all = TRUE)   # Outer join
# merge(A, B, by = 'key', all.x = TRUE) # left Outer join
# merge(A, B, by = 'key', all.y = TRUE) # right Outer join

data1 <- data.frame(A1 = c(1,2,3), B1 = c("A", "B", "A"))
data2 <- data.frame(A1 = c(2,3,4), C1 = c("C", "C", "B"))
merge(data1, data2, by = "A1", all = TRUE)

# ������ ��ȯ(data transformation) ----
# ������ ��ȯ�� �𵨸��� �ϴµ� �־� ���ǹ��ϰ�, ������ �Ļ������� �����ϰ�,
# input data�� �ִ� ���� ���� �߿���. �� �� �ʿ���  6���� ī�װ��� ��ȯ �۾��� �˾ƺ���

# (1).  ������ ��ȯ : ǥ��ȭ ----

# (2).  ǥ�����Ժ��� z ��ȯ
f <- function(x) x^2
tt <- 'test'
is.function(tt)

objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)

f_arg_length <- sapply(funs, function(x) length(formals(x)))
f_arg_length[which.max(f_arg_length)]



