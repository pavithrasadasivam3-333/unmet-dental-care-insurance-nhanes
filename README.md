# Health Insurance and Unmet Dental Care Need, NHANES 2015-2016

This is my final project for DATA 550. It asks whether adults aged 20 and older without health
insurance are more likely to report unmet dental care need, using NHANES 2015-2016 data.

## Files

- `report.Rmd`: the final report. It reads the table and figure made by the scripts.
- `report.html`: the finished report.
- `Makefile`: the commands to build the report and install the packages.
- `renv.lock` and `renv/`: the list of R packages and versions used (made with the renv package).
- `code/`: the R scripts.
- `data/`: the NHANES data files and the cleaned data.
- `output/`: the table and figure made by the scripts.

## What you need

R, make, Pandoc (it comes with RStudio), and an internet connection.

## How to make the report

Open a terminal in the project folder, then:

1. Get the project:

   ```
   git clone https://github.com/pavithrasadasivam3-333/unmet-dental-care-insurance-nhanes.git
   cd unmet-dental-care-insurance-nhanes
   ```

2. Install the packages:

   ```
   make install
   ```

3. Make the report:

   ```
   make report.html
   ```

   This downloads the data, runs the scripts in `code/`, and creates `report.html`. Open that file
   in a web browser.

To start over, run `make clean` and then `make report.html`.

## How to install the same packages (renv)

The packages and their versions are saved in `renv.lock`. To install them, run this in the
project folder:

```
make install
```

This runs `renv::restore()`, which reads `renv.lock` and installs those packages. If you add or
update a package later, run `renv::snapshot()` in R to update `renv.lock`.

## Where the table and figure come from

- Table 1: `code/02_make_table1.R` (saves `output/table1.rds`)
- Figure 1: `code/03_make_figure.R` (saves `output/figure1.png` and `output/figure1_data.rds`)

The other scripts are `code/00_download_data.R`, which downloads the data, and
`code/01_clean_data.R`, which merges the files and creates the variables.

## Data

Public NHANES 2015-2016 files from the CDC (https://wwwn.cdc.gov/nchs/nhanes): `DEMO_I.XPT`
(demographics), `HIQ_I.XPT` (health insurance) and `OHQ_I.XPT` (oral health). The cleaned data,
`data/nhanes_clean.rds`, is made by `code/01_clean_data.R`.

## About the report

The report gives the question and the data, then shows Table 1 (the share of adults with unmet
dental care need, overall and by insurance status) and Figure 1 (the same by insurance status and
age group, 20-64 and 65+). All estimates use the NHANES weights, strata and primary sampling units.
