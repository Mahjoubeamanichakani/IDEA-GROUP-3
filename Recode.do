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

/**********************************************
Insert your own data direction instead of (...)
***********************************************/

cd "..."

/*raw data file */
local dat_name ".../data_donnees_2021_ind.dat"

/* output '.dta' file */
local dta_name ".../ipumf_2021_final_en.dta"

/* The data dictionary file */
local dct_name ".../ipumf_2021_final_en.dct"

infile using "`dct_name'", using("`dat_name'") clear 

*/ keep relevant variables: from 141 to 44 variable
keep vismin pr pob noc21 lwmostno lwmostfr lwmosten liprogtype lico_at lico_bt lfact kol jobperm immstat immcat5 hlregno hlregfr hlregen hlmostno hlmostfr hlmosten hdgree genstat gender fptwk fol ethder dpgrsum citizen citoth cow cfstat attsch ageimm agegrp weight


**Age groups 
label define agegrp 1 "0 to 4 years" 2 "5 to 6 years" 3 "7 to 9 years" 4 "10 to 11 years" 5 "12 to 14 years" 6 "15 to 17 years" 7 "18 to 19 years" 8 "20 to 24 years" 9 "25 to 29 years" 10 "30 to 34 years" 11 "35 to 39 years" 12 "40 to 44 years" 13 "45 to 49 years" 14 "50 to 54 years" 15 "55 to 59 years" 16 "60 to 64 years" 17 "65 to 69 years" 18 "70 to 74 years" 19 "75 to 79 years" 20 "80 to 84 years" 21 "85 years and over" 88 "Not available"


*Recode missing values
recode 	agegrp (88=.)

* Keep only relevant working-age groups (15-69 years)
drop if agegrp < 6 | agegrp > 17

* Verify that only the selected age groups remain
tab agegrp

	
*Age groups at time of immigration
label define ageimm 1 "0 to 4 years" 2 "5 to 9 years" 3 "10 to 14 years" 4 "15 to 19 years" 5 "20 to 24 years" 6 "25 to 29 years" 7 "30 to 34 years" 8 "35 to 39 years" 9 "40 to 44 years" 10 "45 to 49 years" 11 "50 to 54 years" 12 "55 to 59 years" 13 "60 years and over" 88 "Not available" 99 "Not applicable"


recode ageimm (88 99=.)
	
	
*Education: School attendance - Detailed	
 label define attsch 1 "Did not attend school" 2 "Elementary or secondary school" 3 "College, CEGEP, trade school or other non-university institution" 4 "University" 5 "Multiple responses" 8 "Not available" 9 "Not applicable"


recode attsch (8 9=.)


	
*Household living arrangements of person, simple version
 label define cfstat 
    label define cfstat 1 "Married spouse or common-law partner without children" 2 "Married spouse or common-law partner with children" 3 "Parent in a one-parent family" 4 "Child of a couple" 5 "Child of a parent in a one-parent family" 6 "Person living alone" 7 "Person not in a census family living with non-relatives only" 8 "Person not in a census family but living with other relatives"

recode cfstat(8=.)


*Labour: Class of worker (derived)
  label define cow 1 "Employee" 2 "Unpaid family worker" 3 "Self-employed, without paid help, incorporated" 4 "Self-employed, with paid help, incorporated" 5 "Self-employed, without paid help, unincorporated" 6 "Self-employed, with paid help, unincorporated" 8 "Not available" 9 "Not applicable"


recode cow (8 9 =.)
	
	
*Citizenship: Other country of citizenship
label define citoth 1 "United States" 2 "Other Americas" 3 "United Kingdom - British citizen" 4 "Other Europe" 5 "Africa" 6 "West Central Asia and the Middle East" 7 "China, People's Republic of" 8 "Other Eastern Asia" 9 "Philippines" 10 "Other Southeast Asia" 11 "India" 12 "Other Southern Asia" 13 "Oceania and other" 14 "Two other countries" 15 "No other country of citizenship" 88 "Not available"

