
Delaware Health and Human Services Press Releases

Schema: First column: title of press release, Second-Fourth columns: publisher meta-data, Fifth column: date, Sixth column: press release text

(January 27, 2020 - May 06, 2020)

89 total press releases (one release had a 404 error and is omitted)

Main file name:

corona.pressrelease.de.gov (file size: 415 KB)

Scraped from here: 

https://www.dhss.delaware.gov/dhss/pressreleases/pressrel.html

Note: These data will have duplicates with DE Corona News Articles data

Load data into R:
```
pressrelease<-read.csv("corona.pressrelease.de.gov.csv",header=TRUE)

head(pressrelease, n=10)
```