# dplyr 라이브러리를 이용한 데이터 가공
# filter, select, arrange, group_by&summerize, mutate
# %>% (chain, pipe)
library(dplyr)
library(gapminder)

# 1. select(테이블, x, x2, x3 ...) - 원하는 열 추출
select(gapminder, country, year, lifeExp)
select(gapminder, country, year, lifeExp) %>% head()
select(gapminder, country, year, lifeExp) %>% head(10)

# 2. filter(테이블, 행 조건) - 원하는 행 추출
filter(gapminder, country=='Croatia')
filter(gapminder, country=='Croatia' & year >2000)
# 유럽의 가장 최신의 인구정보
filter(gapminder, continent == 'Europe' & year == 2007)

# arrange - 정렬, 디폴트는 오름차순
europe_pop <- filter(gapminder, continent == 'Europe' & year == 2007)
arrange(europe_pop, lifeExp)             # 기대수명이 낮은 순으로 오름차순
arrange(europe_pop, desc(lifeExp))       # 내림차순
# 아프리카 대륙에서 평균 수명이 가장 긴 나라 5개 출력
africa_pop <- filter(gapminder, continent == 'Africa' & year ==2007)
arrange(africa_pop, desc(lifeExp)) %>% head(5)

filter(gapminder, continent == 'Africa' & year ==2007) %>%
    arrange(desc(lifeExp)) %>% 
    head(5)

gapminder %>% filter(continent == 'Africa' & year ==2007) %>%
    arrange(desc(lifeExp)) %>% 
    head(5)

# group_by & summarize
summarize(africa_pop, pop_average=mean(pop))     # 2007년 아프리카 국가별 평균 인구 수
summarise(group_by(gapminder, continent), pop_avg=mean(pop))
summarise(group_by(gapminder, country), life_avg=mean(lifeExp))

asia_pop <- gapminder %>%
    filter(continent=='Asia')
summarise(group_by(asia_pop, country), life_avg=mean(lifeExp))
summarise(group_by(asia_pop, country), life_avg=mean(lifeExp)) %>% 
    arrange(desc(life_avg)) %>% head(5)

# mpg(mile-per-gallon)
library(ggplot2)
head(mpg)
glimpse(mpg)
summary(mpg)          # 요약 통계량

# 통합연비 변수 (변수 추가)
mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mean(mpg$total)
summary(mpg$total)   # 변수의 요약 통계량 확인 가능
hist(mpg$total)

# 평균연비가 20 이상이면 합격, 아니면 불합격
mpg$test <- ifelse(mpg$total>=20, 'pass', 'fail')
table(mpg$test)   # 범주형 변수의 개수 계산
qplot(mpg$test)

# 평균연비가 30 이상이면 A등급, 20이상이면 B등급, 아니면 C등급
mpg$grade <- ifelse(mpg$total>=30, 'A',
                   ifelse(mpg$total>=20, 'B','C'))
table(mpg$grade)
qplot(mpg$grade)

gapminder %>% filter(continent ==' Asia') %>%
    group_by(country) %>% summarise(life_avg=mean(lifeExp)) %>%
    arrange(desc(life_avg)) %>% head(5)

# 2007 인구수 5000만 이상인 국가 중 기대수명이 가장 큰 Top 5 국가
gapminder %>% filter(year == 2007 & pop >= 5e7) %>% 
    group_by(country) %>% summarise(life_avg=mean(lifeExp)) %>%
    arrange(desc(life_avg)) %>% head(5)

# 5. mutate - 새로운 변수 추가 

mpg %>%filter(manufacturer %in% c('audi','toyota')) %>%
 group_by(manufacturer) %>%
 summarise(avg_cty=mean(cty)) %>% arrange(desc(avg_cty))        # 도요타의 평균 연비가 높다.
