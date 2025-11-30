

## Overview

This README helps guide the replicator through a short replication project of "Disrupting Education? Experimental Evidence on Technology-Aided Instruction in India?" by Karthik Muralidharan, Abhijeet Singh, and Alejandro J. Ganimian. The code in this replication package constructs 2 tables and 1 figure for the short project. The replicator should expect the code to run for less than 1 minute.

## Data Availability and Provenance Statements

The data used in this replication is from "Disrupting Education? Experimental Evidence on Technology-Aided Instruction in
India?" by Karthik Muralidharan, Abhijeet Singh, and Alejandro J. Ganimian.

The data is publicly available in a downloadable replication package from the AEA website (https://www.aeaweb.org/articles?id=10.1257/aer.20171112).

### Summary of Availability

- [x] All data **are** publicly available.
- [ ] Some data **cannot be made** publicly available.
- [ ] **No data can be made** publicly available.


## Dataset list

| Data file | Source | Provided |
|-----------|--------|----------|
| `data/cleandata/ms_blel_jpal_long.dta` | "Disrupting Education? Experimental Evidence..." | Yes |
| `data/cleandata/ms_blel_jpal_wide.dta` | "Disrupting Education? Experimental Evidence..." | Yes |
| `data/cleandata/ms_ei.dta`| "Disrupting Education? Experimental Evidence..." | Yes |


### Software Requirements

- Stata (code was last run with version 19)
  - Portions of code use the terminal
  - Extra packages are used and may need to be installed
- R 4.5.1
  - Packages used:
    - `data.table`
    - `fixest`
    - `modelsummary`
    - `tibble`


### Memory and Runtime Requirements

Approximate time needed to reproduce the analyses on a standard 2025 desktop machine:

- [x] <10 minutes
- [ ] 10-60 minutes
- [ ] 1-2 hours
- [ ] 2-8 hours
- [ ] 8-24 hours
- [ ] 1-3 days
- [ ] 3-14 days
- [ ] > 14 days
- [ ] Not feasible to run on a desktop machine, as described below.

iOS was used to run this code by the author.

## Description of programs/code

- The program `code/master.do` in `code` runs all the programs in the short replication project in the right order.
- Programs in `code/01_build` will create all extra datasets used in the analysis. Here, the only dataset created is csv file that is used in R. `code/01_build/01_create_csv_for_R.dta` creates the csv file used in `code/02_analysis/02_main_result_replication.R`.
- Programs in `programs/02_analysis` generate all tables and figures in this replication project. The program `code/02_analysis/create_historgram.do` creates a histogram of a continuous variable (`histogram_math_score_distribtuion.png`). The program `code/02_analysis/02_main_result_replication.R` creates a replciation of the main result in R instead of STATA (`table_2.tex`). The program `code/02_analysis/03_iv_heterogeneity_table.do` creates an extension of Table 9 of the paper (`table9_sex.tex`).

## Instructions to Replicators

- Edit `code/master.do` to adjust the default paths for the project folder and for R.
- Edit all scripts in the subfolders of `code` to adjsut the default paths if using the scripts directly and not running them from `code/master.do`.

## List of tables and programs

The provided code reproduces:

- [ ] All numbers provided in text in the paper
- [x] All tables and figures in the paper
- [ ] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                                        | Output file                           |
|-------------------|------------------------------------------------|---------------------------------------|
| Table 1           | code/02_analysis/02_main_result_replication.R  | table_2.tex                           |
| Table 2           | code/02_analysis/03_iv_heterogeneity_table.do  | table9_sex.tex                        |
| Figure 1          | code/02_analysis/create_historgram.do          | histogram_math_score_distribtuion.png |

## References

Muralidharan, Karthik, Abhijeet Singh, and Alejandro J. Ganimian. 2019. "Disrupting Education? Experimental Evidence on Technology-Aided Instruction in India." American Economic Review 109 (4): 1426–60. 

---

