# lasso ���� - ���� ���� ���� : lasso ������ ����� ���� �����ϱ�
# ������ 47������ �پ��� ��ǥ���� �̿��ؼ� ����� �����ϱ� - lasso ���� �̿�
# glmnet()  : lasso ���� function
install.packages("glmnet")
library(glmnet)

# ���� ������ : 1888�� ������� ����ϴ� ������ �� 47�� ���� ������� ��ȸ ������ ��ǥ(��� ������ ����, �� �Դ� ���� ����, ���� ��)
# Fertility : �����
# Agriculture : ��� ������ ����
# Examination : �� �Դ� ���� ����
# Education   : ����
# Catholic    : ����(?)
# Infant.Mortality : ���� �����

swiss <- datasets::swiss
head(swiss)

# 1. x,y ���� ����. y : fertility
x <- model.matrix(Fertility ~., swiss)[,-1]
y <- swiss$Fertility

# 2. trainset, testset ����
set.seed(1001)
train <- sample(1:nrow(x), nrow(x)/2, replace = F)
test <- (-train)

xTrain <- x[train, ]
xTest  <- x[test,  ]

yTrain <- y[train]
yTest  <- y[test]

# 3. glmnet�� �̿��� lasso ���� ����
fit.lasso <- cv.glmnet(xTrain, yTrain, alpha = 1)
plot(fit.lasso)
fit.lasso.param <- fit.lasso$lambda.min
fit.lasso.tune  <- glmnet(xTrain, yTrain, lambda = fit.lasso.param)
coef(fit.lasso.tune)

# 4. lars�� �̿��� lasso ����
install.packages("lars")
library(lars)

object <- lars(xTrain, yTrain, type = "lasso")
plot(object)
coef(object, s = 4)  # 4�� ���� 3�� ����

## ���� �м�(factor analysis)
#  � ô��(���� ô��)�� ������ �� �� �̻��� �ټ��� �����鿡 ����Ǿ� �ִ� ���� ���ڸ� ã�Ƴ��� ���
#  ������� spearman�� �л����� ���� ����(Math, english, French) ���� ��� ���踦 ���ٰ� ��� �ϸ� ������ �ִ� ������ �����ִ�
#  �����ϴ� �Ӽ��� �̾� �� �� ������� ���

## ** ���κм��� �ּ��км��� ����(�� ����� �˾Ƶα�)
# �� �м��� ���� ���踦 ������ ������, ������ ���� ���� �ƴϴ٤�
# ���� �м��� �����ϱ� ���ؼ�, �� �� ���� ���� ������ �̾� ���� ���ؼ� ���� ���� �м� ����� ����� �� ������
# �� �߿��� ���� ���� ���Ǵ� ���� �ּ��� �м�(PCA) �̴�. ������ ���� ����� �ƴϴ�

# ** ������
# 1. ��� �����͸� ����Ѵ�
# 2. ���� �������� �� ���� ������� ����� ����

# *** ������
# 1. �����Ǵ� ������ ��
# FA  : �� ����� ������ �� ����. �������� �ǹ̿� ���� �ٸ���. 3���� �� ���� �ְ� 4���� �� ���� �ִ� 
# PCA : �ּ����̶�� �ϸ�, ���� 2���� ã�´�

# 2.  �����Ǵ� ������ �̸�
# FA  : �м����� ������ �̸��� �ٿ� �� �� �ִ�. �ڵ����� �ٿ����� �ʴ´�
# PCA : ������ �̸��� �ٿ��ִ°� ���� �ʴ�. (�� ���� �ִ�). �ǹ� �߽����� �ٿ����� ���ٴ� ���� ���ַ� �Ǿ��ֱ� ����.


# 3. ������ �������� ����
# FA  : ���� ������ ���踦 ������ �ִ�. � ���� �� �߿��ϴٴ� �ǹ̴� ���κм������� ���� 
# PCA : �� 1�ּ����� ���� �߿��ϰ�, ������ ��2�ּ����� �߿��ϰ� ��� �ȴ� 

# 4. �м� ����� �ǹ�
# FA  : ��ǥ �ʵ带 �������� �ʴ´�(������ �н��� ����)
# PCA : ��ǥ ������ �����Ѵ�(���� �н�)

