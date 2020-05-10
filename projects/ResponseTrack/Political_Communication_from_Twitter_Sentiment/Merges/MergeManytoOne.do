 clear
 import delimited "Daily.csv"
 sort date
 save "Daily.dta", replace
 
 import delimited "Twitter.csv", clear
 sort date
 merge date using "Daily.dta"
 drop if _merge==2
 drop _merge
 
 export delimited using "DTMbyTweet.csv", replace