recode citoth ( 14 15 88=.)
 
 *Citizenship
 label define citizen 1 "Canadian citizens by birth" 2 "Canadian citizens by naturalization" 3 "Not a Canadian citizen"
	

*Population group
label define dpgrsum 1 "White" 2 "South Asian" 3 "Chinese" 4 "Black" 5 "Filipino" 6 "Arab" 7 "Latin American" 8 "Southeast Asian" 9 "West Asian" 10 "Korean" 11 "Japanese" 12 "Other population groups, n.i.e." 13 "Other multiple population groups" 14 "Indigenous peoples" 88 "Not available"

recode dpgrsum (88=.)

	
	
*Ethnic or cultural origin: Derived single and selected multiple ethnic or cultural origins
 label define ethder 1 "North American Indigenous origins" 2 "Acadian" 3 "Canadian" 4 "French Canadian" 5 "Québécois" 6 "Other North American origins" 7 "English" 8 "Irish" 9 "Scottish" 10 "Other British Isles origins" 11 "French origins" 12 "Dutch" 13 "German" 14 "Other Western European origins" 15 "Other Northern European origins" 16 "Greek" 17 "Italian" 18 "Portuguese" 19 "Other Southern European origins" 20 "Romanian" 21 "Other Southeast European origins" 22 "Hungarian" 23 "Polish" 24 "Russian" 25 "Ukrainian" 26 "Other Eastern European origins" 27 "Other European origins" 28 "Haitian" 29 "Jamaican" 30 "Other Caribbean origins" 31 "Mexican" 32 "Other Latin, Central and South American origins" 33 "Central and West African origins" 34 "North African origins" 35 "Southern and East African origins" 36 "Other African origins" 37 "Afghan" 38 "Iranian" 39 "Lebanese" 40 "Other West and Central Asian and Middle Eastern origins" 41 "Indian (India)" 42 "Pakistani" 43 "Punjabi" 44 "Sri Lankan" 45 "Other South Asian origins" 46 "Chinese" 47 "Filipino" 48 "Korean" 49 "Vietnamese" 50 "East and Southeast Asian origins, n.i.e." 51 "Other Asian origins" 52 "Arab, n.o.s." 53 "Caucasian (White), n.o.s." 54 "Christian, n.i.e." 55 "Hindu" 56 "Jewish" 57 "Sikh" 58 "Other ethnic and cultural origins" 59 "Multiple ethnic or cultural origins" 88 "Not available"


recode ethder (88=.)


*Language: First official language spoken
label define fol 1 "English" 2 "French" 3 "English and French" 4 "Neither English nor French"

	
*Full-time or part-time weeks worked in 2020
 label define fptwk 1 "Worked mainly full-time weeks in 2020" 2 "Worked mainly part-time weeks in 2020" 8 "Not available" 9 "Not applicable"

	
recode fptwk ( 8 9 =.)

*sex at birth
 label define gender 
    1 "woman+" 2 "man+"

	*"Generation status" refers to whether or not the person or the person's parents were born in Canada.
label define genstat 1 "First generation, respondent born outside Canada" 2 "Second generation, respondent born in Canada, both parents born outside Canada" 3 "Second generation, respondent born in Canada, one parent born outside Canada and one parent born in Canada" 4 "Third generation or more, respondent born in Canada, both parents born in Canada" 8 "Not available"

	
recode genstat (8=.)

*Education: Highest certificate, diploma or degree
label define hdgree 1 "No certificate, diploma or degree" 2 "High (secondary) school diploma or equivalency certificate" 3 "Non-apprenticeship trades certificate or diploma" 4 "Apprenticeship certificate" 5 "Program of 3 months to less than 1 year (college, CEGEP and other non-university certificates or diplomas)" 6 "Program of 1 to 2 years (college, CEGEP and other non-university certificates or diplomas)" 7 "Program of more than 2 years (college, CEGEP and other non-university certificates or diplomas)" 8 "University certificate or diploma below bachelor level" 9 "Bachelor's degree" 10 "University certificate or diploma above bachelor level" 11 "Degree in medicine, dentistry, veterinary medicine or optometry" 12 "Master's degree" 13 "Earned doctorate" 88 "Not available" 99 "Not applicable"

