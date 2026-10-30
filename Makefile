report.html: report.Rmd output/table1.rds output/figure1.png output/figure1_data.rds
	Rscript -e "rmarkdown::render('report.Rmd')"

output/table1.rds: code/02_make_table1.R data/nhanes_clean.rds
	Rscript code/02_make_table1.R

output/figure1.png output/figure1_data.rds: code/03_make_figure.R data/nhanes_clean.rds
	Rscript code/03_make_figure.R

data/nhanes_clean.rds: code/01_clean_data.R data/DEMO_I.XPT data/HIQ_I.XPT data/OHQ_I.XPT
	Rscript code/01_clean_data.R

data/DEMO_I.XPT data/HIQ_I.XPT data/OHQ_I.XPT:
	Rscript code/00_download_data.R

.PHONY: install clean
install:
	Rscript -e "install.packages(c('haven','dplyr','srvyr','ggplot2','knitr','rmarkdown'))"

clean:
	rm -f output/table1.rds output/figure1.png output/figure1_data.rds data/nhanes_clean.rds report.html
