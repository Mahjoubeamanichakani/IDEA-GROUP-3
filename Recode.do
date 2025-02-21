
clear
clear matrix 

/**********************************************
Insert your own data direction instead on (...)
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
keep vismin pr pob noc21 lwmostno lwmostfr lwmosten liprogtype lico_at lico_bt lfact kol jobperm immstat immcat5 hlregno hlregfr hlregen hlmostno hlmostfr hlmosten hdgree genstat gender fptwk fol efsize ethder efinc_at efinc dpgrsum citizen citoth cfsize cow cma cfstat cfinc_at cfinc attsch ageimm agegrp weight


**Age groups 
 label define agegrp ///
    1 "0 to 4 years" ///
    2 "5 to 6 years" ///
    3 "7 to 9 years" ///
    4 "10 to 11 years" ///
    5 "12 to 14 years" //////
    6 "15 to 17 years" ///
    7 "18 to 19 years" ///
    8 "20 to 24 years" ///
    9 "25 to 29 years" ///
    10 "30 to 34 years" ///
    11 "35 to 39 years" /// ///
    12 "40 to 44 years" ///
    13 "45 to 49 years" ///
    14 "50 to 54 years" ///
    15 "55 to 59 years" ///
    16 "60 to 64 years" ///
    17 "65 to 69 years" ///
    18 "70 to 74 years" ///
    19 "75 to 79 years" ///
    20 "80 to 84 years" ///
    21 "85 years and over" ///
    88 "not available"

*Recode missing values
recode 	agegrp (88=.)

* Keep only relevant working-age groups (15-69 years)
drop if agegrp < 6 | agegrp > 17

* Verify that only the selected age groups remain
tab agegrp

	
*Age groups at time of immigration
 label define ageimm ///
    1 "0 to 4 years" ///
    2 "5 to 9 years" ///
    3 "10 to 14 years" ///
    4 "15 to 19 years" ///
    5 "20 to 24 years" ///
    6 "25 to 29 years" ///
    7 "30 to 34 years" ///
    8 "35 to 39 years" ///
    9 "40 to 44 years" ///
    10 "45 to 49 years" ///
    11 "50 to 54 years" ///
    12 "55 to 59 years" ///
    13 "60 years and over" ///
    88 "not available" ///
    99 "not applicable"

recode ageimm (88 99=.)
	
	
*Education: School attendance - Detailed	
 label define attsch ///
    1 "did not attend school" ///
    2 "elementary or secondary school" ///
    3 "college, cegep, trade school or other non-university institution" ///
    4 "university" ///
    5 "multiple responses" ///
    8 "not available" ///
    9 "not applicable"

recode attsch (8 9=.)

*Income: Total income of census family for all persons
 label define cfinc ///
    1 "under $2,000" ///
    2 "$2,000 to $4,999" ///
    3 "$5,000 to $6,999" ///
    4 "$7,000 to $9,999" ///
    5 "$10,000 to $11,999" ///
    6 "$12,000 to $14,999" ///
    7 "$15,000 to $16,999" ///
    8 "$17,000 to $19,999" ///
    9 "$20,000 to $24,999" ///
    10 "$25,000 to $29,999" ///
    11 "$30,000 to $34,999" ///
    12 "$35,000 to $39,999" ///
    13 "$40,000 to $44,999" ///
    14 "$45,000 to $49,999" ///
    15 "$50,000 to $54,999" ///
    16 "$55,000 to $59,999" ///
    17 "$60,000 to $64,999" ///
    18 "$65,000 to $69,999" ///
    19 "$70,000 to $74,999" ///
    20 "$75,000 to $79,999" ///
    21 "$80,000 to $84,999" ///
    22 "$85,000 to $89,999" ///
    23 "$90,000 to $94,999" ///
    24 "$95,000 to $99,999" ///
    25 "$100,000 to $109,999" ///
    26 "$110,000 to $119,999" ///
    27 "$120,000 to $129,999" ///
    28 "$130,000 to $139,999" ///
    29 "$140,000 to $149,999" ///
    30 "$150,000 to $174,999" ///
    31 "$175,000 to $199,999" ///
    32 "$200,000 to $249,999" ///
    33 "$250,000 and over" ///
    88 "not available"

recode cfinc (88=.)	
	
*Income: After-tax income of census family for all persons
 label define cfinc_at ///
    1 "under $2,000" ///
    2 "$2,000 to $4,999" ///
    3 "$5,000 to $6,999" ///
    4 "$7,000 to $9,999" ///
    5 "$10,000 to $11,999" ///
    6 "$12,000 to $14,999" ///
    7 "$15,000 to $16,999" ///
    8 "$17,000 to $19,999" ///
    9 "$20,000 to $24,999" ///
    10 "$25,000 to $29,999" ///
    11 "$30,000 to $34,999" ///
    12 "$35,000 to $39,999" ///
    13 "$40,000 to $44,999" ///
    14 "$45,000 to $49,999" ///
    15 "$50,000 to $54,999" ///
    16 "$55,000 to $59,999" ///
    17 "$60,000 to $64,999" ///
    18 "$65,000 to $69,999" ///
    19 "$70,000 to $74,999" ///
    20 "$75,000 to $79,999" ///
    21 "$80,000 to $84,999" ///
    22 "$85,000 to $89,999" ///
    23 "$90,000 to $94,999" ///
    24 "$95,000 to $99,999" ///
    25 "$100,000 to $109,999" ///
    26 "$110,000 to $119,999" ///
    27 "$120,000 to $134,999" ///
    28 "$135,000 to $149,999" ///
    29 "$150,000 to $174,999" ///
    30 "$175,000 to $199,999" ///
    31 "$200,000 to $249,999" ///
    32 "$250,000 and over" ///
    88 "not available"
recode cfinc_at ( 88=.)
	
*Household living arrangements of person, simple version
 label define cfstat ///
    1 "married spouse or common-law partner without children" ///
    2 "married spouse or common-law partner with children" ///
    3 "parent in a one-parent family" ///
    4 "child of a couple" ///
    5 "child of a parent in a one-parent family" ///
    6 "person living alone" ///
    7 "person not in a census family living with non-relatives only" ///
    8 "person not in a census family but living with other relatives"
recode cfstat(8=.)

*Census metropolitan area or census agglomeration of current
 label define cma ///
    205 "halifax" ///
    399 "moncton –  saint john" ///
    421 "québec" ///
    462 "montréal" ///
    499 "sherbrooke – trois-rivières" ///
    505 "ottawa - gatineau" ///
    532 "oshawa" ///
    535 "toronto" ///
    537 "hamilton" ///
    539 "st. catharines – niagara" ///
    541 "kitchener –  cambridge –  waterloo" ///
    555 "london" ///
    559 "windsor" ///
    577 "brantford – guelph – barrie" ///
    588 "kingston – peterborough" ///
    599 "greater sudbury – thunder bay" ///
    602 "winnipeg" ///
    799 "regina – saskatoon" ///
    825 "calgary" ///
    835 "edmonton" ///
    933 "vancouver" ///
    935 "victoria" ///
    988 "kelowna –  abbotsford-mission" ///
    999 "other census metropolitan areas, census agglomerations and other geographies"
recode cma ( 999=.)

*Labour: Class of worker (derived)
 label define cow ///
    1 "employee" ///
    2 "unpaid family worker" ///
    3 "self-employed, without paid help, incorporated" ///
    4 "self-employed, with paid help, incorporated" ///
    5 "self-employed, without paid help, unincorporated" ///
    6 "self-employed, with paid help, unincorporated" ///
    8 "not available" ///
    9 "not applicable"

recode cow (8 9 =.)
	
	
*Family size
 label define cfsize ///
    1 "person not in a census family" ///
    2 "2 persons" ///
    3 "3 persons" ///
    4 "4 persons" ///
    5 "5 persons" ///
    6 "6 persons" ///
    7 "7 persons or more" ///
    8 "not available"
	
recode cfsize ( 8=.)
	
*Citizenship: Other country of citizenship
 label define citoth ///
    1 "united states" ///
    2 "other americas" ///
    3 "united kingdom - british citizen" ///
    4 "other europe" ///
    5 "africa" ///
    6 "west central asia and the middle east" ///
    7 "china, people's republic of" ///
    8 "other eastern asia" ///
    9 "philippines" ///
    10 "other southeast asia" ///
    11 "india" ///
    12 "other southern asia" ///
    13 "oceania and other" ///
    14 "two other countries" ///
    15 "no other country of citizenship" ///
    88 "not available"
recode citoth ( 14 15 88=.)
 
 *Citizenship
 label define citizen ///
    1 "canadian citizens by birth" ///
    2 "canadian citizens by naturalization" ///
    3 "not a canadian citizen"
	

*Population group
 label define dpgrsum ///
    1 "white" ///
    2 "south asian" ///
    3 "chinese" ///
    4 "black" ///
    5 "filipino" ///
    6 "arab" ///
    7 "latin american" ///
    8 "southeast asian" ///
    9 "west asian" ///
    10 "korean" ///
    11 "japanese" ///
    12 "other population groups, n.i.e." ///
    13 "other multiple population groups" ///
    14 "indigenous peoples" ///
    88 "not available"

recode dpgrsum (88=.)

*Total income of economic family for all persons
 label define efinc ///
    1 "under $2,000" ///
    2 "$2,000 to $4,999" ///
    3 "$5,000 to $6,999" ///
    4 "$7,000 to $9,999" ///
    5 "$10,000 to $11,999" ///
    6 "$12,000 to $14,999" ///
    7 "$15,000 to $16,999" ///
    8 "$17,000 to $19,999" ///
    9 "$20,000 to $24,999" ///
    10 "$25,000 to $29,999" ///
    11 "$30,000 to $34,999" ///
    12 "$35,000 to $39,999" ///
    13 "$40,000 to $44,999" ///
    14 "$45,000 to $49,999" ///
    15 "$50,000 to $54,999" ///
    16 "$55,000 to $59,999" ///
    17 "$60,000 to $64,999" ///
    18 "$65,000 to $69,999" ///
    19 "$70,000 to $74,999" ///
    20 "$75,000 to $79,999" ///
    21 "$80,000 to $84,999" ///
    22 "$85,000 to $89,999" ///
    23 "$90,000 to $94,999" ///
    24 "$95,000 to $99,999" ///
    25 "$100,000 to $109,999" ///
    26 "$110,000 to $119,999" ///
    27 "$120,000 to $129,999" ///
    28 "$130,000 to $139,999" ///
    29 "$140,000 to $149,999" ///
    30 "$150,000 to $174,999" ///
    31 "$175,000 to $199,999" ///
    32 "$200,000 to $249,999" ///
    33 "$250,000 and over" ///
    88 "not available"

recode efinc (88=.)
	
*After-tax income of economic family for all persons
 label define efinc_at ///
    1 "under $2,000" ///
    2 "$2,000 to $4,999" ///
    3 "$5,000 to $6,999" ///
    4 "$7,000 to $9,999" ///
    5 "$10,000 to $11,999" ///
    6 "$12,000 to $14,999" ///
    7 "$15,000 to $16,999" ///
    8 "$17,000 to $19,999" ///
    9 "$20,000 to $24,999" ///
    10 "$25,000 to $29,999" ///
    11 "$30,000 to $34,999" ///
    12 "$35,000 to $39,999" ///
    13 "$40,000 to $44,999" ///
    14 "$45,000 to $49,999" ///
    15 "$50,000 to $54,999" ///
    16 "$55,000 to $59,999" ///
    17 "$60,000 to $64,999" ///
    18 "$65,000 to $69,999" ///
    19 "$70,000 to $74,999" ///
    20 "$75,000 to $79,999" ///
    21 "$80,000 to $84,999" ///
    22 "$85,000 to $89,999" ///
    23 "$90,000 to $94,999" ///
    24 "$95,000 to $99,999" ///
    25 "$100,000 to $109,999" ///
    26 "$110,000 to $119,999" ///
    27 "$120,000 to $134,999" ///
    28 "$135,000 to $149,999" ///
    29 "$150,000 to $174,999" ///
    30 "$175,000 to $199,999" ///
    31 "$200,000 to $249,999" ///
    32 "$250,000 and over" ///
    88 "not available"

recode efinc_at (88=.)
	
*Ethnic or cultural origin: Derived single and selected multiple ethnic or cultural origins
 label define ethder ///
    1 "north american indigenous origins"  ///
    2 "acadian" ///
    3 "canadian" ///
    4 "french canadian" ///
    5 "québécois" ///
    6 "other north american origins" ///
    7 "english" ///
    8 "irish" ///
    9 "scottish" ///
    10 "other british isles origins" ///
    11 "french origins" ///
    12 "dutch" ///
    13 "german" ///
    14 "other western european origins" ///
    15 "other northern european origins" ///
    16 "greek" ///
    17 "italian" ///
    18 "portuguese" ///
    19 "other southern european origins" ///
    20 "romanian" ///
    21 "other southeast european origins" ///
    22 "hungarian" ///
    23 "polish" ///
    24 "russian" ///
    25 "ukrainian" ///
    26 "other eastern european origins" ///
    27 "other european origins" ///
    28 "haitian" ///
    29 "jamaican" ///
    30 "other caribbean origins" ///
    31 "mexican" ///
    32 "other latin, central and south american origins" ///
    33 "central and west african origins" ///
    34 "north african origins" ///
    35 "southern and east african origins" ///
    36 "other african origins" ///
    37 "afghan" ///
    38 "iranian" ///
    39 "lebanese" ///
    40 "other west and central asian and middle eastern origins" ///
    41 "indian (india)" ///
    42 "pakistani" ///
    43 "punjabi" ///
    44 "sri lankan" ///
    45 "other south asian origins" ///
    46 "chinese" ///
    47 "filipino" ///
    48 "korean" ///
    49 "vietnamese" ///
    50 "east and southeast asian origins, n.i.e." ///
    51 "other asian origins" ///
    52 "arab, n.o.s." ///
    53 "caucasian (white), n.o.s." ///
    54 "christian, n.i.e." ///
    55 "hindu" ///
    56 "jewish" ///
    57 "sikh" ///
    58 "other ethnic and cultural origins" ///
    59 "multiple ethnic or cultural origins" ///
    88 "not available"

recode ethder (88=.)

* Family size ( econ)
 label define efsize ///
    1 "person not in an economic family" ///
    2 "2 persons" ///
    3 "3 persons" ///
    4 "4 persons" ///
    5 "5 persons" ///
    6 "6 persons" ///
    7 "7 persons or more" ///
    8 "not available"
	
recode efsize (8=.)

*Language: First official language spoken
 label define fol ///
    1 "english" ///
    2 "french" ///
    3 "english and french" ///
    4 "neither english nor french"

	
*Full-time or part-time weeks worked in 2020
 label define fptwk ///
    1 "worked mainly full-time weeks in 2020" ///
    2 "worked mainly part-time weeks in 2020" ///
    8 "not available" ///
    9 "not applicable"
recode fptwk ( 8 9 =.)

*sex at birth
 label define gender ///
    1 "woman+" ///
    2 "man+"

	*"Generation status" refers to whether or not the person or the person's parents were born in Canada.
 label define genstat ///
    1 "first generation, respondent born outside canada" ///
    2 "second generation, respondent born in canada, both parents born outside canada" ///
    3 "second generation, respondent born in canada, one parent born outside canada and one parent born in canada" ///
    4 "third generation or more, respondent born in canada, both parents born in canada" ///
    8 "not available"
recode genstat (8=.)

*Education: Highest certificate, diploma or degree
 label define hdgree ///
    1 "no certificate, diploma or degree" ///
    2 "high (secondary) school diploma or equivalency certificate" ///
    3 "non-apprenticeship trades certificate or diploma" ///
    4 " apprenticeship certificate" ///
    5 "program of 3 months to less than 1 year (college, cegep and other non-university certificates or diplomas)" ///
    6 "program of 1 to 2 years (college, cegep and other non-university certificates or diplomas)" ///
    7 "program of more than 2 years (college, cegep and other non-university certificates or diplomas)" ///
    8 "university certificate or diploma below bachelor level" ///
    9 "bachelor's degree" ///
    10 "university certificate or diploma above bachelor level" ///
    11 "degree in medicine, dentistry, veterinary medicine or optometry" ///
    12 "master's degree" ///
    13 "earned doctorate" ///
    88 "not available" ///
    99 "not applicable"
recode hdgree ( 88 99 = .)

*Language spoken most often at home - English
 label define hlmosten ///
    0 "false - respondent did not report english as the language spoken most often at home"  ///
    1 "true - respondent reported english as the language spoken most often at home" ///
    8 "not available"
recode hlmosten (8=.)
	
	
*Language spoken most often at home - French
 label define hlmostfr ///
    0 "false - respondent did not report french as the language spoken most often at home" ///
    1 "true - respondent reported french as the language spoken most often at home" ///
    8 "not available"
recode hlmostfr (8=.)
	
*Language: Language spoken most often at home
 label define hlmostno ///
    1 "no non-official language" ///
    2 "indigenous languages" ///
    3 "italian" ///
    4 "spanish" ///
    5 "portuguese" ///
    6 "german" ///
    7 "russian" ///
    8 "polish" ///
    9 "slavic languages" ///
    10 "other european languages" ///
    11 "arabic" ///
    12 "other afro-asiatic and african languages" ///
    13 "punjabi (panjabi)" ///
    14 "urdu" ///
    15 "persian (farsi)" ///
    16 "other indo-iranian languages" ///
    17 "cantonese" ///
    18 "mandarin" ///
    19 "chinese languages" ///
    20 "austro-asiatic languages" ///
    21 "tagalog (pilipino, filipino)" ///
    22 "other east and southeast asian languages" ///
    23 "tamil" ///
    24 "all other languages" ///
    88 "not available"
recode hlmostno (8=.)
	
*Language: Other language(s) spoken regularly at home english
 label define hlregen ///
    0 "false - respondent did not report english as the other language spoken at home on a regular basis" ///
    1 "true - respondent reported english as the other language spoken at home on a regular basis" ///
    8 "not available"
recode hlregen (8=.)

*language: Other language(s) spoken regularly at home french
 label define hlregfr ///
    0 "false - respondent did not report french as the other language spoken at home on a regular basis" ///
    1 "true - respondent reported french as the other language spoken at home on a regular basis" ///
    8 "not available"
	
recode hlregfr(8=.)
	
	
*Language: Other language(s) spoken regularly at home others
 label define hlregno ///
    0 "false - respondent did not report a non-official language as the language spoken at home on a regular basis" ///
    1 "true - respondent reported a non-official language as the language spoken at home on a regular basis"

	
/*Immigration: Admission category - Summary
This variable provides a summary of admission categories for immigrants who were
admitted to Canada between January 1st, 1980 and May 11th, 2021.
"Admission category" refers to the name of the immigration program or group of programs
under which an immigrant has been granted for the first time the right to live in Canada
permanently by immigration authorities.*/

 label define immcat5 ///
    1 "non-immigrants" ///
	2 "non-permanent residents" ///
    3 "immigrants who landed before 1980" ///
    21 "economic immigrants" ///
    22 "immigrants sponsored by family and other immigrants" ///
    23 "refugees" ///
    88 "not available"