recode hdgree ( 88 99 = .)

*Language spoken most often at home - English
label define hlmosten 0 "False - respondent did not report English as the language spoken most often at home" 1 "True - respondent reported English as the language spoken most often at home" 8 "Not available"

recode hlmosten (8=.)
	
	
*Language spoken most often at home - French
label define hlmostfr 0 "False - respondent did not report French as the language spoken most often at home" 1 "True - respondent reported French as the language spoken most often at home" 8 "Not available"

recode hlmostfr (8=.)
	
*Language: Language spoken most often at home
label define hlmostno 1 "No non-official language" 2 "Indigenous languages" 3 "Italian" 4 "Spanish" 5 "Portuguese" 6 "German" 7 "Russian" 8 "Polish" 9 "Slavic languages" 10 "Other European languages" 11 "Arabic" 12 "Other Afro-Asiatic and African languages" 13 "Punjabi (Panjabi)" 14 "Urdu" 15 "Persian (Farsi)" 16 "Other Indo-Iranian languages" 17 "Cantonese" 18 "Mandarin" 19 "Chinese languages" 20 "Austro-Asiatic languages" 21 "Tagalog (Pilipino, Filipino)" 22 "Other East and Southeast Asian languages" 23 "Tamil" 24 "All other languages" 88 "Not available"

recode hlmostno (8=.)
	
*Language: Other language(s) spoken regularly at home english
label define hlregen 0 "False - respondent did not report English as the other language spoken at home on a regular basis" 1 "True - respondent reported English as the other language spoken at home on a regular basis" 8 "Not available"

recode hlregen (8=.)

*language: Other language(s) spoken regularly at home french
label define hlregfr 0 "False - respondent did not report French as the other language spoken at home on a regular basis" 1 "True - respondent reported French as the other language spoken at home on a regular basis" 8 "Not available"

	
recode hlregfr(8=.)
	
	
*Language: Other language(s) spoken regularly at home others
label define hlregno 0 "False - respondent did not report a non-official language as the language spoken at home on a regular basis" 1 "True - respondent reported a non-official language as the language spoken at home on a regular basis"


	
/*Immigration: Admission category - Summary
This variable provides a summary of admission categories for immigrants who were
admitted to Canada between January 1st, 1980 and May 11th, 2021.
"Admission category" refers to the name of the immigration program or group of programs
under which an immigrant has been granted for the first time the right to live in Canada
permanently by immigration authorities.*/

label define immcat5 1 "Non-immigrants" 2 "Non-permanent residents" 3 "Immigrants who landed before 1980" 21 "Economic immigrants" 22 "Immigrants sponsored by family and other immigrants" 23 "Refugees" 88 "Not available"

recode immcat5 ( 88 = .)
	
	/*"Immigrant status" refers to whether the person is a non-immigrant, an immigrant or a nonpermanent
resident.
In 2021, for the first time, immigrant status was obtained from administrative files provided
by Immigration, Refugees and Citizenship Canada (IRCC) through record linkage.
"Non-immigrant" includes persons who are Canadian citizens by birth.*/

 label define immstat 1 "non-immigrants" 2 "immigrants" 3 "non-permanent residents" 88 "not available"
	
recode immstat (88=.)

/*Labour: Job permanency:	Job permanency refers to the classification of paid jobs as either permanent or temporary
for persons aged 15 years and over in private households that were paid employees.*/
label define jobperm 1 "Other employment - unpaid, self-employed" 2 "Employee - permanent position" 3 "Employee - fixed term (1 year or more) / casual, seasonal or short-term position (less than 1 year)" 8 "Not available" 9 "Not applicable"

	
recode jobperm (8 9 = .)

*Language: Knowledge of official languages
label define kol 1 "English only" 2 "French only" 3 "English and French" 4 "Neither English nor French" 8 "Not available"


recode kol (8=.)