# ���� ���� ������� �ּ��� �м��� ���� ���
# ���� �м��� �� �� �ʱ� �� m�� ��� ����ִ��İ� ������ �߿��ѵ�,
# ���� ���� ����(���� ����)�� �������� ��κ� ������ �� �ִ� eigenvector, eigenvalue�� ���� ��ΰ� ������ �� �ִ�
# �ּ��� �м��� ���

# ��� ����(����)
# �������� (Factor Score) : �� ����ġ�� ���� ������ ���� ���� ���(Standardized Scoring Coefficients)�� ���� (ǥ��ȭ��) ����ġ�� ���� ������ 
#                           ���ϸ� ���κ��� �̸� summation�ϸ� ���κ� ���������� ��.

# �������� (Factor Loading) :  �� ������ �� ������ ��ġ�� ȿ��.  ������ ������ ��� ���

# ���� �л�ġ (Communality) : ���ο� ���� ������ �� �ִ� ������ �л귮

# ����ȸ�� (Factor Rotation) : p���� �������� m���� ����(factor)�� �����ֱ� �����ϰ� Ȥ�� �ؼ��ϱ� �����ϵ��� ���� ȸ����Ű�� ��. ����ȸ���� 
#                              varimax, transvarimax ���� �ְ� ������ȸ������� ������, ���� �л��� �ִ�ȭ�ϴ� ����ȸ����� varimax �� ���� ��

# �ռ� PCA���� ����ߴ� ������ �״�� �̿�
# R�� �ܺ� csv ������ �ҷ�����, ǥ��ȭ ��ȯ, ��ä���� ���� ��ȯ, ���� ����, �������м�, ����������� ����
setwd("C:/rfriend")
secu_com_finance_2007 <- read.csv("secu_com_finance_2007.csv",
                                            header = TRUE, 
                                            stringsAsFactors = FALSE)
# V1 : ���ں���������
# V2 : �ڱ��ں���������
# V3 : �ڱ��ں�����
# V4 : ��ä����
# V5 : �ڱ��ں�ȸ����
 
 
# ǥ��ȭ ��ȯ (standardization)
secu_com_finance_2007 <- transform(secu_com_finance_2007, 
                                          V1_s = scale(V1), 
                                          V2_s = scale(V2), 
                                          V3_s = scale(V3), 
                                          V4_s = scale(V4),
                                          V5_s = scale(V5))

# ��ä����(V4_s)�� ����(max(V4_s)-V4_s) ��ȯ
secu_com_finance_2007 <- transform(secu_com_finance_2007, 
                                       V4_s2 = max(V4_s) - V4_s)
 
# variable selection 
secu_com_finance_2007_2 <- secu_com_finance_2007[,c("company", "V1_s", "V2_s", "V3_s", "V4_s2", "V5_s")]
 
# Correlation analysis
cor(secu_com_finance_2007_2[,-1])

# �ݿø�
round(cor(secu_com_finance_2007_2[,-1]), digits=3)

# factanal() : ���� �м� �ǽ�
# factanal(data, factors = ���� ���� ����, ratation = ȸ�� ���(?) ����, scores = ���� ���� ��� ��� ����)

# rotation = "varimax"

# ���� 3�� �̻� �Ҵ��ϸ�, warning
secu_factanal <- factanal(secu_com_finance_2007_2[,2:6], 
                                          factors = 2, 
                                 rotation = "varimax", # "varimax", "promax", "none" 
                                  scores="regression") # "regression", "Bartlett"

print(secu_factanal)

# Loading���� ����ִ� ���� cutoff = 0���� ���ָ� ����
# Factor1 : V3_s, V4_s2 �� ���� ����
# Factor2 : V1_s, V2_s  �� ���� ����
# V5�� �� �ָ��ϱ� ������, Factor1�� -���� ������ �����Ƿ� Factor2�� ����

print(secu_factanal$loadings, cutoff = 0)

# biplot �׸��� : PCA ó�� �ٷ� �׸��� �ִ� �Լ��� ����
# ���� ���� ���ƾ� ��
secu_factanal$scores

# ����ġ plotting
plot(secu_factanal$scores, main="Biplot of the first 2 factors")

# ������ �� �̸� mapping
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

# sqldf package : R���� SQL ��� �� �� ����
# but, ���� ������ �����ϹǷ�, �뷮 �����Ϳ����� ��� ������ ��õ!

