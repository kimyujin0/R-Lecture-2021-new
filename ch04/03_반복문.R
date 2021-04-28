# 반복문
# 1. repeat (1부터 10을 반복하여 더하는 반복문)
i <- 1
sum <- 0
repeat{
    if (i>10) {
        break    # 반복문을 꺼내주는 것
    }
    sum<-sum+i
    i<-i+1
}
print(sum)

# 2. while
i <- 1
sum <- 0         # sum은 무조건 0으로 초기화
while (i<=10) {
    sum <- sum+i
    i <- i+1
}
print(sum)

# for
sum <- 0         # 초기값을 초기화
for (i in 1:10) {
    sum <- sum + i
}
print(sum)

# ex) 10!
product <- 1
for (i in 1:10) {
    product <- product * i
}
print(product)

i <- 1
sum <- 1
repeat{
    if (i>10) {
        break 
    }
    sum <-sum *i
    i<-i+1
}
print(sum)

i <- 1
b <- 1       
while (i<=10) {
    b <- b * i
    i <- i+1
}
print(b)

# 1~100까지 홀수의 합
a <- 0
for (i in 1:100) {
    if(i%%2 == 1) {
    a <- i + a    
    }
}
print(a)

odd_sum <- 0
for (i in seq(1,100,by=2)) {
    odd_sum <- odd_sum + i
}
print(odd_sum)

# 구구단 만들기
for (k in 1:9) {
    print(paste('2', 'x', k, '=', 2*k))
}

for (i in 2:9) {
    print(paste0(i, '단'))
    for (k in 1:9) {
        print(paste(i, 'x', k, '=', i*k))
    }
}

# Matrix 문제 풀기
mat<- matrix(1:12, nrow = 3)
nrow <- 3
ncol <-4

# 1). 숫자의 합
sum1 <- 0
for (i in 1:nrow) {
    for (k in 1:ncol){
        sum1 <- sum1 + mat[i,k]
    }
}
print(sum1)

# 2). 숫자 제곱의 합
sum2 <- 0
for (i in 1:nrow) {
    for (k in 1:ncol){
        sum2 <- sum2 + mat[i,k]**2
    }
}
print(sum2)

# 3). 첫번째 행 그대로, 두번째 행 제곱합
sum1 <- 0
sum2 <- 0
sum3 <- 0
for (i in 1:nrow) {
    for (k in 1:ncol){
        sum1 <- sum1 + mat[i,k]
        sum2 <- sum2 + mat[i,k]**2
        sum3 <- sum3 + mat[i,k]**i
    }
}
print(paste(sum1,sum2,sum3))

# 별 그리기 (문제로 많이 나옴!)
for (i in 1:5) {
    star <- ''
    for (k in 1:i){
      star <- paste0(star, '+')
    }
    print(star)
}

# list 만들기
lst =list()
lst <- append(lst,3)   # 리스트에 값을 부여여
lst <- append(lst,5)
lst <- append(lst,7)
length(lst)
lst[1]

lst <- list()
for (i in 1:5) {
    lst <- append(lst, i )
}
lst

for (element in lst) {
    print(element)
}                         # 리스트에서 처음에 나오는 element를 각각 추출

vec <- c(1,7,8)
for (element in vec) {    # 실전에 많이 나옴!
    print(element)
}
for (element in mat) {
    print(element)
}

# 약수
N = 6
for (num in 1:N) {
    if (N %% num == 0) {  # 약수 : 나누는 수와 숫자로 나눈 %%가 0
        print(num)
    }
}
# 약수의 합
sum <- 0
for (num in 1:N) {
    if (N %% num == 0) {
        sum <- sum + num
    }
}
print(sum)

# Perpect Number
# 2에서 10000 사이의 완전수를 찾으시오.
for (N in 2:10000) {
    sum <- 0
    for (num in 1:(N-1)) {
        if (N %% num == 0) {
            sum <- sum + num
        }
    }
    if (sum == N) {
        print(N)
    }
}
