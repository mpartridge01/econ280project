/*******************************************************************************

This file creates all tables and figures for the ECON 280 project replication

Notes:
1. The order of running the analysis scripts do not matter, but they will go in 
   the order of each part of the project
2. The directory is set at the top of this script, along with in each file. This
   can be changed for others who are replicating this project.

*******************************************************************************/

* set current directory of project folder
cd "/Users/mpart/Documents/GitHub/econ280project"

global Rpath = "/usr/local/bin/R"

/*******************************************************************************
							 Create extra datasets
*******************************************************************************/

* Create csv file of data for R
include code/01_build/01_create_csv_for_R.do

/*******************************************************************************
					  Create analysis tables and figures
*******************************************************************************/

* Craete histogram of continuous variable
include code/02_analysis/01_create_histogram.do

* Replicate main results (Table 2)
shell $Rpath --vanilla <./code/02_analysis/02_main_result_replication.R

* Create extension of result table (extended table 9 of paper)
include code/02_analysis/03_iv_heterogeneity_table.do
