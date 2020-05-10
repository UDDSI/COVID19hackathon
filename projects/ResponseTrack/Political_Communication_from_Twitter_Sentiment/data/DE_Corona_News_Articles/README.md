
Government of DE News Releases Tagged with "Coronavirus".

Scraped using ScrapeDENewsReleases.R

Schema: First column: title of press release, Second-Fourth colums: publisher tags, Fifth column: date, Sixth column: news article text

(February 2, 2020 - May 07, 2020)

195 total news entries (one has no text because it only contained a video)

Main file name:

coronanews.delaware.gov.csv (file size: 717 KB)

Scraped from here (and related pages, 1-39): 

https://news.delaware.gov/tag/coronavirus/page/2/

Note 1: These data will have duplicates with DE Press Releases data

Note 2: The missing text-entry (based on only containing video) has been machine transcribed and appears separately as "Transcribed.txt"

Load data into R:
```
news<-read.csv("coronanews.delaware.gov.csv",header=TRUE)

head(news, n=10)
```