*Labour: Labour force status - Detailed
label define lfact 1 "Employed - Worked in reference week" 2 "Employed - Absent in reference week" 3 "Unemployed - Temporary layoff - Did not look for work" 4 "Unemployed - Temporary layoff - Looked for full-time work" 5 "Unemployed - Temporary layoff - Looked for part-time work" 6 "Unemployed - New job - Did not look for work" 7 "Unemployed - New job - Looked for full-time work" 8 "Unemployed - New job - Looked for part-time work" 9 "Unemployed - Looked for full-time work" 10 "Unemployed - Looked for part-time work" 11 "Not in the labour force - Last worked in 2021" 12 "Not in the labour force - Last worked in 2020" 13 "Not in the labour force - Last worked before 2020" 14 "Not in the labour force - Never worked" 88 "Not available" 99 "Not applicable"


recode lfact (88 99 = .)
	
	/*Income: Low-income status based on LICO-BT
	Refers to the income situation of a person in relation to the Low-income cut-offs, before-tax
(LICO-BT). Persons with income that is below this low-income line are considered to be in
low income.
The value 9 stands for not applicable and is applied to those living in areas where this lowincome
concept is not applicable, (i.e. the territories).*/

label define lico_bt 1 "Not in low income" 2 "In low income" 8 "Not available" 9 "Not applicable"

recode lico_bt(8 9 =.)
	
	/*Income: Low-income status based on LICO-AT
	Refers to the income situation of a person in relation to the Low-income cut-offs, after-tax
(LICO-AT). Persons with income that is below this low-income line are considered to be in
low income.*/

label define lico_at 1 "Not in low income" 2 "In low income" 8 "Not available" 9 "Not applicable"

recode lico_at (8 9 =.)

*Language: Type of French program attended in Canada by residents of Canada outside Quebec	
label define liprogtype 1 "Residents of Canada outside Quebec who attended a regular French program in a French-language school at the primary or secondary levels in Canada" 2 "Residents of Canada outside Quebec who attended a French immersion program in an English-language school at the primary or secondary levels in Canada" 3 "Residents of Canada outside Quebec who attended both types of programs in Canada" 4 "Residents of Canada outside Quebec who did not attend a regular French program in a French-language school or a French immersion program in Canada" 9 "Not applicable"

recode liprogtype (9=.)

*Language: Language used most often at work - English
label define lwmosten 0 "False - respondent did not report English as the language used most often at work" 1 "True - respondent reported English as the language used most often at work" 8 "Not available" 9 "Not applicable"

recode lwmosten (9=.)	
	
*Language: Language used most often at work - french
label define lwmostfr 0 "False - respondent did not report French as the language used most often at work" 1 "True - respondent reported French as the language used most often at work" 8 "Not available" 9 "Not applicable"


recode lwmostfr (8 9 =.)
	
*Language: Language used most often at work - other
label define lwmostno 0 "False - respondent did not report a non-official language as the language used most often at work" 1 "True - respondent reported a non-official language as the language used most often at work" 9 "Not applicable"


recode lwmostno (8 9 =.)

*Labour: Occupation Major Group (based on the National Occupational Classification [NOC] 2021 version 1.0)
label define noc21 1 "00 Legislative and senior managers" 2 "Middle management occupations" 3 "11 Professional occupations in business and finance" 4 "12 Administrative and financial supervisors and specialized administrative occupations" 5 "13 Administrative occupations and transportation logistics occupations" 6 "14 Administrative and financial support and supply chain logistics occupations" 7 "21 Professional occupations in natural and applied sciences" 8 "22 Technical occupations related to natural and applied sciences" 9 "31 Professional occupations in health" 10 "32 Technical occupations in health" 11 "33 Assisting occupations in support of health services" 12 "41 Professional occupations in law, education, social, community and government services" 13 "42 Front-line public protection services and paraprofessional occupations in legal, social community, education services" 14 "43-45 Assisting occupations, care providers, student monitors, crossing guards and related occupations in education and in legal and public protection" 15 "51-52 Professional and technical occupations in art, culture and sport" 16 "53-55 Other occupations in art, culture and sport" 17 "62 Retail sales and service supervisors and specialized occupations in sales and services" 18 "63 Occupations in sales and services" 19 "64 Sales and service representatives and other customer and personal services occupations" 20 "65 Sales and service support occupations" 21 "72 Technical trades and transportation officers and controllers" 22 "73 General trades" 23 "74 Mail and message distribution, other transport equipment operators and related maintenance workers" 24 "75 Helpers and labourers and other transport drivers, operators and labourers" 25 "82-85 Occupations in natural resources, agriculture and related production" 26 "92-95 Occupations in processing, manufacturing and utilities" 88 "Not available" 99 "Not applicable"


