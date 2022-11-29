#do web crawling and make word cloud out of it using elbird

#load all the libraries needed
library(tidyverse)
library(tidytext)
library(tidytextdata)


#set url
url <- "https://ko.wikipedia.org/wiki/%EB%9F%AC%EC%8B%9C%EC%95%84-%EC%9A%B0%ED%81%AC%EB%9D%BC%EC%9D%B4%EB%82%98_%EC%A0%84%EC%9F%81"

#load data
html <- read_html(url)

#extract text
text <- html %>% 
    html_nodes("p") %>% 
    html_text()

#remove unnecessary text
text <- str_replace_all(text, "^[0-9]+", "")
text <- str_replace_all(text, "^[a-zA-Z]+", "")
text <- str_replace_all(text, "^[가-힣]+", "")
text <- str_replace_all(text, "^[\\s]+", "")

nouns <- tokenize(text) %>% # tokenize 기능으로 형태소 분류
    filter(len >= 2) %>% # 길이가 2 이상인 경우만 선정
    filter(tag %in% c("NNG", "NNP", "NNB", "SL", "NR")) %>%
    # tag 항목을 참조하여 명사(NN*), 영어(SL), 수사(NR) 선택
    select(form) #최종적으로는 형태소만 가져오면 됨

wordcount <- table(unlist(nouns)) #형태를 표로 변환(dataframe에 이용을 위함)하여 각 단어와 빈도를 저장
df_word <- as.data.frame(wordcount, stringsAsFactors = FALSE)
# df_word에 wordcount를 dataframe 형태로 변환하여 저장
df_word <- rename(df_word,
                  word = Var1, #각 단어를 word,
                  freq = Freq) #각 빈도수를 Freq로 이름 바꾸기

#make word cloud
pal <- brewer.pal(9, "Reds")[5:9]
wordcloud(words = df_word$word, #단어
    freq = df_word$freq, #빈도
    min.freq = 5,
    random.order = FALSE,
    colors = pal,
    family = "AppleGothic",
    scale = c(3, 1),
    rot.per = 0,
    random.color = TRUE,
    max.words = 200,
    use.r.layout = FALSE,
    fixed.asp = TRUE,
    ordered.colors = FALSE)