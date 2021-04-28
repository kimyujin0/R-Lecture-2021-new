#  base R을 이용한 데이터 가공 (인덱스 기반의 데이터 접근)
install.packages("gapminder")
library(gapminder)
library(dplyr)

glimpse(gapminder)

# 각 나라의 기대 수명(life Exp)
tail(gapminder[, c("country", 'lifeExp')])
tail(gapminder[, c("country", 'lifeExp','year')])    # selection
# 샘플과 속성의 추출(filtering(행) and selection(열))
gapminder[1000:1009, c("country", 'lifeExp','year')]
gapminder[gapminder$country=='Croatia',]             #Croatia의 데이터를 전부 추출
gapminder[gapminder$country=='Croatia',c('year','pop')]

# Croatia의 1990년도 이후의 연도, 기대수명과 인구
gapminder[gapminder$country=='Croatia'& gapminder$year>1990, c('lifeExp','pop','year')]

# 행/열 단위의 연산
apply(gapminder[gapminder$country=='Croatia', c('lifeExp','pop')], 2, mean)

peak2peak = function(x,year) {
    return(max(x)-min(x))
}
apply(gapminder[gapminder$country=='Croatia', c('lifeExp','pop')], 2, peak2peak)
