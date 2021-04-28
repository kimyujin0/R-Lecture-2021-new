women
cars

str(cars)

a<-2
b<-a*a

# 작업 디렉토리 지정
getwd()
setwd('/Workspace/R')
getwd()

# 라이브러리 부착
library(dplyr)
library(ggplot2)
search()

# iris
str(iris)
head(iris)    #Defalt(기본값)은 6
head(iris,10)
tail(iris,10)
plot(iris)

# 산점도
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch=10)

# tips.csv download
tips<-read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips)

# 요약 통계량
summary(tips)

# ggplot2로 여러가지 그래프 그리기
tips %>% ggplot(aes(size))+geom_histogram() #히스토그램
tips%>%ggplot(aes(total_bill,tip))+geom_point() #산점도
tips%>%ggplot(aes(total_bill,tip))+geom_point(aes(col=day)) #요일별 숫자형변수 산점도
tips%>%ggplot(aes(total_bill,tip))+geom_point(aes(col=day,pch=sex),size=3) #요일별 색깔과 성별 모양 구분 산점도
tips%>%ggplot(aes(total_bill,tip))+geom_point(aes(col=day,pch=time),size=3) #요일별 색깔과 시간별 모양 구분 산점도
#aes-그래프 적용

getwd()
setwd('/Workspace/R')

# 변수(Variable)
x<-1
y<-2
z<-x+y
z

# Swapping
temp<-x
x<-y
y<-temp #temp-변수 순서 바꾸기 (x와 y를 바꿈)

# 변수의 타입
typeof(x)
a<-'string'
typeof(a)
b<-"double quote"
typeof(b)
c<-'한글'
typeof(c)

# 실수(Numeric)
x<-5
y<-2
x/y
# 복소수(Compless)
xi<-1+2i
yi<-1-2i
xi+yi
xi*yi

# 범주형(category)
blood_type<-factor(c('A','B','O','AB'))
blood_type

# 논리형
TRUE
FALSE
T
F

xinf = Inf
yinf= -Inf
xinf / yinf

# 데이터형 확인 함수
class(x)     # R 객체지향 관점
typeof(x)    # R 언어 자체 관점
is.integer(x)
is.numeric(x)
is.complex(xi)
is.character(c)
is.na(xinf/yinf) # 결과가 NaN이니까 TRUE가 나옴

# 데이터형 변환 함수
is.integer(as.integer(x))
is.factor(as.factor(c))

# 산술 연산자(+, - /, *, ^, **, %%, %/%)
5^2
4^(1/2)
x %% y        # %%는 나머지(모듈형 연산)
x %/% y       # %/%는 몫

# 비교 연산자(<, >, <=, >=, !=, ==)
x < y
x <= y
x >= y
x ==y
x !=y

# 논리 연산자
!T        # !는 not
!F
x|y       # OR
x&y       # AND
x||y
a<-c(F, F, T, T)
b<-c(F, T, F, T)
a|b       # element-wise OR 
a||b      # 첫번째 엘리먼트의 논리합
a&b
a&&b      # 기호 한개와 두개의 차이는전체거나 첫번째만이다
2^-3-5**1/2>=2    #2^(-3) - 5**(1/2) >= 2 우선순위가 불분명하면 괄호()를 써준다