recode noc21 (88 99=. )

*Place of birth of person
label define pob 1 "Canada" 2 "United States" 3 "Central America" 4 "Jamaica" 5 "Other Caribbean and Bermuda" 6 "South America" 7 "United Kingdom" 8 "Germany" 9 "France" 10 "Other Northern and Western Europe" 11 "Poland" 12 "Other Eastern Europe" 13 "Italy" 14 "Portugal" 15 "Other Southern Europe" 16 "Eastern Africa" 17 "Northern Africa" 18 "Other Africa" 19 "Iran" 20 "Other West Central Asia and the Middle East" 21 "China" 22 "Hong Kong" 23 "South Korea" 24 "Other Eastern Asia" 25 "Philippines" 26 "Viet Nam" 27 "Other Southeast Asia" 28 "India" 29 "Pakistan" 30 "Sri Lanka" 31 "Other Southern Asia" 32 "Oceania and others" 88 "Not available"


 recode pob ( 88=.)
 
*Province or territory of current residence (2021)
label define pr 10 "Newfoundland and Labrador" 11 "Prince Edward Island" 12 "Nova Scotia" 13 "New Brunswick" 24 "Quebec" 35 "Ontario" 46 "Manitoba" 47 "Saskatchewan" 48 "Alberta" 59 "British Columbia" 70 "Northern Canada"


/*Visible minority
"Visible minority" refers to whether a person is a visible minority or not, as defined by the
Employment Equity Act. The Employment Equity Act defines visible minorities as "persons,
other than Aboriginal peoples, who are non-Caucasian in race or non-white in colour." The
visible minority population consists mainly of the following groups: South Asian, Chinese,
Black, Filipino, Arab, Latin American, Southeast Asian, West Asian, Korean and Japanese.
For more information on visible minority variables, including information on their
classifications, the questions from which they are derived, data quality and their
comparability with other sources of data, please refer to the Visible Minority and Population
Group Reference Guide, Census of Population, 2021.*/

label define vismin 1 "Not a visible minority" 2 "South Asian" 3 "Chinese" 4 "Black" 5 "Filipino" 6 "Arab" 7 "Latin American" 8 "Southeast Asian" 9 "West Asian" 10 "Korean" 11 "Japanese" 12 "Visible minority, n.i.e." 13 "Multiple visible minorities" 88 "Not available"

