# 대전소재 자치단체 건물
#   - 다음 지도검색에서 위도, 경도 정보 알아내기
#   - 지도 위에 표시하기
library(httr)
library(jsonlite)
library(leaflet)
library(stringr)

dj <- read.csv('map/대전자치단체건물.txt', fileEncoding='UTF-8')
dj
addr <- dj$addr[1]

kakao_api_key <- readLines('OpenAPI/kakaoapi.txt', encoding = 'UTF-8')

base_url <- 'https://dapi.kakao.com/v2/local/search/address.json'
keyword <- URLencode(iconv(addr, to='UTF-8'))
keyword
query <- paste0('query=', keyword)
url <- paste(base_url,query,sep = '?')
url

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key
res <- GET(url, add_headers('Authorization'=auth_key))
res    # 200이 나와야 정상
result <- fromJSON(as.character(res))

result$documents$x  # 경도
as.numeric(result$documents$y)  # 위도

# df DataFrame에 위도, 경도 정보 추가
lngs <- c()
lats <- c()
for (i in 1:nrow(dj)) {
    addr <- dj$addr[i]
    keyword <- URLencode(iconv(addr, to='UTF-8'))
    query <- paste0('query=', keyword)
    url <- paste(base_url,query,sep = '?')
    res <- GET(url, add_headers('Authorization'=auth_key))
    result <- fromJSON(as.character(res))
    lngs <- c(lngs, as.numeric(result$documents$x))
    lats <- c(lats, as.numeric(result$documents$y))
}
dj$lng <- lngs
dj$lat <- lats
View(dj)

# 지도 위에 표시하기
leaflet(dj) %>% setView(lng=127.39, lat=36.35, zoom = 12) %>% addTiles() %>% 
    addMarkers(lng=~lng, lat = ~lat, label = ~place, popup = ~addr)

leaflet(dj) %>% setView(lng=mean(dj$lng), lat=mean(dj$lat), zoom = 12) %>% addTiles() %>% 
    addCircles(lng=~lng, lat = ~lat, label = ~place, popup = ~addr, weight=1, radius=~pop/1000)

dj$color <- ifelse(str_length(dj$place)>5, '#dd0022','#1133ee')
leaflet(dj) %>% setView(lng=mean(dj$lng), lat=mean(dj$lat), zoom = 12) %>% addTiles() %>% 
    addCircles(lng=~lng, lat = ~lat, label = ~place, popup = ~addr, weight=1, radius=~pop/1000, color=~color)
