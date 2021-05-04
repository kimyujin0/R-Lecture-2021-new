# 단순 선형회귀의 적용
# cars 데이터
str(cars)   # 속도에 따른 제동거리, dist = speed*x, (dist~speed)
plot(cars)
car_model <- lm(dist~speed, data=cars)
coef(car_model) # coef- 계수를 보여주는 함수, 회귀식 : dist = 3.9324*speed-17.5791
abline(car_model, col='red')
summary(car_model)
#잔차분석 - 회귀 조건 :선형성, 정규성, 등분산성, 독립성을 만족
par(mfrow=c(2,2))
plot(car_model)
par(mfrow=c(1,1))

# 속도 21.5, 제동거리는?
nx1 <-data.frame(speed=c(21.5))
predict(car_model, newdata = nx1)

# 고차식(polynomial) 적용하면 어떻게 될까?
lm2 <- lm(dist~poly(speed,2),data = cars)    # 2차식 식
plot(cars)
x <- seq(4, 25, length.out=211)      # 4부터 0.1씩 커지는 게 211개
head(x)
y <- predict(lm2, data.frame(speed=x))  
lines(x, y, col='purple',lwd=2)
abline(car_model, col='red', lwd=2)

summary(lm2)       # 2차식은 영양가가 없고 1차식에서 가장 좋은 결과를 가진다.

# cars 1차식부터 4차식까지
x <- seq(4, 25, length.out=211)
colors <- c('red','purple','darkorange','blue')
plot(cars)
for (i in 1:4) {
    m <- lm(dist~poly(speed, i), data= cars)
    assign(paste('m', i, sep='.'), m)
    y <- predict(m, data.frame(speed=x))
    lines(x, y, col=colors[i],lwd=2)
}
summary(m)

# ANOVA - 분산 분석
anova(m.1, m.2, m.3, m.4)

# Women data
women
plot(women)
m <- lm(weight~height, data=women)
abline(m, col='red',lwd=2)
summary(m)

# 2차식으로 모델링
m2 <- lm(weight~poly(height,2),data = women)
x <- seq(58, 72, length.out=300)
y <- predict(m2, data.frame(height=x))
lines(x,y,col='blue',lwd=2)
summary(m2)       # 다차식으로 적용해보기-> 더 좋은 결과가 나올 수 있음
coef(m2)
