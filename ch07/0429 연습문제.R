# Galton 아버지(Father)와 아들의 키(Height)의 회귀식을 구해보고 의미를 파악해보시오.
galton <- read.csv('https://www.randomservices.org/random/data/Galton.txt',sep = '\t')
head(galton)
str(galton)
galton$Father <- galton$Father*2.54
galton$Mother <- galton$Mother*2.54
galton$Height <- galton$Height*2.54
head(galton)
galton_son <- subset(galton, Gender=='M')
head(galton_son)
plot(galton_son)
galton_model <- lm(Height~Father, data=galton_son)
coef(galton_model)

# 잔차 분석 그래프
par(mfrow=c(2,2))
plot(galton_model)
par(mfrow=c(1,1))

# 요약 통계량
summary(galton_model)

# 회귀식 : Height = Father*x + 97.177, Height=0.4477*Father + 97.177
# 두 변수 모두 p-vale가 0.05이하이므로 유의하며 15%의 낮은설명력을 가진다.

m3 <- lm(Height~poly(Father,2),data = galton_son)
summary(m3)       # 다차식으로 적용해보기-> 더 좋은 결과가 나올 수 있음
coef(m3)

# 그래프
ggplot(galton, aes(Father, Height)) +
    geom_point(position='jitter', color='blue')

model <- lm(Height~Father, data=galton)
coef(model)

ggplot(galton, aes(Father, Height)) +
    geom_point(position='jitter', color='blue') +
    geom_abline(intercept=coef(model)[1], slope=coef(model)[2], 
                color='yellow', size=1)
