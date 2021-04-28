# 벡터(Vector, 1차원 데이터)
s <- c(1,2,3,4,5,6)
s2 <- c(1:6)       #시작:끝
s3 <- c(6:1)
s4 <- 1:5
c(1:3,c(4:6))
c(1:30)
seq(1,100, by=2)    #홀수만 출력
seq(from=100, to=1, by=-3)  #from하고 to는 생략 가능하지만 by는 필수
seq(0,1, by=0.1)
seq(0,1,length.out=11) #0부터 1까지 11개로 나누어 출력

rep(c(1:3), times=2) # rep 반복하는 함수, time 몇 번
rep(c(1:3), each=2)  # 같은 숫자를 2번씩 반복

# 인덱싱(indexing)
x <- seq(2,10,by=2)
x[1]        # 첫번째
x[-1]       # 첫번째 엘리먼트를 제외한 나머지
x[-3]
# slicing
x[1:3]
x[c(1,3,5)]
x[-c(2,4)]

# 연산
x <- c(1:4)
y <- c(5:8)
z <- c(3,4)
w <- c(5:7)

x + 2       # 3 4 5 6    숫자=스칼라 값
x + y       # 6 8 10 12
x + z       # 4 6 6 8
x + w       # 값은 나오지만 경고 메세지가 뜸. 6 8 10 9

length(w)   # 길이를 알 수 있는 중요한 함수

x > 2
all(x > 2)  # 전부 TRUE임을 물어봄, AND
any(x > 2)  # OR

# fancy indexing
y[x > 2]

x<-1:10
head(x)
head(x, 3)
tail(x)
tail(x, 3)

# 집합 연산
x <- 1:3
y <- 3:5
z <- c(3,1,2)

union(x,y)     # 합집합
intersect(x,y)    # 교집합
setdiff(x,y)      # 차집합
setdiff(y,x)      # 순서가 다르므로 결과도 달라짐
setequal(x,y)     # 같은 요소, F
setequal(x,z)     # T

########마크다운##########r에서 보고서 만들기
install.packages("rmarkdown")
install.packages("knitr")

library(rmarkdown)
library(knitr)
