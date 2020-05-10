
Scripts used to merge, deduplicate, and aggregate the data used during the 5/8 Hackathon.


The CombineDE.Texts.R script aggregates all data to the DE-day level. It relies upon the following datasets:

i) The US-state specific COVID-19 case rates in: CaseCounts.csv

ii) The formatted DE-specific tweets in: Kaggle-cvoid-19-twitter-delaware.csv

iii) The DE News Release texts in: coronanews.delaware.gov and Transcribed.txt

iv) The DE Press Release texts in corona.pressrelease.de.gov

It Produces the output file: DTMbyDay.csv (N=103)


The CombineDE.Texts.Tweet.R script and MergeManytoOne.do script aggregate all data to the Tweet-day level for assumed DE-specific tweets. 

It relies upon the following datasets:

i) The US-state specific COVID-19 case rates in: CaseCounts.csv

ii) The formatted DE-specific tweets in: Kaggle-cvoid-19-twitter-delaware.csv

iii) The DE News Release texts in: coronanews.delaware.gov and Transcribed.txt

iv) The DE Press Release texts in corona.pressrelease.de.gov

It Produces the output file: DTMbyTweet.csv (N=3259)
