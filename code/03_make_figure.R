#Figure1
library(dplyr)
library(srvyr)
library(ggplot2)

nhanes <- readRDS("data/nhanes_clean.rds")

des <- nhanes %>%
  as_survey_design(ids = SDMVPSU, strata = SDMVSTRA, weights = WTINT2YR, nest = TRUE) %>%
  filter(!is.na(insurance), !is.na(unmet), !is.na(income_cat),
         !is.na(educ_cat), !is.na(race_cat), !is.na(age_group))

prev_plot <- des %>%
  group_by(insurance, age_group) %>%
  summarise(prev = survey_mean(unmet, proportion = TRUE, vartype = "ci")) %>%
  mutate(across(c(prev, prev_low, prev_upp), ~ 100 * .x))

fig <- ggplot(prev_plot, aes(x = insurance, y = prev, fill = age_group)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  geom_errorbar(aes(ymin = prev_low, ymax = prev_upp),
                position = position_dodge(width = 0.8), width = 0.2) +
  scale_fill_manual(values = c("20-64 years" = "#4C72B0", "65+ years" = "#DD8452")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Unmet Dental Care Need by Insurance Status and Age Group",
       subtitle = "U.S. adults aged 20+, NHANES 2015-2016 (survey-weighted, with 95% confidence intervals)",
       x = "Health insurance status",
       y = "Adults reporting unmet dental care need (%)",
       fill = "Age group") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(size = 11),
        legend.position = "bottom")

ggsave("output/figure1.png", fig, width = 8, height = 5.5, dpi = 200)
saveRDS(prev_plot, "output/figure1_data.rds")
