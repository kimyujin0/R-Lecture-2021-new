# Wikipedia "data science"
library(RCurl)
library(XML)
library(stringr)

html <- readLines('https://en.wikipedia.org/wiki/Data_science')   # url에 있는 파일 데이터를 읽는다.
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p',xmlValue)    # p태그,  마우스 클릭에 따라 
length(doc)
doc[1]  # 내용이 없어서 \n
doc[3]  # 글자가 들어가있음
doc[3]
corpus <- doc[2:3]

# 모두 소문자로 변경
corpus <- tolower(corpus)
corpus[1]

# gsub가 굉장히 많이 사용됨

# 숫자 제거
# 숫자를 표현하는 정규 표현식 : '\\d', '[[:digit:]]
corpus <- gsub('\\d', '', corpus) # 바꾸려고 하는 숫자열이 먼저 쓰임
corpus[1]

# 구둣점 제거
corpus <- gsub('[[:punct:]]','',corpus)
corpus[1]
#corpus <- gsub("github")

# 끝에 있는 공백 제거
corpus <- gsub('\n', ' ', corpus)  # 끝부분 공백
corpus <- str_trim(corpus, 'right')
corpus[1]

# 불용어 제거
stopwords <- c('a','in','the','and','of','to','but')
words <-str_split(corpus,' ')    # 결과가 리스트로 나옴
unlist(words)     # 여러개의 리스트 엘리먼트를 하나의 벡터로 만든다

l <- list()       # 리스트를 쓰면 편함, 빈 리스트 생성
for (word in unlist(words)) {
    if (!word %in% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l, collapse = ' ')
corpus


`%notin%` <- Negate(`%in%`)     # !%in%과 같음, ``(back quote)를 씀
l <- list()      
for (word in unlist(words)) {
    if (word %notin% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l, collapse = ' ')
corpus