recode immcat5 ( 88 = .)
	
	/*"Immigrant status" refers to whether the person is a non-immigrant, an immigrant or a nonpermanent
resident.
In 2021, for the first time, immigrant status was obtained from administrative files provided
by Immigration, Refugees and Citizenship Canada (IRCC) through record linkage.
"Non-immigrant" includes persons who are Canadian citizens by birth.*/

 label define immstat ///
    1 "non-immigrants" ///
    2 "immigrants" ///
    3 "non-permanent residents" ///
    88 "not available"
	
recode immstat (88=.)

/*Labour: Job permanency:	Job permanency refers to the classification of paid jobs as either permanent or temporary
for persons aged 15 years and over in private households that were paid employees.*/

 label define jobperm ///
    1 "other employment - unpaid, self employed"  ///
    2 "employee - permanent position" ///
    3 "employee - fixed term (1 year or more) /  casual, seasonal or short-term position (less than 1 year)" ///
    8 "not available" ///
    9 "not applicable"
	
recode jobperm (8 9 = .)

*Language: Knowledge of official languages
 label define kol ///
    1 "english only" ///
    2 "french only" ///
    3 "english and french" ///
    4 "neither english nor french" ///
    8 "not available"

recode kol (8=.)

*Labour: Labour force status - Detailed
 label define lfact ///
    1 "employed - Worked in reference week" ///
	2 "employed - absent in reference week" ///
    3 "unemployed - temporary layoff - did not look for work" ///
    4 "unemployed - temporary layoff - looked for full-time work" ///
    5 "unemployed - temporary layoff - looked for part-time work" ///
    6 "unemployed - new job - did not look for work" ///
    7 "unemployed - new job - looked for full-time work" ///
    8 "unemployed - new job - looked for part-time work" ///
    9 "unemployed - looked for full-time work" ///
    10 "unemployed - looked for part-time work" ///
    11 "not in the labour force - last worked in 2021" ///
    12 "not in the labour force - last worked in 2020" ///
    13 "not in the labour force - last worked before 2020" ///
    14 "not in the labour force - never worked" ///
    88 "not available" ///
    99 "not applicable"

