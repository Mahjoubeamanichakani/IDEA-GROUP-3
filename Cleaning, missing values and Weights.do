************************************************************************
************************************************************************
* AUTHOR: Mahjoube AmaniChakani
* DATE: Feb, 2025
* FUNCTION: employment outcomes of immigrants and vissible minorities
* INPUT DATA: Canadian Census (2021)
************************************************************************
************************************************************************




clear
clear matrix


import delimited "...", clear
/************
Data Cleaning
 ***********/

 *** Main Variables & Derived Variebles***
 
 
****Immigration status ( from raw data-no need to change)
tab immstat,m
*Drop missing data on Immigration status
drop if immstat==.

****Employment Status (derived variable)
gen employed = .
replace employed = 1 if lfact == 1 | lfact == 2  
replace employed = 0 if inlist(lfact, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14) 

label define employed_lbl 0 "Unemployed" 1 "Employed"
label values employed employed_lbl
ta employed,m

*Drop missing data on Employment Status
drop if employed==.

****Employed part-time or temporary jobs as underemployed(derived variable)

gen underemployed = .
replace underemployed = 1 if fptwk == 2  
replace underemployed = 1 if jobperm == 3  
replace underemployed = 0 if fptwk == 1 & jobperm == 2   

label define underemployed_lbl 0 "Fully Employed" 1 "Underemployed"
label values underemployed underemployed_lbl
ta underemployed

*Drop missing data on underemployed

drop if underemployed==.

****Binary: White vs. Non-White(derived variable)
gen non_white = .
replace non_white = 0 if dpgrsum == 1  
replace non_white = 1 if inlist(dpgrsum, 2,3,4,5,6,7,8,9,10,11,12,13) 

label define non_white_lbl 0 "White" 1 "Non-White"
label values non_white non_white_lbl
ta non_white,m

*Drop missing data on Race

drop if non_white==.

****Language Proficiency Indicator( from raw data-no need to change)
tab kol,m

*Drop missing data on Language
drop if kol==.

*or(derived variable)
gen lang_proficient = .
replace lang_proficient = 1 if inlist(kol, 1, 2, 3) // Speaks English or French
replace lang_proficient = 0 if kol == 4  // Neither English nor French

label define lang_proficient_lbl 0 "Not Proficient" 1 "Proficient"
label values lang_proficient lang_proficient_lbl

*Drop missing data on Language Binary
drop if lang_proficient==.


****Education Level( from raw data-no need to change)
tab hdgree,m

*Drop missing data on hdgree
drop if hdgree==.


*or(derived variable)

gen uni_educated = .
replace uni_educated = 1 if inlist(hdgree, 9, 10, 11, 12, 13) // Bachelor's or higher
replace uni_educated = 0 if inlist(hdgree, 1,2,3,4,5,6,7,8) // No university degree

label define uni_educated_lbl 0 "No University Degree" 1 "University Degree"
label values uni_educated uni_educated_lbl
ta uni_educated

*Drop missing data on uni_educated
drop if uni_educated==.

****Provinces( from raw data-no need to change)
tab pr,m

*Drop missing data on Provinces
drop if pr==.

****Keep only relevant working-age groups (15-69 years)
tab agegrp,m

*Drop missing data on age group
drop if agegrp==.

****Binary Visible Minority Indicator(derived variable)

gen visible_minority = .
replace visible_minority = 1 if inlist(vismin, 2,3,4,5,6,7,8,9,10,11,12,13) 
replace visible_minority = 0 if vismin == 1  

label define visible_minority_lbl 0 "Not Visible Minority" 1 "Visible Minority"
label values visible_minority visible_minority_lbl

ta visible_minority,m

*Drop missing data on visible minority
drop if visible_minority==.

*or in detail( from raw data-no need to change)
tab vismin,m
*Drop missing data on vismin
drop if vismin==.

*sex at birth( from raw data-no need to change)
tab gender,m
*Drop missing data on gender
drop if gender==.

* Set survey weights 
svyset [pw=weight]

svy: proportion employed immstat gender visible_minority agegrp pr uni_educated lang_proficient



save "....dta", replace

