library(data.table)
library(fixest)
library(modelsummary)
library(tibble)

# ----------------------------------------------------
# 1. Load data
# ----------------------------------------------------
df <- fread("data/cleandata/ms_blel_jpal_wide.csv")

setnames(df, "m_theta_mle1", "baseline_math")
setnames(df, "h_theta_mle1", "baseline_hindi")
setnames(df, "m_theta_mle2", "endline_math")
setnames(df, "h_theta_mle2", "endline_hindi")

# ----------------------------------------------------
# 2. Regressions
# ----------------------------------------------------
m1 <- lm(endline_math  ~ treat + baseline_math, data = df)
m2 <- lm(endline_hindi ~ treat + baseline_hindi, data = df)

m3 <- feols(endline_math  ~ treat + baseline_math | strata,
            data = df, vcov = "HC1")

m4 <- feols(endline_hindi ~ treat + baseline_hindi | strata,
            data = df, vcov = "HC1")

# ----------------------------------------------------
# 3. Only the rows you want
# ----------------------------------------------------
extra_rows <- tribble(
  ~term,                ~`(1)`, ~`(2)`, ~`(3)`, ~`(4)`,
  "Strata fixed effects", "Y",   "Y",   "N",   "N"
)

# ----------------------------------------------------
# 4. Produce LaTeX table with ONLY obs, R2, FE row
# ----------------------------------------------------
modelsummary(
  models = list("(1)" = m1, "(2)" = m2, "(3)" = m3, "(4)" = m4),
  coef_map = c(
    "treat" = "Treatment",
    "baseline_math" = "Baseline score",
    "baseline_hindi" = "Baseline score",
    "(Intercept)" = "Constant"
  ),
  stars = FALSE,
  statistic = "std.error",
  gof_map = data.frame(              # ONLY show these
    raw = c("nobs", "r.squared"),
    clean = c("Num.Obs.", "R2"),
    fmt = c(0, 3)
  ),
  add_rows = extra_rows,
  notes = NULL,                      # <-- removes footnote
  output = "output/tables/table_2.tex",
  escape = FALSE
)
