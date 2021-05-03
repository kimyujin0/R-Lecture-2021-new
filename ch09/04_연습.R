# 1. ucla 데이터 4가지 모델, 예측/평가  (dt, rf, svm, knn)
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit=factor(ucla$admit)

# 데이터 분할(훈련/테스트)
train_index <- createDataPartition(ucla$admit, p= 0.8,list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]
table(ucla_train$admit)
table(ucla_test$admit)

# 의사결정나무
library(rpart)
dt_ucla <- rpart(admit~., ucla_train)
pred <- predict(dt_ucla, ucla_test, type = 'class')
confusionMatrix(pred, ucla_test$admit)

# 랜덤 포레스트
library(randomForest)
rf_ucla <- randomForest(admit~., ucla_train)
rf_pred <- predict(rf_ucla, ucla_test, type = 'class')
confusionMatrix(rf_pred, ucla_test$admit)
plot(rf_ucla)

# svm
library(e1071)
sv_ucla <- svm(admit~., ucla_train)
sv_pred <- predict(sv_ucla, ucla_test, type = 'class')
confusionMatrix(sv_pred, ucla_test$admit)

# K-NN
library(class)
k <- knn(ucla_train[,1:3], ucla_test[,1:3], ucla_train$admit,k=5)
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)    # 정확도가 가장 높음.

library(class)
k <- knn(ucla_train[,1:3], ucla_test[,1:3], ucla_train$admit,k=7)
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)

library(class)
k <- knn(ucla_train[,1:3], ucla_test[,1:3], ucla_train$admit,k=3)
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)


# 2. wine데이터 4가지 모델, 예측/평가
wine <- read.table('data/wine.data.txt', sep = ',')
str(wine)
columns <- readLines('data/wine.name.txt')
columns
names(wine)[2:14] <- columns
names(wine)
head(wine)
str(wine)
wine$V1=factor(wine$V1)

# 데이터 분할(훈련/테스트)
train_index1 <- createDataPartition(wine$V1, p= 0.8,list=F)
wine_train <- wine[train_index1,]
wine_test <- wine[-train_index1,]
table(wine_train$V1)
table(wine_test$V1)

# 의사결정나무
library(rpart)
dt_wine <- rpart(V1~., wine_train)
pred1 <- predict(dt_wine, wine_test, type = 'class')
confusionMatrix(pred, wine_test$V1)

# 렌덤 포레스트
library(randomForest)
rf_wine <- randomForest(V1~., wine_train)
rf_pred1 <- predict(rf_wine, wine_test, type = 'class')
confusionMatrix(rf_pred1, wine_test$V1)

# svm
library(e1071)
sv_wine <- svm(V1~., wine_train)
sv_pred1 <- predict(sv_wine, wine_test, type = 'class')
confusionMatrix(sv_pred1, wine_test$V1)

# K-NN
library(class)
k <- knn(wine_train[,2:13], wine_test[,2:13], wine_train$V1,k=5)
k
wine_test$V1
confusionMatrix(k, wine_test$V1)    

k <- knn(wine_train[,2:13], wine_test[,2:13], wine_train$V1,k=3)
k
wine_test$V1
confusionMatrix(k, wine_test$V1)    # 정확도가 가장 높음.

k <- knn(wine_train[,2:13], wine_test[,2:13], wine_train$V1,k=7)
k
wine_test$V1
confusionMatrix(k, wine_test$V1)
