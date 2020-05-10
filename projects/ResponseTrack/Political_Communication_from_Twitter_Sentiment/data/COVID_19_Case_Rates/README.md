
COVID-19 Case Rates by US State.

Obtained from here https://github.com/nytimes/covid-19-data/blob/master/us-states.csv

Schema: First column: date, Second column: state, Third column: state FIPS Code, Fourth column: case rates, Fifth column: death rates

(January 21, 2020 - May 07, 2020)

Main file name:

CaseCounts (file size: 114 KB)

Scraped from here: 

Load data into R and subset to DE cases:
```
casecounts<-read.csv("CaseCounts.csv",header=TRUE)

casecounts.de<-subset(casecounts,casecounts$state=="Delaware")

```