recode lfact (88 99 = .)
	
	/*Income: Low-income status based on LICO-BT
	Refers to the income situation of a person in relation to the Low-income cut-offs, before-tax
(LICO-BT). Persons with income that is below this low-income line are considered to be in
low income.
The value 9 stands for not applicable and is applied to those living in areas where this lowincome
concept is not applicable, (i.e. the territories).*/

 label define lico_bt ///
    1 "not in low income" ///
    2 "in low income" ///
    8 "not available" ///
    9 "not applicable"
recode lico_bt(8 9 =.)
	
	/*Income: Low-income status based on LICO-AT
	Refers to the income situation of a person in relation to the Low-income cut-offs, after-tax
(LICO-AT). Persons with income that is below this low-income line are considered to be in
low income.*/

 label define lico_at ///
    1 "not in low income" ///
    2 "in low income" ///
    8 "not available" ///
    9 "not applicable"
recode lico_at (8 9 =.)

*Language: Type of French program attended in Canada by residents of Canada outside Quebec	
 label define liprogtype ///
    1 "residents of canada outside quebec who attended a regular french program in a french-language school at the primary or secondary levels in canada" ///
    2 "residents of canada outside quebec who attended a french immersion program in an english-language school at the primary or secondary levels in canada" ///
    3 "residents of canada outside quebec who attended both types of programs in canada" ///
    4 "residents of canada outside quebec who did not attend a regular french program in a french-language school or a french immersion program in canada" ///
    9 "not applicable"
