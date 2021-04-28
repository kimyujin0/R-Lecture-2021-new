# Anscombe's Quartet
head(anscombe)

# 평균
apply(anscombe, 2, mean)     # 열 방향으로 평균
# 분산
apply(anscombe, 2, var)

# 상관관계
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)
for (i in 1:4) {
    print(cor(anscombe[,i], anscombe[,i+4]))
}

# 요약 통계량
summary(anscombe)

# 그래프 그리기
library(ggplot2)

ggplot(anscombe) +  geom_point(aes(x1,y1), color="darkorange", size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +               # 간격을 2 단위로 맞추겠다는 의미
    scale_y_continuous(breaks = seq(2,14,2)) +               # 순서 주의
    xlim(2,20) + ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                col = 'cornflowerblue', size=1) + labs(title='Dataset I')

p1<- ggplot(anscombe) + geom_point(aes(x1,y1), color="darkorange", size=3) +
    #scale_x_continuous(breaks = seq(2,20,2)) +
    #scale_y_continuous(breaks = seq(2,14,2)) +
    xlim(2,20) + ylim(2,14) + geom_abline(intercept = 3, slope = 0.5,
                                          col = 'cornflowerblue', size=1) +
    labs(title='Dataset 1')       # labs - 레이블(제목)
    # abline - 선형 회귀선 y=0.5x+3

p2 <- ggplot(anscombe) +  geom_point(aes(x2,y2), color="darkorange", size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +             
    scale_y_continuous(breaks = seq(2,14,2)) +              
    xlim(2,20) + ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                col = 'cornflowerblue', size=1) + labs(title='Dataset 2')

p3 <- ggplot(anscombe) +  geom_point(aes(x3,y3), color="darkorange", size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +             
    scale_y_continuous(breaks = seq(2,14,2)) +              
    xlim(2,20) + ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                col = 'cornflowerblue', size=1) + labs(title='Dataset 3')

p4 <- ggplot(anscombe) +  geom_point(aes(x4,y4), color="darkorange", size=3) +
    scale_x_continuous(breaks = seq(2,20,2)) +             
    scale_y_continuous(breaks = seq(2,14,2)) +              
    xlim(2,20) + ylim(2,14) +
    geom_abline(intercept = 3, slope = 0.5,
                col = 'cornflowerblue', size=1) + labs(title='Dataset 4')

# 여러가지 그래프 한번에 그리기
library(gridExtra)
grid.arrange(p1,p2,p3,p4, ncol=2, top="Anscombe's Quartet")

for (i in 1:4) {
}
########################################################################################

# Source Refactoring
x <- ggplot(anscombe) +  geom_point(aes(x4,y4), color="darkorange", size=3)
m1 <- x
assign(paste('m',4,sep = '.'),x) # 임의로 변수명을 지정할 때 사용
grid.arrange(p1,p2,p3,m.4, ncol=2, top="Anscombe's Quartet")     # x가 m,4로 바뀜

for (i in 1:4) {
   tmp <- ggplot(anscombe) +  geom_point(aes(anscombe[,i],anscombe[,4+i]), color="darkorange", size=3) +
        scale_x_continuous(breaks = seq(2,20,2)) +             
        scale_y_continuous(breaks = seq(2,14,2)) +              
        xlim(2,20) + ylim(2,14) +
        geom_abline(intercept = 3, slope = 0.5,
                    col = 'cornflowerblue', size=1) + labs(title=paste0('Dataset',i), x=paste0('x',i),y=paste0('y',i))
       assign(paste('m',i,sep = '.'),tmp)
 }

grid.arrange(m.1,m.2,m.3,m.4, ncol=2, top="Anscombe's Quartet")
