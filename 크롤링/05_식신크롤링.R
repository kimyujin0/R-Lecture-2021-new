# 식신 웹페이지에서 상호, 전화번호, 주소, 소개 크롤링
library(rvest)
library(stringr)
library(dplyr)

base_url <- 'https://www.siksinhot.com'
path <-'/search'
place <-'한남대'
query <- paste0('?keywords=', URLencode(iconv(place, to='UTF-8')))


root <-html_node(html, '#root') 
wrap <- html_node(root, '#wrap')
container <- html_node(wrap, '#container')
contents <- html_node(container, '#contents')
sub_contens <- html_node(contents, '.sub_contens')
new_result <- html_node(sub_contens, '.sch_result_cnt')
sch <- html_node(new_result,'.sch_result_cnt')
sch_list <- html_node(sch,'sch_list1')
sub_contens <- html_node(container, '.listTy1')
lis <- html_nodes(sub_contens, 'li')     
li <- lis[1]
info <- html_node(li, '.info')    
title <- html_node(info, '.book_tit')
title <- html_text(title)
title                  # 제목 찾기
writer <- info %>% html_node('.book_writer') %>% html_text()
writer  
