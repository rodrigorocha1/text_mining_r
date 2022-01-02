library(tm)
library(NLP)
library(rtweet) # To get emojis dataset
## importação

df_tweets = read.csv('dados_2021_2022_5507.csv', encoding = "UTF-8")

data_inicio_tweets = min(df_tweets$created_at)

data_ifm_tweets = max(df_tweets$created_at)

tweets = df_tweets$text

# Remoção de emoji 
tweets <- gsub('\\p{So}|\\p{Cn}', '', tweets, perl = TRUE)
# Reconhecimento de arquivos

texto <- VCorpus(VectorSource(tweets))

## INICIO DO TRATAMENTO 

emojis # Look at emojis


library(stringr)
str_remove_all(string = df_tweets$text, pattern = '[:emoji:]')


inspect(texto[1:2])
#Remoção para espaço
tweets_trans <- tm_map(texto, stripWhitespace)
inspect(tweets_trans[[1]])

#Convertendo para minúsculo
tweets_trans <- tm_map(tweets_trans, content_transformer(tolower))
inspect(tweets_trans[[1]])

#Removendo palavras desnecessárias 
tweets_trans <- tm_map(tweets_trans, removeWords, stopwords('pt'))
inspect(tweets_trans[[1]])
inspect(tweets_trans[[2]])

tweets_trans <- tm_map(tweets_trans, function(x) gsub('@[[:alnum:]]*', '', x)) #removendo menções

tweets_trans <- tm_map(tweets_trans, function(x) gsub('http[[:alnum:]]', , x))  #removendo URLs

unlist(tweets_trans)
tweets_trans[[1]]
df_tweets$tweets_tratados <- tweets_trans

tweets_trans[[2]]$content
