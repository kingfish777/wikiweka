
setwd("/home/propp/Desktop/corpora/bigoil")

# retrieve data from redacted_war_diary_irq and put into individual text files

# divide and conquer

library(RMySQL)
library(R.oo)
library("topicmodels")
library("tm")
library("lsa")
library("Rgraphviz")

setwd("/home/propp/wikileaks/")

drv = dbDriver("MySQL")

con = dbConnect(drv, dbname='wikileaks', user='root', password='mandarin',
                host='127.0.0.1')

nrows = fetch(dbSendQuery(con, 'SELECT COUNT(DISTINCT id) FROM redacted_war_diary_irq'))

nr = as.numeric(nrows)

for (i in 1:nr) {
  query = paste('SELECT summary FROM redacted_war_diary_irq rwdi WHERE rwdi.id =', i)
  data = as.data.frame(dbGetQuery(con, query))
  filename = paste(as.character(i), ".txt")
  filename = sub('[[:space:]]{1}', '', filename)
  write(t(data), file=filename)
}

##########

 library("topicmodels")

 library("tm")

 library("lsa")

 library("Rgraphviz")

 setwd("/home/scott/Desktop/corpora/bigoil")

 txt <- system.file("texts", "txt", package = "tm")

 corpus <- Corpus(DirSource(), readerControl = list(language = "eng"))

 corpus <- tm_map(corpus, removePunctuation)

 corpus <- tm_map(corpus, tolower)

 corpus <- tm_map(corpus, stripWhitespace)

 corpus <- tm_map(corpus, removeWords, stopwords("english"))

 corpus <- tm_map(corpus, stemDocument)

 dtm <- DocumentTermMatrix(corpus,control=list(minWordLength=3, minDocFreq=5))

# dtm <- removeSparseTerms(dtm, 0.99)

 lsa <- lsa(dtm, dims = dimcalc_share(share = .5))

 lsa_k <- lsa(dtm, dims = dimcalc_kaiser())

 plot(dtm, corThreshold = 0.5)

 inspect(corpus)[[20]]

 summary(lsa)

 p_LDA <- LDA(dtm[1:250,], control = list(alpha = 0.1), 10)
 
 post <- posterior(p_LDA, newdata = dtm[-c(1:250),])

 round(post$topics[1:5,], digits = 2)

 get_terms(p_LDA, 10)

 plot(dtm, corThreshold = 0.15, terms = findFreqTerms(dtm, 28, Inf), attrs=list(node=list(shape="ellipse", fixedsize=FALSE, label="courier", fillcolor="red"), edge=list(color="pink"), graph=list(rankdir="TB")), main="wikileaks.org")

