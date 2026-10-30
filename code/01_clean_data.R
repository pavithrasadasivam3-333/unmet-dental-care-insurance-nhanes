
library(haven)
library(dplyr)

demo <- read_xpt("data/DEMO_I.XPT")
hiq  <- read_xpt("data/HIQ_I.XPT")
ohq  <- read_xpt("data/OHQ_I.XPT")

nhanes <- demo %>%
  select(SEQN, RIDAGEYR, RIDRETH3, DMDEDUC2, INDFMPIR, WTINT2YR, SDMVPSU, SDMVSTRA) %>%
  inner_join(select(hiq, SEQN, HIQ011), by = "SEQN") %>%
  inner_join(select(ohq, SEQN, OHQ770), by = "SEQN") %>%
  mutate(insurance = case_when(HIQ011 == 2 ~ "Uninsured", HIQ011 == 1 ~ "Insured"),
    unmet = case_when(OHQ770 == 1 ~ 1, OHQ770 == 2 ~ 0),
    income_cat = case_when(INDFMPIR < 1 ~ "Below 1.0", INDFMPIR < 2 ~ "1.0-1.99",
                           INDFMPIR < 4 ~ "2.0-3.99", INDFMPIR >= 4 ~ "4.0 or higher"),
    educ_cat = case_when(DMDEDUC2 %in% c(1, 2) ~ "Less than high school",
                         DMDEDUC2 == 3 ~ "High school/GED", DMDEDUC2 == 4 ~ "Some college",
                         DMDEDUC2 == 5 ~ "College graduate or higher"),
    race_cat = case_when(RIDRETH3 %in% c(1, 2) ~ "Hispanic", RIDRETH3 == 3 ~ "Non-Hispanic White",
                         RIDRETH3 == 4 ~ "Non-Hispanic Black", RIDRETH3 %in% c(6, 7) ~ "Other"),
    age_group = case_when(RIDAGEYR >= 65 ~ "65+ years", RIDAGEYR >= 20 ~ "20-64 years"),
    insurance = factor(insurance, levels = c("Insured", "Uninsured")),
    age_group = factor(age_group, levels = c("20-64 years", "65+ years"))
  )

saveRDS(nhanes, "data/nhanes_clean.rds")
