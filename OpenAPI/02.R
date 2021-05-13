# Converting JSON to R DataFrame
library(jsonlite)

df_repos <- fromJSON("http://api.github.com/user/hadley")