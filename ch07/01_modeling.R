# 현실 세계의 모델링
X <- c(3, 6, 9, 12.)   # 마지막 . - 실수
Y <- c(3, 4, 5.5, 6.5)
plot(X,Y)

# model 1: y=0.5x+1.0
Y1 = 0.5 * X + 1.0
Y1
# 평균 제곱 오차 : Mean Squared Error
(Y - Y1)^2
sum((Y - Y1)^2)
mse <- sum((Y - Y1)^2) / length(Y)      # 실제값과 계산하여 나온 값의 차이 제곱을 더한 후 개수로 나눈다.
mse


# model 2: y=5/12x + 7/4
Y2 = 5 * X / 12 + 7/4
Y2
mse2 <- sum((Y-Y2)^2) / length(Y)
mse2                 # model 2가 더 최적의 회귀식이다.

# R의 단순 선형회귀 모델 lm
model <- lm(Y ~ X)   # ~표시
model                # y = 0.4x + 1.75

plot(X,Y)
abline(model, col = 'red')  
fitted(model)        # model 예측값

mse_model <- sum((Y-fitted(model))^2)/ length(Y)
mse_model            # mse값이 가장 작으므로 가장 좋음

#  잔차 - Residuals
residuals(model)     # 잔차 : 예측한 선과 동그라미의 차이
# 선형회귀가 제대로 되었나 확인 하는 것 - 잔차 분석

# 잔차 제곱합
deviance(model)      # sum((Y-fitted(model))^2) = 0.05

# 평균 제곱오차(MSE)
deviance(model) / length(Y)

summary(model)       # 잔차 요약(식, 잔차, 기울기와 계수)

# 예측
newX <- data.frame(X=c(1.2, 2, 20.65))
newY <- predict(model, newX)
newY

# 연습문제 1
X <- c(10.0, 12.0, 9.5, 22.2, 8.0)
Y <- c(360.2, 420.0, 359.5, 679.0, 315.3)
model <- lm(Y ~ X)
plot(X,Y)
abline(model, col='red')
deviance(model)
deviance(model)/length(Y)
new <- data.frame(X=c(10.5, 25.0, 15.0))
newy <- predict(model, newdata = new)
plot(new$X, newy, pch=2)
abline(model, col='red')