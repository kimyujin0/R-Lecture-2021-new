library(ggplot2)
library(dplyr)
library(tidyr)
mpg <- as.data.frame(ggplot2::mpg)

# 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
mpg %>% ggplot(aes(cty, hwy,col=class)) + geom_point(position = 'jitter')
# jitter - 겹쳐져있는 것을 빼냄

# 2.
head(midwest)
ggplot(midwest, aes(poptotal, popasian,col=state)) + geom_point()+
    xlim(0, 500000)+ ylim(0,10000)

# 연결해서 한번에 실행되도록 스케일 변화
mw <- midwest %>% filter(poptotal <= 500000 & popasian <=100000)
options(scipen = 10)    # 지수 표기를 일반 표기로 변환
ggplot(mw, aes(poptotal, popasian, col=state)) +geom_point()+xlim(0, 500000)+ ylim(0,10000)+
    scale_x_log10()+ scale_y_log10()

# 3.
mpg %>% filter(class=='suv') %>% 
    group_by(manufacturer) %>% summarise(cty_avg=mean(cty)) %>% 
    arrange(desc(cty_avg)) %>% head(5) %>% 
    ggplot(aes(reorder(manufacturer, -cty_avg),cty_avg, fill=manufacturer)) +
    geom_col() + labs(x='Manufacturer', y='average cty')
# = geom_bar(stat='identity)

# 4.자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
mpg %>% select(class) %>% 
    group_by(class) %>% summarise(class_n=n()) %>%
    ggplot(aes(reorder(class, -class_n),class_n,fill=class)) +
    geom_bar(stat = 'identity')       # 막대그래프는 색깔 col 아니라 fill

# 5.
head(economics)
economics %>% ggplot(aes(date, psavert, col = psavert)) + geom_line()

ggplot(economics)+
    geom_line(aes(date,psavert,col=psavert))

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
dia_n <- diamonds %>% group_by(cut) %>% summarise(m_price=mean(price))
ggplot(dia_n,aes(x=color, y=m_price, fill=color)) + geom_bar(stat = 'identity') +geom_line()


# 3). cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요. 
diamonds %>% group_by(cut, color) %>% summarise(m_price=mean(price)) %>% 
    ggplot(aes(x=color, m_price, fill=cut))+geom_col(position='dodge')

diamonds %>% group_by(cut, color) %>% summarise(m_price=mean(price)) %>% 
    ggplot(aes(x=cut, m_price, fill=color))+geom_bar(stat='identity', position='dodge')