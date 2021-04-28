library(gapminder)
library(dplyr)
library(ggplot2)

# 1 gapminder 데이터에 기록된 전 세계 인구의 구성 비율은 어떻게 변화하고 있을까?
# 1). 전체 관측 기간 중 1952년도의 인구 구성을 추출한 후 pie와 barplot으로 시각화
x <-gapminder %>% filter(year==1952) %>%
    select(pop,country) %>% 
    arrange(desc(pop)) %>% 
    head()
pie(x$pop, x$country)
barplot(x$pop, names.arg = x$country)

# 2). 1952~2007년의 인구 구성을 for 문을 이용해 반복적으로 시각화하라.
for (i in seq(1952,2007,5)) {
    print(i)
    x <-gapminder %>% filter(year==i) %>% select(country, pop) %>% 
        arrange(desc(pop)) %>% head()
    pie(as.numeric(x$pop), x$country)
    barplot(x$pop, names.arg=x$country)
    title(i)
}

# 3). 시각화 그래프를 통해 알게 된 사실을 몇 가지로 요약하라.


# 2
library(tidyr)
# 2-1 airquality
head(airquality)
air_tidy <- gather(airquality, key = 'Measure', value = 'Value',
                   -Day, -Month)     # key - 한줄로 나열할 때 왼쪽, value - 오른쪽
head(air_tidy)
dim(airquality)
dim(air_tidy)             # gather - 행단위로 나열하기

air_tidy %>% ggplot(aes(Day, Value, col = Measure)) + geom_point() +
    facet_wrap(~Month)

# 2-2 iris
head(iris)
iris_tidy <- gather(iris, key ='feat', value = 'Value', -Species)
head(iris_tidy)
iris_tidy %>% ggplot(aes(feat, Value, col=Species)) + geom_point(position = 'jitter') # jitter - 산점도의 점을 흔드는 것(겹쳐져서 퍼지게 보임)

# ggplot2를 이용하여 Iris 데이터 셋에 대해서 다음 문제를 푸세요.
# 1). 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)
library(gridExtra)
seto <- filter(iris, Species == 'setosa')
vers <- filter(iris, Species == 'versicolor')
virg <- filter(iris, Species == 'virginica')

seto_s <- seto %>% ggplot(aes(Sepal.Length, Sepal.Width, col = Species)) + 
    geom_point()
seto_s
seto_p <- seto %>% ggplot(aes(Petal.Length, Petal.Width, col = Species)) + 
    geom_point()
seto_p
ver_s <- vers %>% ggplot(aes(Sepal.Length, Sepal.Width, col = Species)) + 
    geom_point()
ver_s
ver_p <- vers %>% ggplot(aes(Petal.Length, Petal.Width, col = Species)) + 
    geom_point()
ver_p
virg_s <- virg %>% ggplot(aes(Sepal.Length, Sepal.Width, col = Species)) + 
    geom_point()
ver_s
virg_p <- virg %>% ggplot(aes(Petal.Length, Petal.Width, col = Species)) + 
    geom_point()
virg_p

grid.arrange(seto_s, seto_p, ver_s, ver_p, virg_s, virg_p, ncol = 2)

# 2). 품종별 Sepal/Petal의 Length/Width 평균을 비교하되 항목을 옆으로 늘어놓은 것(beside=T)과 위로 쌓아올린 것 2개를 그리시오. (총 12개 항목의 데이터를 2개의 그래프에)
seto_mean <- apply(iris[iris$Species=='setosa', 1:4],2,mean)
vers_mean <- apply(iris[iris$Species=='versicolor', 1:4],2,mean)
virg_mean <- apply(iris[iris$Species=='virginica', 1:4],2,mean)
mean_of_iris <- rbind(seto_mean, vers_mean, virg_mean)
mean_of_iris

barplot(mean_of_iris, beside = T, main='품종별 평균', ylim=c(0,8), col = c('red','blue','green')) 
legend('topright', legend = c('Setosa','Versicolor','Virginica'), fill=c('red','blue','green'))

# ggplot
df <- iris %>%  group_by(Species) %>% summarise(sepal_length =mean(Sepal.Length), sepal_width=mean(Sepal.Width),
                                                petal_length =mean(Petal.Length), petal_width=mean(Petal.Width))
df
df_tidy <- gather(df, key='Feature', value = 'Value', -Species)
df_tidy
ggplot(df_tidy, aes(Feature, Value, fill=Species)) + geom_bar(stat='identity', position='dodge')

# 3). boxplot
par(mfrow=c(3,1))    # 3행 1열의 그래프 그리기
b1<-boxplot(seto$Sepal.Length, seto$Sepal.Width, seto$Petal.Length, seto$Petal.Width,
        col=c('red','yellow','green','blue'), names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Setosa')
b2<-boxplot(vers$Sepal.Length, vers$Sepal.Width, vers$Petal.Length, vers$Petal.Width,
        col=c('red','yellow','green','blue'), names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Vericolor')
b3<-boxplot(virg$Sepal.Length, virg$Sepal.Width, virg$Petal.Length, virg$Petal.Width,
        col=c('red','yellow','green','blue'), names=c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'),
        main='Virginica')
par(mfrow=c(1,1))

# ggplot
