# Health Insurance and Unmet Dental Care Need, NHANES 2015-2016

Final project for DATA 550 (Emory University). The report asks whether lack of health
insurance is associated with unmet dental care need among U.S. adults aged 20+.

## Contents

| Path | What it is |
|---|---|
| `report.Rmd` | The final report (R Markdown). It only reads the table and figure created by the scripts. |
| `report.html` | The compiled report. |
| `Makefile` | Rules that build the report and restore the packages (`make install`). |
| `renv.lock`, `renv/` | The package environment (renv). |
| `code/` | R scripts that download, clean and summarize the data. |
| `data/` | NHANES 2015-2016 files (public data) and the cleaned data. |
| `output/` | The table and figure created by the scripts. |

## How to generate the final report

1. Install R and `make`. Open a terminal in the repository folder.
2. Restore the package environment (see the next section): `make install`
3. From the repository folder, run:

   ```
   make report.html
   ```

   This runs the scripts in order and then renders `report.Rmd` to `report.html`.
4. To start over, run `make clean` and then `make report.html` again.

## How to synchronize the package repository

The packages and their versions are recorded with the [renv](https://rstudio.github.io/renv/) package
in `renv.lock`. To install the same package versions on your computer:

1. Open R or a terminal in the repository folder.
2. Run:

   ```
   make install
   ```

   This runs `renv::restore()`, which reads `renv.lock` and installs the listed packages into the
   project library (the `renv/` folder). If `renv` is not installed yet, it is installed first the
   first time R starts in this folder.
3. If you add or update a package, run `renv::snapshot()` in R to update `renv.lock`.

## Where the table and figure are created

- **Table 1:** `code/02_make_table1.R` (saves `output/table1.rds`)
- **Figure 1:** `code/03_make_figure.R` (saves `output/figure1.png` and `output/figure1_data.rds`)

Other scripts: `code/00_download_data.R` (downloads the NHANES files),
`code/01_clean_data.R` (merges the files and creates the variables).

## Data

Public NHANES 2015-2016 files from the CDC/NCHS (https://wwwn.cdc.gov/nchs/nhanes):
`DEMO_I.XPT` (demographics), `HIQ_I.XPT` (health insurance), `OHQ_I.XPT` (oral health).
`data/nhanes_clean.rds` is created by `code/01_clean_data.R`.

## Report description

The report introduces the question and data, then presents Table 1 (survey-weighted prevalence of
unmet dental care need overall and by insurance status) and Figure 1 (the same prevalence by
insurance status and age group 20-64 vs 65+), with a written description of each. All estimates
use the NHANES survey weights, strata and primary sampling units.