recode vismin ( 88=.)

 label values aboid aboid 
 label values agegrp agegrp
 label values ageimm ageimm
 label values attsch attsch
 label values bfnmemb bfnmemb
 label values bedrm bedrm
 label values cfinc cfinc
 label values cfinc_at cfinc_at
 label values cfstat cfstat
 label values cip2021 cip2021
 label values cip2021_stem_sum cip2021_stem_sum
 label values cma cma
 label values condo condo
 label values cow cow
 label values cfsize cfsize
 label values citoth citoth
 label values citizen citizen
 label values dist dist
 label values dpgrsum dpgrsum
 label values dtype dtype
 label values efdecile efdecile
 label values efinc efinc
 label values efinc_at efinc_at
 label values ethder ethder
 label values efdimbm_2018 efdimbm_2018
 label values efsize efsize
 label values fol fol
 label values fptwk fptwk
 label values gender gender
 label values genstat genstat
 label values hcoreneed_ind hcoreneed_ind
 label values hdgree hdgree
 label values hhinc hhinc
 label values hhinc_at hhinc_at
 label values hhmrkinc hhmrkinc
 label values hhsize hhsize
 label values hhtype hhtype
 label values hlmosten hlmosten
 label values hlmostfr hlmostfr
 label values hlmostno hlmostno
 label values hlregen hlregen
 label values hlregfr hlregfr
 label values hlregno hlregno
 label values immcat5 immcat5
 label values immstat immstat
 label values jobperm jobperm
 label values kol kol
 label values lfact lfact
 label values lico_bt lico_bt
 label values lico_at lico_at
 label values liprogtype liprogtype
 label values li_elig_oml_u18 li_elig_oml_u18
 label values locstud locstud
 label values loc_st_res loc_st_res
 label values lstwrk lstwrk
 label values lwmosten lwmosten
 label values lwmostfr lwmostfr
 label values lwmostno lwmostno
 label values lwregen lwregen
 label values lwregfr lwregfr
 label values lwregno lwregno
 label values lolima lolima
 label values lolimb lolimb
 label values lombm_2018 lombm_2018
 label values mode mode
 label values mtnen mtnen
 label values mtnfr mtnfr
 label values mtnno mtnno
 label values marsth marsth
 label values mob1 mob1
 label values mob5 mob5
 label values naics naics
 label values noc21 noc21
 label values nol nol
 label values nos nos
 label values pkid25 pkid25
 label values pkid0_1 pkid0_1
 label values pkid15_24 pkid15_24
 label values pkid2_5 pkid2_5
 label values pkid6_14 pkid6_14
 label values pkids pkids
 label values pob pob
 label values pobpar1 pobpar1
 label values pobpar2 pobpar2
 label values powst powst
 label values pr pr
 label values pr1 pr1
 label values pr5 pr5
 label values presmortg presmortg
 label values prihm prihm
 label values pwdur pwdur
 label values pwleave pwleave
 label values pwocc pwocc
 label values pwpr pwpr
 label values regind regind
 label values relig relig
 label values repair repair
 label values room room
 label values ssgrad ssgrad
 label values subsidy subsidy
 label values tenur tenur
 label values vismin vismin
 label values wkswrk wkswrk
 label values wrkact wrkact
 label values yrim yrim


******************************************
* Assign descriptive labels to variables
******************************************
label variable vismin "Visible minority status"
label variable pr "Province or territory of current residence"
label variable pob "Place of birth"
label variable noc21 "Occupation Major Group (based on NOC 2021)"
label variable lwmostno "Language used most often at work - First write-in component"
label variable lwmostfr "Language used most often at work - French component"
label variable lwmosten "Language used most often at work - English component"
label variable liprogtype "Type of French program attended in Canada by residents outside Quebec"
label variable lico_at "Low-income status based on Low-Income Cut-Offs (after-tax)"
label variable lico_bt "Low-income status based on Low-Income Cut-Offs (before-tax)"
label variable lfact "Labour force status - Detailed"
label variable kol "Knowledge of official languages"
label variable jobperm "Job permanency"
label variable immstat "Immigrant status"
label variable immcat5 "Admission category - Summary"
label variable hlregno "Other language(s) spoken regularly at home - First write-in component"
label variable hlregfr "Other language(s) spoken regularly at home - French component"
label variable hlregen "Other language(s) spoken regularly at home - English component"
label variable hlmostno "Language spoken most often at home - First write-in component"
label variable hlmostfr "Language spoken most often at home - French component"
label variable hlmosten "Language spoken most often at home - English component"
label variable hdgree "Highest certificate, diploma or degree"
label variable genstat "Generation status - Detailed"
label variable gender "Gender of person (binary)"
label variable fptwk "Full-time or part-time weeks worked in 2020"
label variable fol "First official language spoken"
*label variable efsize "Economic family size"
label variable ethder "Ethnic or cultural origin: Derived single and selected multiple ethnic or cultural origins"
label variable dpgrsum "Population group"
label variable citizen "Citizenship status and type - Summary"
label variable citoth "Other country of citizenship"
label variable cow "Class of worker (derived)"
label variable cfstat "Household living arrangements of person, simple version"
label variable attsch "School attendance - Detailed"
label variable ageimm "Age at immigration"
label variable agegrp "Age group"
label variable weight "Individuals weighting factor"



save `dta_name', replace
