library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
mpg %>% mutate(displ45=ifelse(displ <=4, 'DIDPL4','DISPL5'))%>%
    group_by(displ45) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

#2 ok
mpg %>%filter(manufacturer %in% c('audi','toyota')) %>%
    group_by(manufacturer) %>%
    summarise(avg_cty=mean(cty)) %>% arrange(desc(avg_cty))        # 도요타의 평균 연비가 높다.

# 3 ok
total_avg <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(total_avg$hwy)

# 4 ok 
mpg %>% select(class, cty) %>% head(10)  

# 5 ok
mpg %>% filter(class %in% c('suv','compact')) %>% group_by(class) %>% summarise(avg_cty=mean(cty)) #compact
 
# 6 ok
mpg %>% filter(manufacturer=='audi')%>%arrange(desc(hwy)) %>% head(5)

# 7
#1) 합산 연비 변수 ok
mpg$total <- (mpg$cty + mpg$hwy)
#2) 평균 연비 변수 ok
mpg$total_avg <- (mpg$cty + mpg$hwy)/2
#3) 평균 연비 변수가 가장 높은 자동차 3종의 데이터를 출력하세요. ok
mpg %>% group_by(manufacturer) %>% summarise(total_avg) %>% arrange(desc(total_avg)) %>% head()
#4)
mpg %>% mutate(total = cty +hwy, avg=total/2) %>% arrange(desc(avg)) %>% head(3)

# 8 class별 cty 평균 ok
mpg %>% group_by(class) %>% summarise(c_avg=mean(cty))

# 9 ok
mpg %>% group_by(class) %>% summarise(c_avg=mean(cty)) %>% arrange(desc(c_avg))%>% head(7)

# 10 hwy 평균이 가장 높은 회사 세 곳을 출력하세요. ok
mpg %>% group_by(manufacturer) %>% summarise(h_avg=mean(hwy)) %>% arrange(desc(h_avg)) %>% head(3)

# 11 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요. ok
mpg %>% filter(class=="compact") %>% group_by(manufacturer) %>% summarise(class_n=n()) %>% arrange(desc(class_n))

#n_distinct() - 중복된 행의 배제