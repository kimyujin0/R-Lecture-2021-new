# IMDB 영화평 감성분석
library(text2vec)
library(caret)
library(tm)

str(movie_review)

# 8:2 비율로 훈련/테스트 데이터셋 분할
set.seed(2021)
train_list <- createDataPartition(movie_review$sentiment, p=0.8, list = F)
mtrain <- movie_review[train_list,]
mtest <- movie_review[-train_list,]

# 훈련 데이터셋에 대해 DTM 구축
# 테스트 데이터셋에 대해서도 동일하게 적용해야 함
doc <- Corpus(VectorSource(mtrain$review))
doc <- tm_map(doc, content_transformer(tolower))  # 소문자 변환
doc <- tm_map(doc, removeNumbers)
stop_words <- c(stopwords('en'),'<br />')
doc <- tm_map(doc, removeWords, stop_words)
doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, stripWhitespace)

dtm <- DocumentTermMatrix(doc, control = list(weighting=weightTf)) # 문장에 많이 나오는 단어에 힘을 주어라
dim(dtm)
inspect(dtm)

dtm_tfidf <- DocumentTermMatrix(doc, control = list(weighting=weightTfIdf))
inspect(dtm_tfidf)  

# 모델링이 가능한 형태로 DTM 변환 - 단어와 숫자를 mapping(숫자형태로 나옴)
dtm_small <- removeSparseTerms(dtm, 0.9)     # 빈공간을 없애는 함수 - 데이터를 줄여줌
dim(dtm_small)

# Sentiment(y)와 DTM을 묶어 데이터프레임을 생성
X <- as.matrix(dtm_small)
dataTrain <- as.data.frame(cbind(mtrain$sentiment,X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y'
dataTrain$y <- as.factor(dataTrain$y)       # y(종속변수)를 factor로 바꿈

# Decision Tree로 학습
library(rpart)
dt <- rpart(y~., dataTrain)

# 테스트 데이터셋으로 모델 성능 평가 - 전처리는 동일하게 진행
docTest <- Corpus(VectorSource(mtest$review))
docTest <- tm_map(docTest, content_transformer(tolower))  # 소문자 변환
docTest <- tm_map(docTest, removeNumbers)
docTest <- tm_map(docTest, removeWords, stop_words)
docTest <- tm_map(docTest, removePunctuation)
docTest <- tm_map(docTest, stripWhitespace)

dtmTest <- DocumentTermMatrix(docTest, control = list(dictionary=dtm_small$dimnames$Terms))
# dictionary=dtm_small$dimnames$Terms - train데이터에서 썼던 것을 쓰라는 의미
dim(dtmTest)
inspect(dtmTest) # dtmTest = dtm_small

# Sentiment(y)와 DTM Test를 묶어 데이터프레임 생성
X <- as.matrix(dtmTest)
dataTest <- as.data.frame(cbind(mtest$sentiment,X))
colnames(dataTest)[1] <- 'y'
dataTest$y <- as.factor(dataTest$y)  

# 학습했던 모델로 예측
dt_pred <- predict(dt, dataTest, type = 'class')
table(dt_pred, dataTest$y)

#######################
# SVM으로 훈련
#######################
library(e1071)
svc <- svm(y~., dataTrain)
sv_pred <- predict(svc, dataTest, type = 'class')
t <- table(sv_pred, dataTest$y)
dt_acc <- (t[1,1]+t[2,2]) / nrow(dataTest)       # 정확도= 0.719
dt_acc

#######################
# Tf-Idf로 변환
#######################
dtm_tfidf <- DocumentTermMatrix(doc, control = list(weighting=weightTfIdf))
inspect(dtm_tfidf)    # 결과 소수점으로 나옴
# dtm을 바로 쓰는게 아니라 모델링을 해서 사용할 수 있게 고쳐줘야함

# 모델링이 가능한 형태로 DTM 변환 - 단어와 숫자를 mapping(숫자형태로 나옴)
dtm_small_tfidf <- removeSparseTerms(dtm_tfidf, 0.9)     # 빈공간을 없애는 함수 - 데이터를 줄여줌
dim(dtm_small_tfidf)

# Sentiment(y)와 DTM을 묶어 데이터프레임을 생성
X <- as.matrix(dtm_small_tfidf)
dataTrain <- as.data.frame(cbind(mtrain$sentiment,X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y'
dataTrain$y <- as.factor(dataTrain$y)

# Decision Tree로 학습
dt_tfidf <- rpart(y~., dataTrain)

# Test dataset
dtmTest_tfidf <- DocumentTermMatrix(docTest, 
                                    control = list(dictionary=dtm_small_tfidf$dimnames$Terms,
                                                   weighting=weightTfIdf))

# 예측
dt_pred_tfidf <- predict(dt_tfidf, dataTest, type = 'class')
table(dt_pred_tfidf, dataTest$y)

# SVM
svc_tfidf <- svm(y~., dataTrain)
sv_pred_tfidf <- predict(svc_tfidf, dataTest, type = 'class')
t <- table(sv_pred_tfidf, dataTest$y)
dt_acc <- (t[1,1]+t[2,2]) / nrow(dataTest)
dt_acc
