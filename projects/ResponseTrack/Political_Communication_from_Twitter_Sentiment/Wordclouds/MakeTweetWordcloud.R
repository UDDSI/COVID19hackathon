###
###Make Wordcloud for DE Tweets
###5/08/2020
###Benjamin E. Bagozzi
###

##############
####Set Up####
##############

#clear memory
rm( list=ls() )

#Load some necessary packages
library(tm)
library(rvest)
library(textutils)
library(tm)
library(Rcpp)
library(wordcloud)
library(Rstem)
library(RColorBrewer)
library(XML)

#set seed
set.seed(50)

#set working directory
setwd("...")

#################
####Combining####
#################

#read-in and briefly format news data
tweets<-read.csv("Kaggle-cvoid-19-twitter-delaware.csv",header=TRUE)

#######################################
#####Analyze as a Single Document######
#######################################

#convert to corpus format for more text pre-processing tools
document <- Corpus(VectorSource(as.character(tweets$text)))

#remove punctuation
document <- tm_map(document, removePunctuation, preserve_intra_word_dashes = TRUE)

#convert to lower case
document <- tm_map(document, content_transformer(tolower))

#remove all numbers
document <- tm_map(document, removeNumbers)

#remove stopwords
document<-tm_map(document,removeWords,c(stopwords("english")))

#remove whitespace
document <- tm_map(document, stripWhitespace)

#stem all words
document <- tm_map(document, stemDocument, language = "english") 

#also remove words that it appeared were used to subset the documents
document<-tm_map(document,removeWords,c("coronavirus","delawar","covid"))


####################################
#########Make Wordcloud#############
####################################

#convert corpus to term document matrix
tdm <- TermDocumentMatrix(document,control = list(tolower=FALSE))

#let's have a look
inspect(tdm[10:15,1:1])

#inspect most popular terms
findFreqTerms(tdm, lowfreq=50)

#extract some relevant items from the term document matrix
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

#set up a pretty color pallette
pal <- brewer.pal(9,"OrRd")
pal <- pal[-(1:4)]

#create word cloud
par(mar=c(0, 0, 0, 0))
wordcloud(d$word,d$freq,c(2.25,.70),min.freq=40,,FALSE,,.15,pal,main="DE Gov COVID-19 Communications")
#
