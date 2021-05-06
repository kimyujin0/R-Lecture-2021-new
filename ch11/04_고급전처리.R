# R library를 이용한 전처리
library(RCurl)
library(XML)
library(stringr)

html <- readLines('https://en.wikipedia.org/wiki/Data_science')
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p',xmlValue)  

library(tm)              # Text Mining 라이브러리
library(SnowballC)       # 어간 추출 라이브러리

doc <- Corpus(VectorSource(doc))
inspect(doc)             # doc이 어떻게 생겼는지 알려줌
doc <- tm_map(doc, content_transformer(tolower))         # 소문자로 변환
doc <- tm_map(doc, removeNumbers)                        # 숫자 제거
doc <- tm_map(doc, removeWords, stopwords('english'))    # 불용어 제거
doc <- tm_map(doc, removePunctuation)                    # 구두점 제거
doc <- tm_map(doc, stripWhitespace)                      # 앞 뒤 공백 제거

#################
# DTM 구축
#################
dtm <- DocumentTermMatrix(doc)
dim(dtm)    # document 가 13개, 단어가 363개
inspect(dtm)

#################
# Word Cloud
#################
library(wordcloud)

typeof(dtm)  # 리스트니까 행렬로 바꿈
m <-as.matrix(dtm)     # DTM list를 matrix로 변환
v <- sort(colSums(m), decreasing = T)   # 단어 빈도수가 많은것이 위로 올라감감
v[1:5]
df <- data.frame(word=names(v), frequency=v)
head(df)
wordcloud(words = df$word, freq = df$frequency, min.freq = 1, max.words = 100,
          random.order = F, rot.per = 0.35) 
# 빈도가 1까지 나오는 단어 100개를 찾고 랜덤이 아닌 순서대로 추출하는 워드 클라우드

library(wordcloud2)
wordcloud2(df)

d200 <- df[1:200,]
wordcloud2(d200, shape = 'star')
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0)
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0,
           backgroundColor = "black")
wordcloud2(d200, figPath = 'data/Alice_mask.png')
