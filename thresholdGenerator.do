

// purpose: creates ASPE HHS poverty thresholds

clear
set more off

// start off with just fipscodes for states
use fipsRaw 
duplicates drop gestfips, force

// set max household size
forvalues j = 1/8 {
ge hnm`j' = 1
}
reshape long hnm, i(gestfips) j(hiuNum)

// generate as many years
forvalues k = 2000/2017{
ge y`k' = 1
}
//add more years above of the form y'x' = real year
ge index= _n
reshape long y , i(index) j(year)



// Draw Default and Multipliers for by State by Year
ge default =.
ge multiplier=. 
do aspeDefinitions.do  // fetch key parameters from ASPE definitions

levelsof year, local (years)
foreach i of local years{
 replace default = def`i' if year==`i'
 replace default = al`i' if gestfips==2 & year==`i' // for alaska
 replace default = hi`i' if gestfips==15 & year==`i' // for hawai
 replace multiplier = def`i'm if year==`i'
 replace multiplier = al`i'm if gestfips==2 & year==`i'  // for alaska
 replace multiplier = hi`i'm if gestfips==15 & year==`i' // for hawai
}


// Create Poverty Thresholds 
ge povThres = default if hiuNum <2 
replace povThres = default + (hiuNum-1)*multiplier

// 2016 issue: https://aspe.hhs.gov/computations-2016-poverty-guidelines
ge multi16 =4160 if year==2016
replace multi16 = 5200 if (year ==2016 & gestfips==2) //alaska
replace multi16 = 4780 if (year==2016 & gestfips==15) // hawaii

replace povThres = default + (hiuNum-1)*multi16 if year==2016

drop hnm y index
// output 

save povThres_2000_2017, replace
