# 다중 회귀분석
state.x77
head(state.x77)
states <- as.data.frame(state.x77[,c('Murder','Population','Illiteracy','Income',  'Frost')])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
summary(fit)
par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))

# 다중공선성 : 독립변수간 강한 상관관계가 나타나는 문제
# correlation(0.9이상이면 다중공선성 의심)
state.cor <-cor(states[2:5])
state.cor

# VIF(Variation Inflaction Factor) 계산 (10이상이면 다중공선성 의심)
library(car)
vif(fit)

# Condition Number (15 이상이면 다중공선성의 가능성이 있음)
eigen.val <- eigen(state.cor)$values
sqrt(max(eigen.val)/eigen.val)

fit1 <- lm(Murder ~., data=states)
summary(fit1)

fit2 <- lm(Murder ~ Population+Illiteracy, data = states)
summary(fit2)

# AIC
AIC(fit1,fit2)     # 값이 적을수록 좋은 모델

# Backward stepwise regression, Forward stepwise regression(변수선택법)
step(fit1, direction = 'backward')

fit3 <- lm(Murder~1, data = states)    # 1이라는 절편
step(fit3, direction = 'backward', scope = ~Population+Illiteracy+Frost)   # step - 자동화 해주는 툴
step(fit3, direction = 'forward', scope = list(upper=fit1, lower=fit3))

library(leaps)
subsets <- regsubsets(Murder~., data=states, method='seqrep', nbest = 4)
plot(subsets)

