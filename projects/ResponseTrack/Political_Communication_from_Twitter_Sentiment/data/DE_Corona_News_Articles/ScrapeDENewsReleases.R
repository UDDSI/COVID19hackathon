###
###Scrape Delaware Health Communications
###5/07/2020
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

#set seed
set.seed(50)

#set working directory
setwd("/.../")

################
####Scraping####
################

#loop through all pages
all.pages<-NULL
for(j in 1:39){

#download initial html page
url<-paste("https://news.delaware.gov/tag/coronavirus/page/",j,"/",sep="")
outfile <- paste("front",".txt",sep="")
download.file(url,outfile, encoding = "UTF-8")

#Read in main file
text.raw<-c(paste(readLines(file("front.txt"), encoding = "UTF-8"),collapse=" "))

#subset current page's links
main.content<- unlist(strsplit(text.raw, '<div id="main_content"><br />'))
main.content<-main.content[3]
main.content<- unlist(strsplit(main.content, '</i>&nbsp;Pages Tagged With: "Coronavirus"</strong></div>'))
main.content<-main.content[2]
main.content<- unlist(strsplit(main.content, '<div class="pdfprnt-buttons pdfprnt-buttons-archive pdfprnt-bottom-right">'))
main.content<-main.content[1]
main.content<- unlist(strsplit(main.content, '<h3><a href="'))
main.content<-main.content[2:length(main.content)]
main.content<-gsub("\">.*","",main.content)

page.store<-NULL
for(i in 1:length(main.content)){

#download story html page
url<-main.content[i]
outfile <- paste("front",".txt",sep="")
download.file(url,outfile, encoding = "UTF-8")

#Read in main file
text.raw<-c(paste(readLines(file("front.txt"), encoding = "UTF-8"),collapse=" "))

#Extract title
title<- unlist(strsplit(text.raw, "<title>"))
title<-title[2]
title<- unlist(strsplit(title, "</title>"))
title<-title[1]

#Extract tagone
topic<- unlist(strsplit(text.raw, '<div class="container-fluid" id="main_header">'))
topic<-topic[1]
topic<- unlist(strsplit(topic, '<div class="container" id="main_header">'))
topic<-topic[2]
topic<- unlist(strsplit(topic, '<a href='))
topic<-topic[2]
topic<- unlist(strsplit(topic, "<br /></p>"))
topic<-topic[1]
topic<- unlist(strsplit(topic, ">"))
topic<-topic[2]
topic<- unlist(strsplit(topic, "<"))
topic<-topic[1]
topic<-gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)","",topic)

#Extract tagtwo
type<- unlist(strsplit(text.raw, '<div class="container-fluid" id="main_header">'))
type<-type[1]
type<- unlist(strsplit(type, '<div class="container" id="main_header">'))
type<-type[2]
type<- unlist(strsplit(type, '<a href='))
type<-type[3]
type<- unlist(strsplit(type, "<br /></p>"))
type<-type[1]
type<- unlist(strsplit(type, ">"))
type<-type[2]
type<- unlist(strsplit(type, "<"))
type<-type[1] 
type<-gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)","",type)
type<-gsub("302-761-8446","",type)

#Extract date
date<- unlist(strsplit(text.raw, '<div class="container-fluid" id="main_header">'))
date<-date[1]
date<- unlist(strsplit(date, '<div class="container" id="main_header">'))
date<-date[2]
date<- unlist(strsplit(date, '<a href='))
flag<-grep("Date Posted: ", date)
date<-date[grep("Date Posted: ", date)]
date<- unlist(strsplit(date, "<br /></p>"))
date<-date[1]
date<- unlist(strsplit(date, "Date Posted: "))
date<-date[2]

#Extract tagthree
if (flag>3) {
type.2<- unlist(strsplit(text.raw, '<div class="container-fluid" id="main_header">'))
type.2<-type.2[1]
type.2<- unlist(strsplit(type.2, '<div class="container" id="main_header">'))
type.2<-type.2[2]
type.2<- unlist(strsplit(type.2, '<a href='))
type.2<-type.2[4]
type.2<- unlist(strsplit(type.2, "<br /></p>"))
type.2<-type.2[1]
type.2<- unlist(strsplit(type.2, ">"))
type.2<-type.2[2]
type.2<- unlist(strsplit(type.2, "<"))
type.2<-type.2[1] 
type.2<-gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)","",type.2)
} else {type.2<-""}

#Extract text
text<- unlist(strsplit(text.raw, '<div id="main_content">'))
text<-text[2]
text<-paste(text, collapse=" ")
text<- unlist(strsplit(text, '<div class="pdfprnt-buttons'))
text<-text[1]
text<-paste(text,collapse=" ")
text<-gsub("<(.|\n)*?>","",text)
text<-HTMLdecode(text)
text<-trimws(text, which ="both")
text<-gsub("<U+202F>"," ",text)
text<-gsub("<U+200B>","",text)

##Combine##
entry<-cbind(title,topic,type,type.2,date,text)
entry<-as.data.frame(entry)
colnames(entry)<-c("title","tagone","tagtwo","tagthree","date","text")
page.store<-rbind(page.store,entry)
Sys.sleep(2)
}
all.pages<-rbind(all.pages,page.store)

}

#Write final dataset
write.csv(all.pages,"coronanews.delaware.gov.csv",row.names=FALSE)

#The End
#
