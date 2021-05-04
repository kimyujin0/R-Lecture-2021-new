# 1. colon 데이터에 랜덤 포레스트를 적용하는데 k-겹 교차 검증을 k를 5,10, 15,20으로 바꾸면서 적용하라.
# 혼동 행렬과 정확률을 제시하라.
library(caret)
library(survival)
clean_colon <- na.omit(colon)
clean_colon <- clean_colon[c(TRUE,FALSE),]
clean_colon$status <- factor(clean_colon$status)
data <- clean_colon
str(data)
table(data$status)

# k=5
control <- trainControl(method = 'cv', number=5)
f1 <- train(status~., data, method = 'rf', metric = 'Accuracy', trControl=control)
confusionMatrix(f1)    # 정확도= 0.9493

# k=10
control <- trainControl(method = 'cv', number=10)
f2 <- train(status~., data, method = 'rf', metric = 'Accuracy', trControl=control)
confusionMatrix(f2)    # 정확도= 0.9516

# k=15
control <- trainControl(method = 'cv', number=15)
f3 <- train(status~., data, method = 'rf', metric = 'Accuracy', trControl=control)
confusionMatrix(f3)    # 정확도= 0.9527

# k=20
control <- trainControl(method = 'cv', number=20)
f4 <- train(status~., data, method = 'rf', metric = 'Accuracy', trControl=control)
confusionMatrix(f4)    # 정확도= 0.9493

# 결론: k=15일 때 정확도가 0.9516으로 가장 높으며 랜덤포레스트 최적의 모델이다.


# 2. 353~356쪽의 과정을 UCLA admission 데이터에 대해 수행하라.
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit=factor(ucla$admit) 

control <- trainControl(method = 'cv', number = 10)
L <- train(admit~., data=ucla, method='svmLinear', metric='Accuracy', trControl=control)
LM <- train(admit~., ucla, method='svmLinearWeights', metric='Accuracy', trControl=control)
P <- train(admit~., ucla, method='svmPoly', metric='Accuracy', trControl=control)
R <- train(admit~., ucla, method='svmRadial', metric='Accuracy', trControl=control)
RM <- train(admit~., ucla, method='svmRadialWeights', metric='Accuracy', trControl=control)
f100 <- train(admit~., ucla, method='rf', ntree=100, metric='Accuracy', trControl=control)
f300 <- train(admit~., ucla, method='rf', ntree=300, metric='Accuracy', trControl=control)
f500 <- train(admit~., ucla, method='rf', ntree=500, metric='Accuracy', trControl=control)
r <- train(admit~., ucla, method='rpart', metric='Accuracy', trControl=control)
k <- train(admit~., ucla, method='knn', metric='Accuracy', trControl=control)
g <- train(admit~., ucla, method='glm', metric='Accuracy', trControl=control)
resamp <- resamples(list(선형=L, 선형가중치=LM, 다항식=P, RBF=R, 가중치=RM, rf100=f100,
                           rf300=f300, rf500=f500, tree=r, knn=k, glm=g))
summary(resamp)

sort(resamp, decreasing = T)

dotplot(resamp)


# 3. 353~356쪽의 과정을 voice 데이터에 대해 수행하라.
voice <- read.csv('data/voice.csv')
str(voice)
table(is.na(voice))  # 결측치가 없음.

control <- trainControl(method = 'cv', number = 10)
formular <- label~+meanfreq+ sd+ skew+ kurt+sp.ent+sfm+centroid+
L <- train(formular, voice, method='svmLinear', metric='Accuracy', trControl=control)
LM <- train(formular, voice, method='svmLinearWeights', metric='Accuracy', trControl=control)
P <- train(formular, voice, method='svmPoly', metric='Accuracy', trControl=control)
R <- train(formular, voice, method='svmRadial', metric='Accuracy', trControl=control)
RM <- train(formular, voice, method='svmRadialWeights', metric='Accuracy', trControl=control)
f100 <- train(formular, voice, method='rf', ntree=100, metric='Accuracy', trControl=control)
f300 <- train(formular, voice, method='rf', ntree=300, metric='Accuracy', trControl=control)
f500 <- train(formular, voice, method='rf', ntree=500, metric='Accuracy', trControl=control)
r <- train(formular, voice, method='rpart', metric='Accuracy', trControl=control)
k <- train(formular, voice, method='knn', metric='Accuracy', trControl=control)
g <- train(formular, voice, method='glm', metric='Accuracy', trControl=control)
resamp <- resamples(list(선형=L, 선형가중치=LM, 다항식=P, RBF=R, 가중치=RM, rf100=f100,
                           rf300=f300, rf500=f500, tree=r, knn=k, glm=g))
summary(resamp)

sort(resamp, decreasing = T)

dotplot(resamp)

