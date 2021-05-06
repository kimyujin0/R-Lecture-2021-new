# Alice 데이터를 이용하여 word cloud 만들기
library(RCurl)
library(XML)
library(stringr)
library(tm)           
library(SnowballC)

html <- readLines('data/Alice.txt')

html <- Corpus(VectorSource(html))
inspect(html)             # doc이 어떻게 생겼는지 알려줌
html <- tm_map(html, content_transformer(tolower))         # 소문자로 변환
html <- tm_map(html, removeNumbers)                        # 숫자 제거
stop_words <- c(stopwords('en'),'said')                    # said 제거
html <- tm_map(html, removeWords, stop_words)    # 불용어 제거
html <- tm_map(html, removePunctuation)                    # 구두점 제거
html <- tm_map(html, stripWhitespace)                      # 앞 뒤 공백 제거
head(html)

#################
# DTM 구축
#################
dtm <- DocumentTermMatrix(html)
dim(dtm)    # document 가 3개, 단어가 2492개
inspect(dtm)

#################
# Word Cloud
#################
typeof(dtm)  # 리스트니까 행렬로 바꿈
m <-as.matrix(dtm)     # DTM list를 matrix로 변환
v <- sort(colSums(m), decreasing = T)   # 단어 빈도수가 많은것이 위로 올라감감
v[1:5]
df <- data.frame(word=names(v), frequency=v)
head(df)

library(wordcloud2)
wordcloud2(df)
d1 <- df[1:1000,]
getwd()
figPath <- system.file("data/Alice_mask.png",package = "wordcloud2")
wordcloud2(d1, figPath='Alice_mask.png', size = 1)
