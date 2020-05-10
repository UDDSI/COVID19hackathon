###
###Aggregate Gov Communications to daily level
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
library(XML)
library(topicmodels)
library(SnowballC)
library(stm)
library(slam)
library(Matrix)
library(tidyverse)
library(sentimentr)
library(quanteda)
library(stringr)

#set seed
set.seed(50)

#set working directory
setwd("...")

#read and format case counts#
casecounts<-read.csv("CaseCounts.csv",header=TRUE)
casecounts.de<-subset(casecounts,casecounts$state=="Delaware")
casecounts.de<-casecounts.de[,c("date","cases","deaths")]
colnames(casecounts.de)<-c("date","de.cases","de.deaths")

casecounts.md<-subset(casecounts,casecounts$state=="Maryland")
casecounts.md<-casecounts.md[,c("date","cases","deaths")]
colnames(casecounts.md)<-c("date","md.cases","md.deaths")

casecounts.nj<-subset(casecounts,casecounts$state=="Maryland")
casecounts.nj<-casecounts.nj[,c("date","cases","deaths")]
colnames(casecounts.nj)<-c("date","nj.cases","nj.deaths")

casecounts.usa.deaths<-aggregate(deaths~date, data=casecounts, FUN=sum)
casecounts.usa.deaths<-casecounts.usa.deaths[,c("date","deaths")]
colnames(casecounts.usa.deaths)<-c("date","usa.deaths")

casecounts.usa.cases<-aggregate(cases~date, data=casecounts, FUN=sum)
casecounts.usa.cases<-casecounts.usa.cases[,c("date","cases")]
colnames(casecounts.usa.cases)<-c("date","usa.cases")

#format twitter data
twitter<-read.csv("Kaggle-cvoid-19-twitter-delaware.csv",header=TRUE)
twitter<-twitter[,c("created_at","text")]
twitter$created_at<-gsub("T.*","",twitter$created_at)
twitter<-aggregate(as.character(twitter$text), by=list(twitter$created_at), paste, collapse=" ")
colnames(twitter)<-c("date","text")
sentiment=sentiment_by(twitter$text)
twitter$sentiment<-sentiment$ave_sentiment
twitter<-twitter[,c("date","sentiment")]
colnames(twitter)<-c("date","twittersentiment")

#################
####Combining####
#################

#read-in transcribed case
text.raw<-c(paste(readLines(file("transcribed.txt"), encoding = "UTF-8"),collapse=" "))

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

#add in transcribed case
news$text<-as.character(news$text)
news$text[59]<-text.raw

#read-in and briefly format press release data
pressrelease<-read.csv("corona.pressrelease.de.gov.csv",header=TRUE)
pressrelease$date<-as.character(pressrelease$date)
pressrelease$pressrelease<-1

#remove press releases from news
news<-news[!((substr(news$text,1,20) %in% substr(pressrelease$text,1,20)) & (news$date %in% pressrelease$date)),]

#combine
combined.data<-rbind(news,pressrelease)

#combine
combined.data$titletext<-paste(combined.data$title,combined.data$text,sep=" ")

#collapse by day
Collapsedbyday<-aggregate(combined.data$text, by=list(combined.data$date), paste, collapse=" ")
pressrelease<-aggregate(combined.data$pressrelease, by=list(combined.data$date), paste, collapse=" ")
Collapsedbyday$NumPressRelease<-str_count(pressrelease[,2], "1")
Collapsedbyday$NumNewsStories<-str_count(pressrelease[,2], "0")
colnames(Collapsedbyday)<-c("date","text","NumPressRelease","NumNewsStories")

#convert dates
Collapsedbyday$date<-gsub("2020","",Collapsedbyday$date)
Collapsedbyday$date<-gsub("January ","2020-01-",Collapsedbyday$date)
Collapsedbyday$date<-gsub("February ","2020-02-",Collapsedbyday$date)
Collapsedbyday$date<-gsub("March ","2020-03-",Collapsedbyday$date)
Collapsedbyday$date<-gsub("April ","2020-04-",Collapsedbyday$date)
Collapsedbyday$date<-gsub("May ","2020-05-",Collapsedbyday$date)
Collapsedbyday$date<-gsub(", ","",Collapsedbyday$date)
Collapsedbyday$date = format(as.Date(Collapsedbyday$date, "%Y-%m-%d"))

#sort by dates
Collapsedbyday<-Collapsedbyday[order(as.Date(Collapsedbyday$date, format="%Y-%m-%d")),]
readability<-textstat_readability(Collapsedbyday$text,measure = "Flesch")
Collapsedbyday$readability<-as.character(as.matrix(readability[,2]))

