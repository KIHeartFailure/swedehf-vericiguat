# Additional variables from NPR -------------------------------------------

load(file = paste0(shfdbpath, "/data/", datadate, "/patregrsdata.RData"))

# Additional comorbs ------------------------------------------------------

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "hyperlipidemia",
  diakod = " E78[0-4]",
  stoptime = -5 * 365.25,
  warnings = FALSE,
  meta_reg = "NPR (in+out)",
  valsclass = "fac"
)

# Additional outcomes ------------------------------------------------------

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hospstroke",
  diakod = " I6[0-4]",
  censdate = censdtm,
  valsclass = "fac",
  meta_reg = "NPR (in)",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "counthospany",
  diakod = " ",
  censdate = censdtm,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (in)",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "ov"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "countvisit",
  diakod = " ",
  censdate = censdtm,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (out)",
  warnings = FALSE
)

# Emergency visits --------------------------------------------------------

emdata <- patregrsdata %>%
  filter(sos_source == "ov" &
    MVO %in% c("046", "100") & PVARD == "2")

rsdata <- create_sosvar(
  sosdata = emdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "countervisit",
  diakod = " ",
  censdate = censdtm,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (out)",
  warnings = FALSE
)
