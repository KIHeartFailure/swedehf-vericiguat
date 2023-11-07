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

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = DIA_all,
  type = "com",
  name = "thyroidism",
  diakod = " E0[0-7]",
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
  name = "counthospany",
  diakod = " ",
  censdate = censdtm,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (in)",
  stoptime = global_followup * 365.25,
  warnings = FALSE
)

# need to redo since end fu 5 years
rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "counthosphf",
  diakod = global_hficd,
  censdate = censdtm,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (in)",
  stoptime = global_followup * 365.25,
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
  stoptime = global_followup * 365.25,
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  opvar = OP_all,
  type = "out",
  name = "renal",
  diakod = " N1[7-9]| KAS00| KAS10| KAS20| Z491| Z492",
  opkod = " DR014| DR015| DR016| DR020| DR012| DR013| DR023| DR024| TJA33| TJA35",
  censdate = censdtm,
  valsclass = "fac",
  meta_reg = "NPR (in + out)",
  stoptime = global_followup * 365.25,
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "stroke",
  diakod = " I6[0-4]",
  censdate = censdtm,
  valsclass = "fac",
  meta_reg = "NPR (in + out)",
  stoptime = global_followup * 365.25,
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "syncope",
  diakod = " R55",
  censdate = censdtm,
  stoptime = global_followup * 365.25,
  valsclass = "fac",
  meta_reg = "NPR (in + out)",
  warnings = FALSE
)

rsdata <- create_sosvar(
  sosdata = patregrsdata,
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  name = "hyperkalemia",
  diakod = " E875",
  censdate = censdtm,
  stoptime = global_followup * 365.25,
  valsclass = "fac",
  meta_reg = "NPR (in + out)",
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
  stoptime = global_followup * 365.25,
  noof = TRUE,
  valsclass = "fac",
  meta_reg = "NPR (out)",
  warnings = FALSE
)
