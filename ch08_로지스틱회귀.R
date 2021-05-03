# 일반화 선형 모델
# 로지스틱 회귀 - UCLA admission data
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)

lr <- glm(admit~., data=ucla, family = binomial)  # 로지스틱 함수 모델 만들기- family = binomial
coef(lr)

test <- data.frame(gre=c(376), gpa=c(3.6), rank=c(3))
predict(lr, newdata = test, type = 'response')     # 모델 -> 예측 predict(model, data) -> 평가

# 훈련데이터는 학습, glm모델에 train data + 테스트데이터는 예측, predict에 test data

# ucla 데이터 셋 train/test data set으로 분할
train_index <- sample(1:nrow(ucla), 0.8*nrow(ucla)) # 80%를 훈련데이터로 할당
test_index <- setdiff(1:nrow(ucla), train_index)    # 차집합 - 왼쪽에서 오른쪽을 뺌
ucla_train <- ucla[train_index,]
ucla_test <- ucla[test_index,]
dim(ucla_train)  #320행 4열
dim(ucla_test)   #80행 4열

# 분할 비율은 적절한가?
table(ucla$admit)          # 127/400 -> 0.3175
table(ucla_train$admit)    # 101/320 -> 0.3156   적절하다로 판단

# 훈련 데이터셋으로 학습, 테스트 데이터셋으로 예측의 원칙
lr <- glm(admit~., data = ucla_train, family = binomial)
pred <- predict(lr, ucla_test, type = 'response')
pred
ucla_test$admit

