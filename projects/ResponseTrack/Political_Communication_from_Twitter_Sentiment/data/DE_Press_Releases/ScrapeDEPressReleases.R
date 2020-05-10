###
###Scrape Delaware Health Press Releases
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

#download initial html page
url<-"https://www.dhss.delaware.gov/dhss/pressreleases/pressrel.html"
outfile <- paste("frontpress",".txt",sep="")
download.file(url,outfile, encoding = "UTF-8")

#Read in main file
text.raw<-c(paste(readLines(file("frontpress.txt"), encoding = "UTF-8"),collapse=" "))

#subset current page's links
main.content<- unlist(strsplit(text.raw, '<h1 class="smallh1">Press Releases 2020</h1>'))
main.content<-main.content[2]
main.content<- unlist(strsplit(main.content, '<p>  Other Years: '))
main.content<-main.content[1]
main.content<- unlist(strsplit(main.content, '<a href="'))
main.content<-main.content[2:length(main.content)]
main.content<-gsub("\" .*","",main.content)
main.content<-gsub(" ","",main.content)

#loop through each link
page.store<-NULL
for(i in 1:length(main.content)){

#download story html page
url<-paste("https://www.dhss.delaware.gov",main.content[i],sep="")
outfile <- paste("frontpress",".txt",sep="")
download.file(url,outfile, encoding = "UTF-8")

#Read in main file
text.raw<-c(paste(readLines(file("frontpress.txt"), encoding = "UTF-8"),collapse=" "))

#Extract title
title<- gsub("<h2><h2>","<h2>",text.raw)
title<- unlist(strsplit(title, "<h2>"))
title<-title[2]
title<- unlist(strsplit(title, "</h2>"))
title<-title[1]

#Extract tagone
topic<- unlist(strsplit(text.raw, 'CONTENT="'))
topic<-topic[2]
topic<- unlist(strsplit(topic, '">'))
topic<-topic[1]
topic<-gsub("January, 2020, ","",topic)

#Extract tagtwo
type<- unlist(strsplit(text.raw, '<meta name="author" content="'))
type<-type[2]
type<- unlist(strsplit(type, '">'))
type<-type[1]

#Extract tagthree
type.2<- unlist(strsplit(text.raw, '<title> '))
type.2<-type.2[2]
type.2<- unlist(strsplit(type.2, ' </title>'))
type.2<-type.2[1]

#Extract date
date<-gsub('<span class="b">Date:</span>January 7, 2019<br>','<span class="b">Date:</span> January 7, 2019<br>',text.raw)
date<- unlist(strsplit(date, '<span class="b">Date:</span> '))
date<-date[2]
date<- unlist(strsplit(date, '<br>'))
date<-date[1]

#Extract text
text<-gsub('<p><I>','<p><strong>',text.raw)
text<-gsub('<P><strong>','<p><strong>',text)
text<-gsub('<th class="faq" scope="row">','<p><strong>',text)
text<-gsub('DPH PROVIDING UPDATE ON INDIVIDUALS BEING TESTED','<p><strong>',text)
text<-gsub('DOVER (March 13, 2020)','<p><strong>DOVER (March 13, 2020)',text)
text<-gsub('<h2>DPH ANNOUNCES TWO NEGATIVE TEST RESULTS FOR CORONAVIRUS</h2>','<p><strong>',text)
text<-gsub('<h2>DELAWARE MONITORING RETURNING TRAVELERS FROM CHINA FOR 2019 NOVEL CORONAVIRUS </h2>','<p><strong>',text)
text<-gsub('DPH ANNOUNCES SEVENTEEN ADDITIONAL POSITIVE CASES','<p><strong>',text)
text<-gsub('DPH ANNOUNCES ELEVEN ADDITIONAL POSITIVE CASES','<p><strong>',text)
text<-gsub('<p><strong></h2>     <br>       <p><strong>     ','<p><strong>',text)
text<- unlist(strsplit(text, '<p><strong>'))
text<-text[2]
text<- unlist(strsplit(text, '</div><!-- /main_content -->'))
text<-text[1]
text<-gsub("<(.|\n)*?>","",text)
text<-HTMLdecode(text)
text<-trimws(text, which ="both")
text<-gsub("<U+202F>"," ",text)
text<-gsub("\t","",text)


##Combine##
entry<-cbind(title,topic,type,type.2,date,text)
entry<-as.data.frame(entry)
colnames(entry)<-c("title","tagone","tagtwo","tagthree","date","text")
page.store<-rbind(page.store,entry)
Sys.sleep(3)
}

#remove one missing page entry
page.store.2<-subset(page.store,page.store$tagone!="dhss, 404, page not found")

#remove january stories
page.store.3<-subset(page.store.2,!grepl("January",page.store$date))

#Write final dataset
write.csv(page.store.3,"corona.pressrelease.de.gov.csv",row.names=FALSE)

#The End
#
