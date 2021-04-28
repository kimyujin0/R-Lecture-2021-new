library(ggplot2)
library(dplyr)
library(tidyr)
mpg <- as.data.frame(ggplot2::mpg)
# 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
mpg %>% ggplot(aes(cty, hwy)) + geom_point()

# 2.
head(midwest)
ggplot(midwest, aes(poptotal, popasian)) + geom_point()+
    coord_cartesian(xlim = c(0, 5e+06), ylim = c(0,1e+04))

# 3.
mpg %>% filter(class=='suv') %>% 
    group_by(manufacturer) %>% summarise(cty_avg=mean(cty)) %>% head(5) %>% 
    ggplot(aes(reorder(manufacturer, -cty_avg),cty_avg)) +
    geom_bar(stat='identity', fill='red')

# 4.자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
mpg %>% select(class) %>% 
    group_by(class) %>% summarise(class_n=n()) %>% 
    ggplot(aes(class, class_n)) +
    geom_bar(stat = 'identity')

# 5.
head(economics)
economics %>% ggplot(aes(date, psavert, col = psavert)) + geom_point() +geom_smooth()

# 6. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.
mpg %>% filter(class %in% c('compact','subcompact','suv')) %>% 
    ggplot(aes(class, cty, col = class)) +
    geom_boxplot()

# 7.
# 1) cut의 돗수를 보여주는 그래프를 작성하세요.
head(diamonds)
dia<-diamonds %>% group_by(cut) %>% summarise(cut_n=n())
dia
ggplot(dia,aes(x=cut, y=cut_n, fill=cut)) +
    geom_bar(stat = 'identity')

# 2). cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
dia_n <- merge(diamonds, dia)
ggplot(dia_n,aes(x=cut, y=cut_n, fill=cut)) + geom_bar(stat = 'identity') +geom_line(col=price)

dia_n %>% ggplot(aes(cut, cut_n)) +geom_bar(stat='identity')  + geom_line(col=dia_n$price)

dia_n %>% ggplot(aes(cut, cut_n, col = price)) + geom_point(alpha=0.2) + geom_smooth()

# 3). cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요. 
ggplot(dia_n, aes(x=color, fill=cut))+geom_bar() + geom_smooth(aes(group=as.factor(price)))+
    facet_wrap(~cut)