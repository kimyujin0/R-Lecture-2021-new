# ucla 데이터에 대해서 Cross validation을 하고 4가지 모델에 대해서 정확도, 정밀도, 재현율을 구하시오.
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit=factor(ucla$admit)
set.seed(2021)
data <- ucla[sample(nrow(ucla)),]
head(data)

k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)

# Decision Tree
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    dt <- rpart(admit~., data_train)
    dt_pred <- predict(dt ,data_test, type = 'class')
    t <- table(dt_pred, data_test$admit)
    accuracy <- accuracy + (t[1,1]+t[2,2]) / nrow(data_test)
    precision <- precision+(t[2,2]) /(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/ (t[1,2]+t[2,2])
}

dt_avg_acc <- accuracy / k
dt_avg_acc
dt_avg_pre <- precision / k
dt_avg_pre
dt_avg_rec <- recall / k
dt_avg_rec


# 랜덤 포레스트
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(admit~., data_train)
    rf_pred <- predict(rf ,data_test, type = 'class')
    t <- table(rf_pred, data_test$admit)
    accuracy <- accuracy + (t[1,1]+t[2,2]) / nrow(data_test)
    precision <- precision+(t[2,2]) /(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/ (t[1,2]+t[2,2])
}

rf_avg_acc <- accuracy / k
rf_avg_acc
rf_avg_pre <- precision / k
rf_avg_pre
rf_avg_rec <- recall / k
rf_avg_rec


# SVM
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    sv <- svm(admit~., data_train)
    sv_pred <- predict(sv ,data_test, type = 'class')
    t <- table(sv_pred, data_test$admit)
    accuracy <- accuracy + (t[1,1]+t[2,2]) / nrow(data_test)
    precision <- precision+(t[2,2]) /(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/ (t[1,2]+t[2,2])
}

sv_avg_acc <- accuracy / k
sv_avg_acc
sv_avg_pre <- precision / k
sv_avg_pre
sv_avg_rec <- recall / k
sv_avg_rec


# KNN
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1):(i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    k_pred <- knn(data_train[,2:4], data_test[,2:4], data_train$admit,k=5)
    t <- table(k_pred, data_test$admit)
    accuracy <- accuracy + (t[1,1]+t[2,2]) / nrow(data_test)
    precision <- precision+(t[2,2]) /(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/ (t[1,2]+t[2,2])
}

kn_avg_acc <- accuracy / k
kn_avg_acc
kn_avg_pre <- precision / k
kn_avg_pre
kn_avg_rec <- recall / k
kn_avg_rec

sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        dt_avg_acc, dt_avg_pre, dt_avg_rec)
sprintf('랜덤포레스트: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc, rf_avg_pre, rf_avg_rec)
sprintf('SVM: 정확도=%f, 정밀도=%f, 재현율=%f',
        sv_avg_acc, sv_avg_pre, sv_avg_rec)
sprintf('KNN: 정확도=%f, 정밀도=%f, 재현율=%f',
        kn_avg_acc, kn_avg_pre, kn_avg_rec)
