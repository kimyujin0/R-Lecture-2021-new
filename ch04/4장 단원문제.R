# 1. 1부터 100까지의 수 중에서 3의 배수이면서 4의 배수는 아닌 수의 합을 구하라.
i <- 1
sum <- 0
for (i in 1:100) {
    if (i %% 3==0 && i %% 4 != 0) {
        sum <- sum + i
    }
}
print(sum)

# 2. x와 n을 입력하면 1부터 n까지의 수 중에서 x의 배수 합을 구해주는 사용자 정의 함수를 만들어라.
range_sum <- function(x,n) {
    sum <- 0
    for (i in 1:n) {
        if(i %% x == 0){
            sum <- sum + i
    
        }
    }
    return(sum)
}
range_sum(3,10)

# 3. install.packages("hflights")와 library(hflights) 명령어를 이용하여 hflights 데이터를 활용할 수 있게 하자. hflights데이터에는 총 몇 개의 NA가 존재하는가?
library(hflights)
head(hflights)
sum(is.na(hflights))

# 4. hflights 데이터에서 비행시간이 가장 긴 데이터는 몇 시간 몇 분인가?
head(na.omit(hflights))
a<-na.omit(hflights)
hour<-max(a$AirTime)%/%60
minute<-max(a$AirTime)%%60
time<-paste0(hour,'시간', minute,'분')
time

# 5. hflights 데이터에서 비행거리가 가장 긴 데이터는 몇 마일인가?
max(a$Distance)
mile <- paste0(max(a$Distance),'마일')
mile

# 6. hflights 데이터에서 비행편이 취소된 건수는 몇 건인가? 0
sum(a$Cancelled==1)

