
base  <- "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2015/DataFiles/"
files <- c("DEMO_I.XPT", "HIQ_I.XPT", "OHQ_I.XPT")

for (f in files) {
  dest <- file.path("data", f)
  if (!file.exists(dest)) {
    download.file(paste0(base, f), dest, mode = "wb")
  }
}