# �ǽ� : aggregate(), sqldf() �� ���� ���鼭 ����غ���

# 1. aggregate() �Լ��� ����(Type) �� ���� ����(MPG.City) ��
# ���ӵ��� ����(MPG.highway) ���� ����
library(MASS)
str(Cars93)
R.aggregate.mean <- aggregate(Cars93[,c(7, 8)], 
                              by = list(Car.type = Cars93$Type),
                              FUN = mean,
                              na.rm = TRUE
                              )

# 2. sqldf pacakge �̿�
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

# melt(), cast() : ������ �� ����ȭ
# ���� �����ϱ� ����Ƿ�, ������ ���ؼ� Ȯ���غ���

library(MASS)
str(Cars93)

# ����(Type) : Compact, Van �� �����ؼ� ������ ����� ���
#              �׷��� ���� ��ȯ�� �Ѵ��� ���� ����
Cars93.sample <- subset(Cars93, select = c("Type", "Origin", "MPG.city", "MPG.highway"),
               subset = (Type %in% c("Compact", "Van") )
       )

# 1. melt() : �� ���� ������ �Ѱ��� ���̱�(melt)
# MPG.city, MPG.highway �÷� ������ �쿩����
# -> id.vars -> ���� �÷�, measure.vars -> ���� �÷�

library(reshape)

Cars93.sample.melt <- melt(data         = Cars93.sample, 
     id.vars      = c("Type", "Origin"),
     measure.vars = c("MPG.city", "MPG.highway"))

# variable�̶�� �÷��� �ش� MPG.city, MPG.highway �������� ����, �ش� value�� value �÷��� �� ������ Ȯ���� �� �ִ�
head(Cars93.sample.melt)

# 2. cast() : melt �� �Լ��� �ٽ� columnize ����
options(digit = 3)

# �ش� TYpe, Origin �� �������� value ���� mean�� ���
cast(data = Cars93.sample.melt, Type + Origin ~ variable, fun = mean)

# R cleansing of console, environment, Plots
# 1. console
cat("\014")

# 2. Environment
rm(list = ls())

# 3. Plot
dev.off()

# unique(), dataframe[!duplicated(var), ], distinct() : �ߺ� ���� ������ ����ġ �����ϱ�
# �Ϲ������� BigData�϶��� R���� ����

# 1. unique()
# base::unique(), ������������, �迭, ��� ��� ��� ����

# �ߺ� ������ ����
a1 <- rep(1:10, each = 2)
a2 <- rep(c(1,3,5,7,9), each = 4)
a3 <- c(1, 1, 1, 1, 3, 3, 3, 3, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10, 11, 12)
a1a2a3 <- data.frame(cbind(a1, a2, a3))

# a1, a2 ������ �������� �ߺ� ����ġ ���� 
a1a2a3.uniq.var2 <- unique(a1a2a3[, c("a1", "a2")])
a1a2a3.uniq.var2
nrow(a1a2a3.uniq.var2)

# a1, a2, a3 ������ �������� �ߺ� ����
a1a2a3.uniq.var3 <- unique(a1a2a3[,c("a1", "a2", "a3")])
a1a2a3.uniq.var3
nrow(a1a2a3.uniq.var3)

# unique(x, fromLast = TRUE) : �ߺ��� ����ġ ��, 
#                   ���� ������ ����ġ�� ����� �����ϰ� ���� ��
#                   default : FALSE
# Ȱ�� : a1, a2�θ� �ߺ� ����ġ �����ϰ�, ����ġ �߿� a3�� ���� ū ����ġ��
#        ����� ���� ��, ���

unique(a1a2a3, fromLast = TRUE)

# 2. duplicated() : dataframe���� �ߺ�ġ�� ������ ������ ����ġ�� ���ؼ�
#                   indexing �ϰ� ���� ��


duplicated(a1a2a3$a1)  # � ���� TRUE, FALSE ���� ���캸��

# Ȱ��
a1a2a3[duplicated(a1a2a3$a1), ]

# 3. dplyr::distinct()
# dplyr package ����


# ������ ������ ���Ͽ��� ������ �ҷ����Ⱑ �ȵǴ� ���

# 1. fill = TRUE �Ű����� �߰�
# 1. read.table("text.txt", header = TRUE, fill = TURE)
# **** ����! fill = TRUE ��, ���� ������ �� ���� NA ó���ȴ�



