recode liprogtype (9=.)

*Language: Language used most often at work - English
 label define lwmosten ///
    0 "false - respondent did not report english as the language used most often at work" ///
    1 "true - respondent reported english as the language used most often at work" ///
    8 "not available" ///
    9 "not applicable"

recode lwmosten (9=.)	
	
*Language: Language used most often at work - french
 label define lwmostfr ///
    0 "false - respondent did not report french as the language used most often at work" ///
    1 "true - respondent reported french as the language used most often at work" ///
    8 "not available" ///
    9 "not applicable"

recode lwmostfr (8 9 =.)
	
*Language: Language used most often at work - other
 label define lwmostno ///
    0 "false - respondent did not report a non-official language as the language used most often at work" ///
    1 "true - respondent reported a non-official language as the language used most often at work" ///
    9 "not applicable"

recode lwmostno (8 9 =.)

*Labour: Occupation Major Group (based on the National Occupational Classification [NOC] 2021 version 1.0)
 label define noc21 ///
    1 "00 legislative and senior managers" ///
    2 "middle management occupations" ///
    3 "11 professional occupations in business and finance" ///
    4 "12 administrative and financial supervisors and specialized administrative occupations" ///
    5 "13 administrative occupations and transportation logistics occupations" ///
    6 "14 administrative and financial support and supply chain logistics occupations" ///
    7 "21 professional occupations in natural and applied sciences" ///
    8 "22 technical occupations related to natural and applied sciences" ///
    9 "31 professional occupations in health" ///
    10 "32 technical occupations in health" ///
    11 "33 assisting occupations in support of health services" ///
    12 "41 professional occupations in law, education, social, community and government services" ///
    13 "42 front-line public protection services and paraprofessional occupations in legal, social community, education services" ///
    14 "43-45 assisting occupations, care providers, student monitors, crossing guards and related occupations in education and in legal and public protection" ///
    15 "51-52 professional and technical occupations in art, culture and sport" ///
    16 "53-55 other occupations in art, culture and sport" ///
    17 "62 retail sales and service supervisors and specialized occupations in sales and services" ///
    18 "63 occupations in sales and services" ///
    19 "64 sales and service representatives and other customer and personal services occupations" ///
    20 "65 sales and service support occupations" ///
    21 "72 technical trades and transportation officers and controllers" ///
    22 "73 general trades" ///
    23 "74 mail and message distribution, other transport equipment operators and related maintenance workers" ///
    24 "75 helpers and labourers and other transport drivers, operators and labourers" ///
    25 "82-85 occupations in natural resources, agriculture and related production" ///
    26 "92-95 occupations in processing, manufacturing and utilities" ///
    88 "not available" ///
    99 "not applicable"

