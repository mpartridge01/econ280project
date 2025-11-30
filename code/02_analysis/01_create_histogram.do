********************************************************************************

*							Create_hitogram.do								   *

********************************************************************************
*
* This file loads in clean data for analysis and creates a hitogram of 
* math test scores by pre vs post treatment
*
********************************************************************************

cd "/Users/mpart/Documents/GitHub/econ280project"

use "./data/cleandata/ms_blel_jpal_long.dta", clear

twoway ///
    (hist per_math if round == 1, fcolor(blue%40) lcolor(blue)) ///
    (hist per_math if round == 2, fcolor(red%40) lcolor(red)), ///
    legend(label(1 "Baseline") label(2 "Endline"))
graph export "output/figures/histogram_math_score_distribtuion.png", replace

/*
use "./data/cleandata/ms_ei.dta", clear
export delimited using "./data/cleandata/ms_ei.csv", replace
							
	///	drop duplicates
		
		duplicates drop st_id, force
		/* ajg: multiple obs per st_id due to individual attendance data,
		dropping here because i only need aggregate attendance data */	
			
	///	keep key vars
		
		keep st_id att_tot
			
	/// merge with j-pal data wide

		mer 1:1 st_id using "./data/cleandata/ms_blel_jpal_wide.dta"
