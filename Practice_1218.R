# dplyr package �����ϱ�
# �⺻������ dplyr���� ���� �����Ҷ�, ����ǥ ������� �ʴ´�
# but, �Լ� ���� �Լ��� ����Ͽ� ������ �Ŵ� ���, ����ǥ ���(���ܵ� ����)
library(dplyr)
# 0. chain operator : %>%
# chain operator �� ����ϸ� ���������� �Լ��� ����� data�� ��� ����� �� ����
# ** ����Ű: ctrl + shift + M

# 1. filter(): ���� ���� filtering : ��� ���� ������ ����� filtering �� dataFrame���� ���� ----
iris %>% filter(Sepal.Length < 5.0 & Petal.Length > 3.0)

# 2. slice() : index�� �̿��Ͽ� ���� slicing �� �� ��� ----
iris %>% slice(1:10) 

# 3. select() : ���� ���� �� �� ��� ----
iris %>% select(Sepal.Length, Petal.Length)

# 3.1. starts_with("����") : �ش� ���ڿ��� �����ϴ� �� ����
iris %>% select(starts_with("Sepal"))

# 3.2. ends_with("����") : �ش� ���ڿ��� ������ �� ����
iris %>% select(ends_with("Length"))

# 3.3 contains("") : �ش� ���ڿ��� ���ԵǴ� �� ����
iris %>% select(contains("Sep"))

# 3.4 matchs() : ���� ǥ���Ŀ� �ش��ϴ� �÷� ����

# 3.5 one_of() : ���� �̸� �ۺο� ���Ե� ��� �� ����
# ** �׳� select���� ����ϴ� �Ͱ��� ������ : one_of()�� ����ϸ� �ش� ������ ���� �ϳ��� ������ error�� �߻���Ű�� ����
vars <- c("test1", "test2", "test3")
iris %>% select(one_of(vars))  # warning�� �߻���Ű��, row 0 retrun
iris %>% select(vars)  # error �߻�

# 3.6 num_range() : (Ư�� ���λ� + ���� ����)�� �̿��Ͽ� ���� ã�� ��
iris %>% select(num_range("V", 2:3))

# 4. rename() : �÷� ���� ���� ----
# ** ���� reshape::rename �� ��ġ�� �ʰ� ����!! 
# reshape::rename �� �÷����� ����ǥ ���� O
# dplyr::rename �� �÷����� ����ǥ ���� X

iris %>% rename(V10 = Sepal.Length, V20 = Sepal.Width)

# 5. distinct() : �ߺ����� ������ ���� ���� ----

# dplyr::distinct() VS base::unique()

# 5.1. ���� 
#           dplyr::distinct() -> ���� 
#           base::unique()    -> ����

# 5.2. return type - ����(��) �Ѱ� ������ ��  
#            dplyr::distinct() -> data.frame
#            base::unique()    -> vector

iris %>% distinct(Sepal.Length)
unique(iris[,c("Sepal.Length", "Petal.Length")])
unique(iris[,"Sepal.Length"])

# 6. ���ø� ----
# 6.1. sample_n() : �������� n ���� ��ŭ ����
#                   replace = T : ���� ����                     
iris %>% sample_n(20, replace = T)  # �������� 20��, ���� ����  

# 6.2. sample_frac() : ������(������ ���) ���� ��ŭ ����
iris %>% sample_frac(0.2, replace = F)  #  �������� 20%, �񺹿� ����

# 6.3. ���ܺ� ��ȭ ���� : group_by() �̿�
iris %>% group_by(Species) %>% sample_n(10)  # Species ����, 10���� ��ȭ ����

# 7. mutate(), transmute() : �Ļ� ���� ����
# 7.1. mutate()     : �������� + �űԺ������� ����
# 7.2. transmute()  : �űԺ��� ����

iris %>% mutate(sum = Sepal.Length + Sepal.Width + Petal.Length + Petal.Width)     # �������� + �Ļ����� ����
iris %>% transmute(sum = Sepal.Length + Sepal.Width + Petal.Length + Petal.Width)  # �Ļ������� ����

# 8. ��� ��� ��� : summarise ----
iris %>% summarize(
                    mean.Sepal.Length = mean(Sepal.Length),
                    mean.Petal.Length = mean(Petal.Length)
                   )

# 9. bind_rows(): �� �������� dataFrame ���� ----
# rbind() �� ������ ��� ����, �� ���� �Լ��� ���ϸ鼭 ���� ����

df.1 <- data.frame(x = 1:3, y = 1:3) 
df.2 <- data.frame(x = 4:6, y = 4:6)
df.3 <- data.frame(x = 7:9, z = 3:1)