recode noc21 (88 99=. )

*Place of birth of person
 label define pob ///
    1 "canada" ///
    2 "united states" ///
    3 "central america" ///
    4 "jamaica" ///
    5 "other caribbean and bermuda" ///
    6 "south america" ///
    7 "united kingdom" ///
    8 "germany" ///
    9 "france" ///
    10 "other northern and western europe" ///
    11 "poland" ///
    12 "other eastern europe" ///
    13 "italy" ///
    14 "portugal" ///
    15 "other southern europe" ///
    16 "eastern africa" ///
    17 "northern africa" ///
    18 "other africa" ///
    19 "iran" ///
    20 "other west central asia and the middle east" ///
    21 "china" ///
    22 "hong kong" ///
    23 "south korea" ///
    24 "other eastern asia" ///
    25 "philippines" ///
    26 "viet nam" ///
    27 "other southeast asia" ///
    28 "india" ///
    29 "pakistan" ///
    30 "sri lanka" ///
    31 "other southern asia" ///
    32 "oceania and others" ///
    88 "not available"

 recode pob ( 88=.)
 
*Province or territory of current residence (2021)
 label define pr ///
    10 "newfoundland and labrador" ///
    11 "prince edward island" ///
    12 "nova scotia" ///
    13 "new brunswick" ///
    24 "quebec" ///
    35 "ontario" ///
    46 "manitoba" ///
    47 "saskatchewan" ///
    48 "alberta" ///
    59 "british columbia" ///
    70 "northern canada"

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

 label define vismin ///
    1 "not a visible minority" ///
    2 "south asian" ///
    3 "chinese" ///
    4 "black" ///
    5 "filipino" ///
    6 "arab" ///
    7 "latin american" ///
    8 "southeast asian" ///
    9 "west asian" ///
    10 "korean" ///
    11 "japanese" ///
    12 "visible minority, n.i.e." ///
    13 "multiple visible minorities" ///
    88 "not available"
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

save `dta_name', replace