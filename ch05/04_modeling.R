# 모델링을 위한 가공
library(dplyr)

# Wine 데이터
wine <- read.table('data/wine.data.txt', sep = ',')
head(wine)

columns <- readLines('data/wine.name.txt')
columns

# wine data의 column명
names(wine)[2:14] <- columns
names(wine)

# substr 함수
a <- 'A quick brown fox jumps over the lazy dog.'
nchar(a)
substr(a, 3, 7)                           # quick
substr(a,nchar(a)-3, nchar(a)-1)          # dog

names(wine)[2:14] <- substr(columns, 4, nchar(columns))
names(wine)[1] <- 'Y' 

# 데이터셋 분할
train_set =sample_frac(wine, 0.75)    # 0.75 를 훈련데이터로
str(train_set)
table(wine$Y)
table(train_set$Y)

test_set <- setdiff(wine, train_set)
table(test_set$Y)
