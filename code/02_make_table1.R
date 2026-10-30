#Table1
library(dplyr)
library(srvyr)

nhanes <- readRDS("data/nhanes_clean.rds")


des <- nhanes %>%
  as_survey_design(ids = SDMVPSU, strata = SDMVSTRA, weights = WTINT2YR, nest = TRUE) %>%
  filter(!is.na(insurance), !is.na(unmet), !is.na(income_cat),
         !is.na(educ_cat), !is.na(race_cat), !is.na(age_group))

prev_all <- des %>%
  summarise(n = unweighted(n()), prev = survey_mean(unmet, proportion = TRUE, vartype = "ci")) %>%
  mutate(insurance = "All adults")

prev_by_ins <- des %>%
  group_by(insurance) %>%
  summarise(n = unweighted(n()), prev = survey_mean(unmet, proportion = TRUE, vartype = "ci")) %>%
  mutate(insurance = as.character(insurance))


prev_numeric <- bind_rows(prev_all, prev_by_ins)


table_df <- prev_numeric %>%
  transmute(`Insurance status` = insurance,
            `Sample size (n)` = n,
            `Weighted prevalence (%)` = round(100 * prev, 1),
            `95% confidence interval (%)` =
              paste0(round(100 * prev_low, 1), " to ", round(100 * prev_upp, 1)))

saveRDS(list(table = table_df, numeric = prev_numeric), "output/table1.rds")
