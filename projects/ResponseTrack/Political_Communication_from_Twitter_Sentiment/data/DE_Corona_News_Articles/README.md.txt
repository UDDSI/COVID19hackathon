
Government of DE News Releases Tagged with "Coronavirus"

Schema: First column: title of press release, Second-Fourth colums: publisher tags, Fifth column: date, Sixth column: news article text

(Feburary 2, 2020 - May 07, 2020)

195 total news entries (one has no text because it only contained a video)

Main file name:

coronanews.delaware.gov.csv (file size: 717 KB)

Scraped from here (and related pages, 1-39): 

https://news.delaware.gov/tag/coronavirus/page/2/

Note: These data will have duplicates with DE Press Releases data

Load data into R:
```
news<-read.csv("coronanews.delaware.gov.csv",header=TRUE)

head(news, n=10)
```