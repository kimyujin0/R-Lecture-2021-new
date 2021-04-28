#1번 x는 1부터 100까지의 수 중 3의 배수만 포함하고 y는 1부터 100까지의 수 중 4의 배수만 포함하는 벡터로 만들어라.
x <- seq(3, 100, by=3)
y <- seq(4, 100, by=4)
x
y

#2번 1번 문제에서 x와 y의 교집합을 구하고, 교집합에 포함된 수를 모두 더한 값을 구하라.
a <- intersect(x,y)
sum(a)

#3. airquality 데이터는 어느 도시의 공기 질을 나타낸 데이터인가?
?airquality
#New York

#4. airquality 데이터의 온도 단위는 무엇인가?
#degrees F

#5. airquality 데이터에서 바람이 가장 세게 분 날짜는 언제인가? 17
head(na.omit(airquality))
a<-na.omit(airquality)
max(a$Wind)
a[a$Wind==20.7,c("Month","Day")]

max_wind<-max(airquality$Wind)
wind_day<-airquality[airquality$Wind==max_wind, 5:6]
wind_day
date<-paste0('1973-', wind_day$Month, '-', wind_day$Day)
date   #문자열
date_type<-as.Date(date)  #Date
date_type


#6. airquality 데이터에서는 총 몇 개의 NA가 포함되어 있는가? 44
head(is.na(airquality))
table(is.na(airquality))
sum(is.na(airquality))

#7. quakes 데이터는 어느 섬의 지진을 관측한 데이터인가?
?quakes
#Fiji

#8. quakes에 기록된 가장 큰 지진의 규모는 얼마인가?
head(quakes)
table(is.na(quakes)) #결측치 없음
summary(quakes)
max(quakes$mag)
quakes[quakes$mag==max(quakes$mag),]

# Date type으로
days<- seq(as.Date('2021-04-01'), as.Date('2021-04-30'),by=1)
days

