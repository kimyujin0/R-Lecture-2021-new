# JSON 기본 (내장 데이터 처리)
library(jsonlite)

# 실수형
pi
json_pi <- toJSON(pi,digits = 3)   # json객체로
json_pi         # 실수형태의 json
fromJSON(json_pi)

# 문자형
city <- '대전'
json_city <- toJSON(city)
fromJSON(json_city)

# 벡터형
subject <- c('국어','영어','수학')
json_sub <- toJSON(subject)
fromJSON(json_sub)

# 데이터 프레임
name <- c("Test")
age <- c(25)
sex <- c("F")
adress <- c('Seoul')
hobby <- c('Basketball')
person <- data.frame(Name=name, Age=age, Sex=sex, Adress=adress, Hobby=hobby)
str(person)

json_person <- toJSON(person)
prettify(json_person)

df_json_person <- fromJSON(json_person)
str(person)

# 두 개의 데이터프레임의 데이터 값이 같은지 비교
all(person==df_json_person)

# cars 내장 데이터로 테스트
cars
json_cars <- toJSON(cars)
prettify(json_cars)
df_json_cars <- fromJSON(json_cars)
all(cars==df_json_cars)            # 원래데이터와 같다. to,from 써도 값은 똑같음

# 
