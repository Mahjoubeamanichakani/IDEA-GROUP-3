
clear
clear matrix


******************
*Analysis
******************
cd
use "clean.dta", clear
ssc install estout

* Assign weight
svyset [pweight=weight]

*summary of main variables

dtable i.Immigrant_status i.Visibleminority i.gender i.Highest_certificate i.uni_educated i.Place_of_birth i.Knowledge_of_lang i.Lowe_Income_Status_before_tax, svy by(employed) title(Table 1: Distribution of Employment and Unemployment by Socio-Demographic Characteristic)

*Compare distribution-Unweighted
tab employed Immigrant_status, chi2



*Compare distribution-weighted
svy: tab employed Immigrant_status, col percent


*************************************************

** Model selection based on AIC & BIC **

* Model 1: Base model
logit employed i.Immigrant_status
estimates store model1

* Model 2: Add gender, education, language, visible minority
logit employed i.Immigrant_status i.gender i.Highest_certificate i.Knowledge_of_lang i.Visibleminority
estimates store model2

* Model 3: Add Race (if applicable — adjust variable name if needed)
logit employed i.Immigrant_status i.gender i.Highest_certificate i.Knowledge_of_lang i.dpgrsum
estimates store model3

* Model 4: Add Place of Birth
logit employed i.Immigrant_status i.gender i.Highest_certificate i.Knowledge_of_lang i.Place_of_birth
estimates store model4

* Model 5: Add visible minority (binary version if used elsewhere)
logit employed i.Immigrant_status i.gender i.Highest_certificate i.Knowledge_of_lang i.Visibleminority
estimates store model5

* Model 6: Change education to the binary form
logit employed i.Immigrant_status i.gender i.uni_educated i.Knowledge_of_lang i.dpgrsum
estimates store model6

* Comparison Table
estout model1 model2 model3 model4 model5 model6, cells(b(star fmt(7) label(Coef.)) se(par fmt(2) label(std.errors))) label stats(N r2 bic aic, labels ("No. of Obs." "R-Squared" "BIC" "AIC") fmt(3 0 1))



*****************************

*Bivariate analysis: 
*Examine the relationship between the dependent variable (employment status) and the key independent variable (immigration status).
svy: logistic employed i.Immigrant_status
*Store the results from this bivariate model to compare later.
estimates store Model1

*Bivariate analysis with additional demographic variables:
*Assess the relationship between employment status immigration status Gender cisible minority Education Level Language Proficiency Race Job Type 
svy: logistic employed ib1.Immigrant_status i.Knowledge_of_lang i.dpgrsum i.Highest_certificate i.gender
*Store the results from this extended bivariate model for comparison.
estimates store Model2

*Create a final comparison table:
*Compare the odds ratios from the bivariate models (model1 and model2) and the multivariate model (multivariable_model).
*The results are presented in a wide format for easy interpretation.
esttab Model1 Model2 , eform b(3) nonumber wide varwidth(15)

margins, dydx(* )post
***************************************************************************************

*Stratifying by group


/*option1: based on employment and immigration*/

** non-immigrants
svy: logistic employed i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==1
estimates store Model_non_immigrants

** immigrants
svy: logistic employed i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==2
estimates store Model_immigrants

** non-permanent residents
svy: logistic employed i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==3
estimates store Model_non_permanent

suest Model_non_immigrants Model_immigrants Model_non_permanent
*************************************************************************************

/*option2: based on income and immigration status*/


gen Lowe_Income_Status=.
replace Lowe_Income_Status=0 if Lowe_Income_Status_before_tax==1
replace Lowe_Income_Status=1 if Lowe_Income_Status_before_tax==2


label define Lowe_Income_Status 0"Not in low income" 1"In low income"
label value Lowe_Income_Status Lowe_Income_Status
tab Lowe_Income_Status

svy: logistic Lowe_Income_Status i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==1
estimates store non_immigrants

svy: logistic Lowe_Income_Status i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==2
estimates store immigrants

svy: logistic Lowe_Income_Status i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender if Immigrant_status==3
estimates store non_permanent

suest non_immigrants immigrants non_permanent

*****************************************




***plot the results

*1 coef
coefplot (Model_non_immigrants, label("Non-immigrants"))(Model_immigrants, label("Immigrants"))(Model_non_permanent, label("Non-permanent residents")), xline(0) xlabel(, grid)title("Regression Coefficients for Predictors of employment Status", size(vsmall)) byopts(compact rowgap(1) titlegap(2)) ciopts(lwidth(vthin)) mlabsize(vsmall)  msymbol(O)  msize(small)  ylabel(, labsize(tiny)) xlabel(, labsize(vsmall)) legend(size(vsmall))


*1 odds
coefplot (Model_non_immigrants, label("Non-immigrants"))(Model_immigrants, label("Immigrants"))(Model_non_permanent, label("Non-permanent residents")), eform xline(1) xlabel(-2(1)15, grid)title("Odds ratio for Predictors of employment Status", size(vsmall)) byopts(compact rowgap(1) titlegap(2)) ciopts(lwidth(vthin)) mlabsize(vsmall)  msymbol(O)  msize(small)  ylabel(, labsize(tiny)) xlabel(, labsize(vsmall)) legend(size(vsmall)) 



*2
coefplot (non_immigrants, label("Non-immigrants")) (immigrants, label("Immigrants")) (non_permanent, label("Non-permanent residents")), xline(0) xlabel(, grid)title("Regression Coefficients for Predictors of Low Income Status", size(vsmall)) byopts(compact rowgap(1) titlegap(2)) ciopts(lwidth(vthin)) mlabsize(vsmall)  msymbol(O)  msize(small)  ylabel(, labsize(tiny)) xlabel(, labsize(vsmall)) legend(size(vsmall))

*2 odds
coefplot (non_immigrants, label("Non-immigrants")) (immigrants, label("Immigrants")) (non_permanent, label("Non-permanent residents")), eform xline(1) xlabel(-2(1)5, grid)title("Odds ratio for Predictors of Low Income Status", size(vsmall)) byopts(compact rowgap(1) titlegap(2)) ciopts(lwidth(vthin)) mlabsize(vsmall)  msymbol(O)  msize(small)  ylabel(, labsize(tiny)) xlabel(, labsize(vsmall)) legend(size(vsmall))


*****margins
svy: logistic employed i.Immigrant_status i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender
margins, dydx(* )post



svy: logistic Lowe_Income_Status i.Immigrant_status i.dpgrsum i.Knowledge_of_lang i.Highest_certificate i.gender
margins, dydx(*)post



