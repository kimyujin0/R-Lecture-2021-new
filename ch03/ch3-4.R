# 데이터 프레임
name <- c('철수', '춘향', '길동')
age <- c(22,20,25)
gender <- factor(c('M','F','M'))
blood_type <- factor(c('A','O','B'))

patients <- data.frame(name, age, gender, blood_type)
patients

patients$name  # 인덱스로 표현할 수 있음
typeof(patients$name)

patients[1,]  # 첫번째 행 모두 출력. 뒤에 빈칸이 있으면 all이라는 의미
patients[,2]  # patients$age 와 동일
patients0[2,3]  #F출력
patients$gender[3]  #M출력 열 선택 후 몇 번째 값 출력
patients[patients$name=='철수',]  # patients[1,]과 동일, filtering
patients[patients$name=='철수',c('age', 'gender')]  #selection

#  데이터 프레임의 속성명을 변수명으로 사용(attach~detach)
attach(patients)  #$를 생략해도 사용 가능
name
blood_type
detach(patients)

head(cars)
attach(cars)
speed
dist
detach(cars) # a와 d사이에서만 쓸 수 있음
speed    # 에러: 객체 'speed'를 찾을 수 없습니다

mean(cars$speed)
max(cars$dist)
with(cars, mean(speed))

# subset
subset(cars, speed>20)
cars[cars$speed>20,]  #동일결과, 이렇게 씀
subset(cars, speed>20, select=c(dist))
subset(cars, speed>20, select=-c(dist))  #dist를 제외하고 speed만 출력

# 결측값(NA) 처리
head(airquality)
str(airquality)
sum(airquality$Ozone)  #NA, 계산이 되지 않음

head(na.omit(airquality))  #결측치가 제거된 상태로 보여짐, NA가 있는 행 전체를 제거

# 병합(merge)
patients
patients1 <- data.frame(name, age, gender)
patients2 <- data.frame(name, blood_type)
merge(patients1, patients2, by='name')  #by: 병합할 기준

patients1 = data.frame(name, age, gender)
patients2 = data.frame(name, blood_type)
merge(patients1, patients2, by='name')



# 데이터프레임에 행 추가
length(patients1$name)
patients1[length(patients1$name)+1,]<-c('몽룡',19,'M')
patients1
patients2[length(patients2$name)+1,]<-c('영희', 'A')
patients2

# 열 추가
patients1['birth_year'] <- c(1500,1550,1600,1800)
patients1

# merge
# Inner join
merge(patients1, patients2)  #공통이면 by 생략 가능, 공통된 것만 나옴, (x,y)
# Left outer join
merge(patients1, patients2, all.x = T)

# Right outer join
merge(patients1, patients2, all.y = T)
# (Full) outer join
merge(patients1, patients2, all.x = T, all.y = T)