#create date template
Jan<-cbind(1,seq(27,31),2020)
Feb<-cbind(2,seq(1,29),2020)
Mar<-cbind(3,seq(1,31),2020)
Apr<-cbind(4,seq(1,30),2020)
May<-cbind(5,seq(1,7),2020)
Dates<-rbind(Jan,Feb,Mar,Apr,May)
Date.Template<-paste(Dates[,3],Dates[,1],Dates[,2],sep="-")
Date.Template<-as.data.frame(format(as.Date(Date.Template, "%Y-%m-%d")))
colnames(Date.Template)<-c("date")
Date.Template$date<-as.character(Date.Template$date)
total <- merge(Date.Template,Collapsedbyday,by="date",all.x = TRUE)

casecounts.de$date<-as.character(format(as.Date(casecounts.de$date, "%Y-%m-%d")))
total <- merge(total,casecounts.de,by="date",all.x = TRUE)
casecounts.md$date<-as.character(format(as.Date(casecounts.md$date, "%Y-%m-%d")))
total <- merge(total,casecounts.md,by="date",all.x = TRUE)
casecounts.nj$date<-as.character(format(as.Date(casecounts.nj$date, "%Y-%m-%d")))
total <- merge(total,casecounts.nj,by="date",all.x = TRUE)
casecounts.usa.cases$date<-as.character(format(as.Date(casecounts.usa.cases$date, "%Y-%m-%d")))
total <- merge(total,casecounts.usa.cases,by="date",all.x = TRUE)
casecounts.usa.deaths$date<-as.character(format(as.Date(casecounts.usa.deaths$date, "%Y-%m-%d")))
total <- merge(total,casecounts.usa.deaths,by="date",all.x = TRUE)

twitter$date<-as.character(format(as.Date(twitter$date, "%Y-%m-%d")))
total <- merge(total,twitter,by="date",all.x = TRUE)

#sentiment and readability, etc
sentiment=sentiment_by(total$text)
total$sentiment<-sentiment$ave_sentiment
total$readability<-ifelse(is.na(total$readability),0,total$readability)
total$NumPressRelease<-ifelse(is.na(total$NumPressRelease),0,total$NumPressRelease)
total$NumNewsStories<-ifelse(is.na(total$NumNewsStories),0,total$NumNewsStories)

total$de.cases<-ifelse(is.na(total$de.cases),0,total$de.cases)
total$de.deaths<-ifelse(is.na(total$de.deaths),0,total$de.deaths)
total$md.cases<-ifelse(is.na(total$md.cases),0,total$de.cases)
total$md.deaths<-ifelse(is.na(total$md.deaths),0,total$de.deaths)
total$nj.cases<-ifelse(is.na(total$nj.cases),0,total$nj.cases)
total$nj.deaths<-ifelse(is.na(total$nj.deaths),0,total$nj.deaths)
total$usa.cases<-ifelse(is.na(total$usa.cases),0,total$usa.cases)
total$usa.deaths<-ifelse(is.na(total$usa.deaths),0,total$usa.deaths)


#wordcounts
temp <- strsplit(total$text, split=" ")
total$wordCount <- sapply(temp, length)-1
#######################################
#####Analyze as a Single Document######
#######################################

#convert to corpus format for more text pre-processing tools
document <- Corpus(VectorSource(as.character(total$text)))

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

#convert to DTM
dtm.corpus <- DocumentTermMatrix(document)
dtm.corpus <- removeSparseTerms(dtm.corpus,.99)

#turn into DTM
matrixnew <- sparseMatrix(i=dtm.corpus$i, j=dtm.corpus$j, x=dtm.corpus$v, dims=c(dtm.corpus$nrow, dtm.corpus$ncol))

#combine
matrixtemp<-NULL
for(i in 1:ncol(matrixnew)){
matrixtemp<-cbind(matrixtemp,as.numeric(as.character(matrixnew[,i])))
}
matrixnew<-matrixtemp
colnames(matrixnew)<-c(dtm.corpus[[6]]$Terms)

#total[,2]<-gsub(",","",total[,2])
matrixnew<-cbind(total$date,total$twittersentiment,total$de.cases,total$de.deaths,total$md.cases,total$md.deaths,total$nj.cases,total$nj.deaths,total$usa.cases,total$usa.deaths,total$readability,total$sentiment,total$wordCount,total$NumPressRelease,total$NumNewsStories,matrixnew)
colnames(matrixnew)<-c("tsdate","twittersentiment","DEcases","DEdeaths","MDcases","MDdeaths","NJcases","NJdeaths","USAcases","USAdeaths","readability","sentiment","wordcount","pressrelasecount","newsstorycount",dtm.corpus[[6]]$Terms)

#save dataset
write.csv(matrixnew,"DTMbyDay.csv",row.names=FALSE)

