###
###Make Wordcloud for DE Gov Communications (note: this still omits the one machine-transcribed video text)
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
news<-read.csv("coronanews.delaware.gov.csv",header=TRUE)
news$date<-as.character(news$date)
news$date<-gsub("Sunday, ","",news$date)
news$date<-gsub("Monday, ","",news$date)
news$date<-gsub("Tuesday, ","",news$date)
news$date<-gsub("Wednesday, ","",news$date)
news$date<-gsub("Thursday, ","",news$date)
news$date<-gsub("Friday, ","",news$date)
news$date<-gsub("Saturday, ","",news$date)
news$pressrelease<-0

#read-in and briefly format press release data
pressrelease<-read.csv("corona.pressrelease.de.gov.csv",header=TRUE)
pressrelease$date<-as.character(pressrelease$date)
pressrelease$pressrelease<-1

#remove press releases from news
news<-news[!((substr(news$text,1,20) %in% substr(pressrelease$text,1,20)) & (news$date %in% pressrelease$date)),]

#combine
combined.data<-rbind(news,pressrelease)

#####################
#####Preprocess######
#####################

#convert to corpus format for more text pre-processing tools
document <- Corpus(VectorSource(as.character(combined.data$text)))

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


########################################
#########Make Wordcloud#############
########################################

#convert corpus to term document matrixs
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
pal <- brewer.pal(9,"BuGn")
pal <- pal[-(1:4)]

#create word cloud
par(mar=c(0, 0, 0, 0))
wordcloud(d$word,d$freq,c(2.25,.70),min.freq=90,,FALSE,,.15,pal,main="DE Gov COVID-19 Communications")
#
