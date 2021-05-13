# JSON 파일로부터 읽어서 데이터 프레임 만들기
library(jsonlite)
# person.json 파일로부터 열기
wiki_person <- fromJSON('C:/OpenAPI/person.json')
str(wiki_person)

# sample.json
data <- fromJSON('C:/OpenAPI/sample.json')

data <- as.data.frame(data)
names(data) <- c('id','like','share','comment','unoque','msg','time')
data$like <- as.numeric(as.character(data$like))
View(data)

# CSV 파일로 저장
write.csv(data, 'OpenAPI/data.csv')

# DataFrame을 JSON 파일로 저장

