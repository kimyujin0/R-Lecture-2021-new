# 분류(Classification)
# 결정 트리(Decision Tree) -rpart모델
library(rpart)

head(iris)
dtc <- rpart(Species ~., iris)    # iris 데이터를 결정 트리로 학습
summary(dtc)

# 결정 트리 시각화
par(mfrow=c(1,1),xpd=NA)   # 그래프에 글자가 다 나오게 함
plot(dtc)
text(dtc, use.n = T)

# 예측
pred <- predict(dtc, iris, type = 'class')
table(pred, iris$Species)

# 평가
library(caret)
confusionMatrix(pred, iris$Species)

# 시각화
library(rpart.plot)
rpart.plot(dtc)
rpart.plot(dtc, type=4)

# 훈련/테스트 셋으로 분리하여 시행
set.seed(2021)     # 랜덤한 결과 중 최적의 결과를 지속하고 싶을 때 고정시키는 것.
iris_index <- sample(1:nrow(iris), 0.8*nrow(iris))
iris_train <- iris[iris_index,]
iris_test <- iris[setdiff(1:nrow(iris),iris_index),]
iris_test <- iris[-iris_index,]
dim(iris_train)
dim(iris_test)
table(iris_train$Species)

# 모델링(학습)/ 예측
dtc <- rpart(Species ~., iris_train)  # 모델링과 학습까지 완료
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 비율대로 훈련/테스트 데이터셋 만들기
train_index <- createDataPartition(iris$Species, p= 0.8,list=F)  # 나오는 값을 같게 만들어줌
iris_train <- iris[train_index,]
iris_test <- iris[-train_index,]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc <- rpart(Species~.,iris_train)

# 예측
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화
rpart.plot(dtc)
