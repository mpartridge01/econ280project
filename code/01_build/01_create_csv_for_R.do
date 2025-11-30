* Create a csv file for R

use "./data/cleandata/ms_blel_jpal_wide.dta", clear
export delimited "./data/cleandata/ms_blel_jpal_wide.csv", replace