bind_rows(df.1, df.2)
rbind(df.1, df.2)

# bind_rows() vs rbind()

# 9.1. �� ��Ī ����  
#              bind_rows()  : �� ���� dataFrame�� �Ϻ��� ��Ī ���� �ʾƵ� ���� ��. ���� ��ġ���� �ʴ� ���, NA ó��
#                             Outer Join�� ����� ����
#              rbind()      : ���� �Ϻ��� ��ġ���� ������, error �߻�

bind_rows(df.1, df.3)  # y�� z �÷��� ��ġ���� �ʴ� ��쿡�� error�� �߻���Ű�� �ʰ� NA ó�� �� ����
rbind(df.1, df.3)      # error �߻�

# 9.2. ��ġ�� �� ��õ dataFrame �� ���� �ľ�
#              bind_rows()  : id parameter �� �̿��� ��ġ�� �� dataFrame �� �� ����. �ణ�� Ʈ�� �ʿ�
#              rbind()      : �� �� ����

bind_rows(list(grp_1 = df.1, grp_2 = df.2), .id = "group_id")  # .id ���� ��������
rbind()  # �Ұ���

# 9.3. ó�� �ӵ�
#              bind_rows()  : �ӵ��� �ξ� ����(�� 261��)
#              rbind()      : ����

one <- data.frame(c(x = c(1:1000000), y = c(1:1000000)))
two <- data.frame(c(x = c(1:1000000), y = c(1:1000000)))

system.time(rbind(one, two))      # 21��
system.time(bind_rows(one, two))  # 0.17��

# 10. bind_cols()  : �� �������� dataFrame�� ��ĥ �� ----
# bind_rows() �� ��κ� ����.
# ** �ٸ��� -> bind_rows�� �ٸ��� ���� ������ ���ƾ߸� ���� ����

# 11. all_equal() : �� ���� dataFrame �� �� �� �� ----
# �ش� function ��� ��, dataFrame �� row, column ������ Ȯ���ϸ鼭 ������ check ����
#  -> ignore_row_order, ignore_col_order �� param���� �̿��Ͽ� Ȯ�� ����

all_equal(target, current, # two data frame to compare
          ignore_col_order = TRUE, # TRUE : �� ���� ���� -> ������ �޶� ������ TRUE return
          ignore_row_order = TRUE, # TRUE : �� ���� ���� -> ������ �޶� ������ TRUE return
          convert = FALSE # Should similar classes be converted? 
                          # Currently this will convert factor to character and integer to double.?)
          )

# 12. cumall(), cumany() : �׷� ���� ���� Ȯ�� ��, slicing �ϰ� ���� �� ----
# 12.1. cumall() : �׷� �� �ش� ������ �ϳ��� ��ġ���� ������ ���� ���� -> filter �Լ� ���������� ���
iris %>% group_by(Species) %>% filter(cumall(Sepal.Length > 3.0)) # ��� ���� ���ؼ�, 3.0 ���� ũ�Ƿ� ���� ��� 
                                                                  

# 12.2. cumany() : �׷� �� �ش� ������ �Ѱ��� �´� ���� ������ ���� ��� -> filter �Լ� ���������� ���
iris %>% group_by(Species) %>% filter(cumany(Sepal.Length > 5.0)) # ��� ���� ���ؼ�, Sepal.Length ���� �� ���� 5.0 ���� ū ����
                                                                  # �����Ƿ�, ���� ���
# 13. cummean() : Ư�� ���� ������ ���鼭 mean ��ȯ ----
iris %>% mutate(cummean.iris = cummean(Sepal.Length))

# 14. recycled aggregates : ����� ��跮�� �ٽ� �������� ����ϰ� ���� ��� ----
iris %>%  group_by(Species) %>% filter(Sepal.Length > mean(Sepal.Length))  # Species ���� Sepal.Length �� ��� ������ ū row�� ���

# 15. window function : n���� ���� input���� �޾� ��ȯ�� n ���� �� output���� ������ִ� �Լ� ----

# 15.1. lead() : <- ���� ����� ���� ��,  lead �Ѵ�! 1���� 10���� �����! ��� �ܿ�����
x <- c(1:10)  # 1~10������ vector ����
lead(x, 2)    # 2��ŭ <- ���� ���ܼ� return

# 15.2. lag() : -> ���� ����� ���� ��,
x <- c(1:10)  # 1~10������ vector ����
lag(x, 2)     # 2��ŭ -> ���� ���ܼ� return