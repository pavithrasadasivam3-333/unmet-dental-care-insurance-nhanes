# Health Insurance and Unmet Dental Care Need, NHANES 2015-2016

DATA 550 final project. The report looks at whether lack of health insurance is associated with unmet dental care need among U.S. adults aged 20 and older.

## Key finding
Among U.S. adults aged 20+, 41.5% of uninsured adults reported unmet dental care need, compared with 15.8% of insured adults (survey-weighted, unadjusted; NHANES 2015-2016).

## Contents

- `report.Rmd`: the report; `report.html`: the finished report
- `Makefile`: builds the report
- `code/`: R scripts for downloading, cleaning, and summarizing the data
- `data/`: NHANES 2015-2016 files (`DEMO_I.XPT`, `HIQ_I.XPT`, `OHQ_I.XPT`) and the cleaned data
- `output/`: the table and figure the scripts create

## How to generate the final report

Install the R packages `haven`, `dplyr`, `srvyr`, `ggplot2`, `knitr`, and `rmarkdown`, then run this from the repository folder:

```
make report.html
```

This runs the scripts in `code/` and creates `report.html`.

## Where the table and figure are created

- Table 1: `code/02_make_table1.R`
- Figure 1: `code/03_make_figure.R`

## Report description

The report presents the survey-weighted prevalence of unmet dental care need overall 
and by insurance status (Table 1), and by insurance status and age group (Figure 1).