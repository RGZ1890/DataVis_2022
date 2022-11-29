#do web crawling and make word cloud out of it
#import necessary packages
library(rvest)
library(tm)
library(wordcloud)
library(RColorBrewer)


#set url
url <- "https://ko.wikipedia.org/wiki/%EB%9F%AC%EC%8B%9C%EC%95%84-%EC%9A%B0%ED%81%AC%EB%9D%BC%EC%9D%B4%EB%82%98_%EC%A0%84%EC%9F%81"

#load data
html <- read_html(url)

#extract text
text <- html %>% html_nodes("p") %>% html_text()

#remove unnecessary text
text <- str_replace_all(text, "^[0-9]+", "")
text <- str_replace_all(text, "^[a-zA-Z]+", "")
text <- str_replace_all(text, "^[가-힣]+", "")
text <- str_replace_all(text, "^[\\s]+", "")

#make corpus
corpus <- Corpus(VectorSource(text))

#make word cloud
pal <- brewer.pal(9, "Reds")[5:9]
wordcloud(corpus, min.freq = 2,
    random.order = FALSE,
    colors = pal,
    family = "AppleGothic",
    scale = c(5, 0.5),
    rot.per = 0,
    random.color = TRUE,
    max.words = 200,
    use.r.layout = FALSE,
    fixed.asp = TRUE,
    ordered.colors = FALSE)
