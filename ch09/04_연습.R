# 1. ucla 데이터 4가지 모델, 예측/평가  (dt, rf, svm, knn)
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit=factor(ucla$admit)    # 범주형 변수로 변환 - 분류를 하기 위해
library(caret)

# 데이터 분할(훈련/테스트)
set.seed(2021)
train_index <- createDataPartition(ucla$admit, p= 0.8,list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]
table(ucla_train$admit)
table(ucla_test$admit)

# 의사결정나무
library(rpart)
dt_ucla <- rpart(admit~., ucla_train)
pred <- predict(dt_ucla, ucla_test, type = 'class')
t <- table(pred,ucla_test$admit)
dt_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)   # 정확도 구하기
confusionMatrix(pred, ucla_test$admit)

# 랜덤 포레스트
library(randomForest)
rf_ucla <- randomForest(admit~., ucla_train)
rf_pred <- predict(rf_ucla, ucla_test, type = 'class')
t <- table(rf_pred,ucla_test$admit)
rf_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)
confusionMatrix(rf_pred, ucla_test$admit)
plot(rf_ucla)

# svm
library(e1071)
sv_ucla <- svm(admit~., ucla_train)
sv_pred <- predict(sv_ucla, ucla_test, type = 'class')
t <- table(sv_pred,ucla_test$admit)
sv_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)
confusionMatrix(sv_pred, ucla_test$admit)

# K-NN
library(class)     # [,2:4] = 4개 변수 중 2번째
pred <- knn(ucla_train[,2:4], ucla_test[,2:4], ucla_train$admit,k=5)
pred
t <- table(k,ucla_test$admit)
kn_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)
confusionMatrix(k, ucla_test$admit)   

k <- knn(ucla_train[,2:4], ucla_test[,2:4], ucla_train$admit,k=7)
k
t <- table(k,ucla_test$admit)
kn_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)
confusionMatrix(k, ucla_test$admit)          # 정확도가 가장 높음.

k <- knn(ucla_train[,2:4], ucla_test[,2:4], ucla_train$admit,k=3)
k
t <- table(k,ucla_test$admit)
kn_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)
confusionMatrix(k, ucla_test$admit)

# 로지스틱 회귀
lr <- glm(admit~., ucla_train, family = binomial)
lr_pred <- predict(lr, ucla_test, type = 'response')
lr_pred
lr_pred <- ifelse(lr_pred > 0.5,1,0)       # 삼항연산자, 값을 2개로 통일하게 만들어줌
t <- table(lr_pred, ucla_test$admit)
lr_acc <- (t[1,1]+t[2,2]) / nrow(ucla_test)

print(paste(dt_acc, rf_acc, sv_acc, kn_acc, lr_acc))
      
      
# 2. wine데이터 4가지 모델, 예측/평가
wine <- read.table('data/wine.data.txt', sep = ',')
str(wine)
columns <- readLines('data/wine.name.txt')
columns
names(wine)[2:14] <- substr(columns, 4, nchar(columns)) # 숫자들을 배제하고 문자열만 추출
names(wine)[1] <-'Y'                                   # 인덱스값=names
head(wine)
str(wine)
wine$Y=factor(wine$Y)

# 데이터 분할(훈련/테스트)
set.seed(2021)
train_index1 <- createDataPartition(wine$Y, p= 0.8,list=F)
wine_train <- wine[train_index1,]
wine_test <- wine[-train_index1,]
table(wine_train$Y)
table(wine_test$Y)

# 의사결정나무
dt_wine <- rpart(Y~., wine_train)
pred1 <- predict(dt_wine, wine_test, type = 'class')
t <- table(pred1, wine_test$Y)
dt_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(pred, wine_test$Y)

# 렌덤 포레스트
rf_wine <- randomForest(Y~., wine_train)
rf_pred1 <- predict(rf_wine, wine_test, type = 'class')
t <- table(rf_pred1, wine_test$Y)
rf_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(rf_pred1, wine_test$Y)

# svm
sv_wine <- svm(Y~., wine_train)
sv_pred1 <- predict(sv_wine, wine_test, type = 'class')
t <- table(sv_pred1, wine_test$Y)
sv_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(sv_pred1, wine_test$Y)

# K-NN
k <- knn(wine_train[,2:14], wine_test[,2:14], wine_train$Y,k=5)
k
t <- table(k, wine_test$Y)
kn_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(k, wine_test$Y)    

k <- knn(wine_train[,2:14], wine_test[,2:14], wine_train$Y,k=3)
k
t <- table(k, wine_test$Y)
kn_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(k, wine_test$Y)    

k <- knn(wine_train[,2:14], wine_test[,2:14], wine_train$Y,k=7)
k
t <- table(k, wine_test$Y)
kn_acc <- (t[1,1]+t[2,2]+t[3,3]) / nrow(wine_test)
confusionMatrix(k, wine_test$Y)          # 정확도가 가장 높음.
