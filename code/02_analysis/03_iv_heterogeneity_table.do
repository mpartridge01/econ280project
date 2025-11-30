********************************************************************************

*						   iv_heterogeneity_table.do					       *

********************************************************************************
*
* This file creates a table that investigates attendance effects
* heterogeneity by gender for the IV estimates.
*
********************************************************************************


* set current directory of project folder
cd "/Users/mpart/Documents/GitHub/econ280project"

********************************************************************************
* 						  Import and merge in data							   *
********************************************************************************
	/// load sgi data
	
		use "./data/cleandata/ms_ei.dta", clear
							
	///	drop duplicates
		
		duplicates drop st_id, force
		/* ajg: multiple obs per st_id due to individual attendance data,
		dropping here because i only need aggregate attendance data */	
			
	///	keep key vars
		
		keep st_id att_tot
			
	/// merge with j-pal data wide

		mer 1:1 st_id using "./data/cleandata/ms_blel_jpal_wide.dta"
			
	/// gen interactions
		

			
	///	impute 0 attendance for control children
		
		replace att_tot=0 if treat==0
	
	///	save tempfile
	
		tempfile tfile4
		save `tfile4'
	
	///	run regressions

********************************************************************************
* 						     	 Run IV regressions							   *
********************************************************************************	
	
		estimates clear

****** Baseline regressions		
		
		// Math baseline
		
		gen baseline = m_theta_mle1

		
		xtivreg2 m_theta_mle2 (att_tot=treat) baseline, robust ///
		i(strata) fe endog(att_tot)
			quietly estimates store ivmath
			estadd scalar R2_iv = e(r2)
			estadd scalar N_obs = e(N)
			estadd scalar ap_fstat = e(widstat)
			estadd scalar sargan = e(estatp)
			estadd scalar effect90 = 90 * (_b[att_tot])
		
		// Hindi baseline
		
		drop baseline
		gen baseline = h_theta_mle1
		
			
		xtivreg2 h_theta_mle2 (att_tot=treat) baseline, robust ///
		i(strata) fe endog(att_tot)
			quietly estimates store ivhindi
			estadd scalar R2_iv = e(r2)
			estadd scalar N_obs = e(N)
			estadd scalar ap_fstat = e(widstat)
			estadd scalar sargan = e(estatp)
			estadd scalar effect90 = 90 * (_b[att_tot])

	
		
****************************************
*  create variables for  heterogeneity
****************************************

* Create interaction variables
gen treat_female = treat * st_female1
gen att_female   = att_tot * st_female1

		// math hetero

		drop baseline
		gen baseline = m_theta_mle1

		xtivreg2 m_theta_mle2                               ///
			(att_tot att_female = treat treat_female)        ///
			baseline st_female1,                         ///
			robust i(strata) fe endog(att_tot att_female)
			quietly estimates store ivmathgender
			estadd scalar R2_iv = e(r2)
			estadd scalar N_obs = e(N)
			estadd scalar ap_fstat = e(widstat)
			estadd scalar sargan = e(estatp)
			estadd scalar effect90 = 90 * (_b[att_tot] + _b[att_female])

		// Hindi hetero
		
		drop baseline
		gen baseline = h_theta_mle1

		xtivreg2 h_theta_mle2                               ///
			(att_tot att_female = treat treat_female)        ///
			baseline st_female1,                         ///
			robust i(strata) fe endog(att_tot att_female)
			quietly estimates store ivhindigender
			estadd scalar R2_iv = e(r2)
			estadd scalar N_obs = e(N)
			estadd scalar ap_fstat = e(widstat)
			estadd scalar sargan = e(estatp)
			estadd scalar effect90 = 90 * (_b[att_tot] + _b[att_female])


********************************************************************************
* 						     	Create table	     						   *
********************************************************************************	
		
		
* Format table
#d ;
	esttab ivmath ivmathgender ivhindi ivhindigender
		using "./output/tables/table9_sex.tex", 
		noomitted /* nomtitles */
		nonotes
		order(att_tot att_female baseline)
		keep(att_tot att_female baseline)
		/*nomtitles*/
		mtitles("Endline math score" "Endline math score" "Endline Hindi score" "Endline Hindi score")
		coeflabels(att_tot "Attendance (days)" att_female "Attendance \$\times\$ \$\mathbf{1}\$\{female\}" baseline "Baseline score")
		nodepvars
		se
		noconstant b(%5.4f) se(%5.4f)
		/* stats(N, fmt(%9.0fc)) */
		mgroups("Math score" "Hindi Score", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
		s(N_obs R2_iv ap_fstat sargan effect90, ///
		label("Observations" "R-squared" "AP F-statistic" "Diff-in-Sargan p-value" "Effect of 90 days attendance") ///
		fmt(%9.0fc %9.3f %9.0fc %9.3f %9.3f)) replace;
#d cr	
