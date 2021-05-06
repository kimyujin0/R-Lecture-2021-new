# 문자열 처리
# [R] R에서 String(문자열) 처리하기 - 베어베어스 참조
library(stringr)

# 1. Character로 형 변환
example <- 1
typeof(example)          # double (숫자)
example <- as.character(example)
typeof(example)          # character로 형변환

# 입력을 받는 경우
input <- readline('Prompt> ')
input                    # 입력을 받으면 문자형(character)이 기본적으로 들어옴
i <- as.numeric(input)
3 * i                    # 문자와 숫자의 형태가 다름. 문자<->숫자 변형 알아두어야함.

# 2. String 이어 붙이기
paste('A','quick','brown','fox')   # 문자형 출력, 스페이스가 달려 나옴.
paste0('A','quick','brown','fox')  # 스페이스 제외하고 나옴.
paste('A','quick','brown','fox', sep = '-')   # 스페이스 대신 -으로 연결됨(구분자 영향)
s <-paste('A','quick','brown','fox', sep = '-')
sample <- c('A','quick','brown','fox')     # 벡터로 만들음
paste(sample)
paste(sample, collapse = ' ')   # 제대로 연속된 형태로 만들음
str_c(sample, '1', sep = '_')   # 각각의 벡터에 대해 _1을 엮어 붙인다.
str_c(sample, '1', sep = '_', collapse = '@@')  # collapse는 여러개의 벡터로 나누어져 있는 것을 한 줄로 이어 붙인다.

# 3. Character 개수 카운트
x <- 'Hello'   # 5byte 차지
nchar(x)    # 글자수 셈
h <- '안녕하세요'    # 10byte 차지
nchar(h)
str_length(h)

# 4. 소문자 변환 - 한글은 해당사항이 없음
tolower(x)

# 5. 대문자 변환
toupper(x)

# 6. 2개의 character vector를 중복되는 항목 없이 합하기 - 합집합
str_1 <- c('hello','world', 'r','program')
str_2 <- c('hi','world', 'r','coding')
union(str_1, str_2)      # 합집합

# 7. 2개의 character vector에서 공통된 항목 추출 - 교집합
intersect(str_1, str_2)  # 교집합

# 8. 차집합
setdiff(str_1,str_2)  # str_1에서 str_2를 뺌, 중복된 것 배제

# 9. 2개의 character vector 동일 여부 확인 (순서에 관계 없이)
str_3 <- c('r', 'hello', 'program','world')
setequal(str_1, str_2)   # 글자들이 다르므로 FALSE
setequal(str_1, str_3)   # 나와있는 글자가 같으므로 TRUE

# 10. 공백 없애기
vector_1 <- c('    Hello world!   ','     Hi R!    ')
str_trim(vector_1, side = 'left')     # 글자 앞부분에 있었던 공백이 제거
str_trim(vector_1, side = 'right')    # 글자 뒷부분에 있었던 공백이 제거
str_trim(vector_1, side = 'both')     # 둘 다 공백이 제거

# 11. String 반복
str_dup(x, 3)        # x를 3회 반복하자! (붙어서)
rep(x,3)             # x를 3회 띄워서 반복

# 12. Substring(String의 일정 부분) 추출
string_1 <- 'Hello world'
substr(string_1, 7, 9)   # 7번째부터 9번째까지
substring(string_1, 7, 9) 
str_sub(string_1, 7, 9)  # 3개가 같은 결과
substr(string_1, 7)      # error
substring(string_1,7)    # 끝까지 나옴. 7번째부터 끝까지
str_sub(string_1, 7)     # 끝까지 나옴.
str_sub(string_1, 7, -1)
str_sub(string_1, 7, -3)
string_1[7:9]            # NA NA NA

# 13. String의 특정 위치에 있는 값 바꾸기
string_1 <- 'Today is Monday'
substr(string_1, 10,12) <- 'Sun'
string_1
substr(string_1, 10,12) <- 'Thurs'
string_1         # "Today is Thuday" - 길이가 달라서 들어가지 않음

# 14. 특정 패턴(문자열)을 기준으로 String 자르기
strsplit(string_1, split = ' ')   # 단어 기준으로 띄어쓰기 함
str_split(string_1, pattern = ' ')
str_split(string_1, pattern = ' ', n=2)   # 조각을 2개로 나누어라
str_split(string_1, pattern = ' ', simplify = T)     # 행렬로 변환
s <- str_split(string_1, pattern = ' ')
typeof(s)    # 리스트 타입
s[[1]]       # 리스트에서 꺼내려면 []를 추가하여 벡터로 나오게 함
s[[1]][1]    # 리스트의 첫번째 엘리먼트 - "Today"
# 리스트를 벡터로 변환 : unlist()
unlist(s)
paste(unlist(s), collapse = ' ')  # 하나로 묶임


# 15. 특정 패턴(문자열) 찾기 (기본 function)
vector_1 <- c('Xman','Superman','Joker')
grep('man', vector_1)        # 벡터에서 man이 들어가는 번째
grepl('man', vector_1)       # T or F로 표현
regexpr('man',vector_1)
gregexpr('man',vector_1)

# 16. 특정 패턴(문자열) 찾기 (stringer package function)
fruit <- c('apple','banana','cherry')
str_count(fruit,'a')
str_detect(fruit,'a')        # 감지가 됨을 알려줌, 되면 T 안되면 F
str_locate(fruit,'a')
str_locate_all(fruit,'a')

people <- c('rorori','emilia','youna')
str_match(people,'o(\\D)')   # o(\\D) - 정규 표현식, \\D는 non-digit character를 의미

# 17. 특정 패턴(문자열) 찾아서 다른 패턴(문자열)으로 바꾸기
fruits <- c('one apple','two pears','three bananas')
sub('a','A', fruits)
gsub('a','A', fruits)   
str_replace(fruits, 'a','A')
str_replace_all(fruits, 'a','A')         # a를 찾아 A로 바꿈