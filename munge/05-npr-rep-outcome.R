# Repeated outcome for MCF figure --------------------------------------------

repoutfunc <- function(data, icd) {
  sosdata <- left_join(
    rsdata %>%
      select(
        lopnr, shf_indexdtm, censdtm
      ),
    data %>%
      select(lopnr, INDATUM, HDIA),
    by = "lopnr"
  ) %>%
    mutate(sos_outtime = as.numeric(INDATUM - shf_indexdtm)) %>%
    filter(sos_outtime > 0 & sos_outtime <= global_followup * 365.25 & INDATUM <= censdtm)

  sosdata <- sosdata %>%
    mutate(sos_out = stringr::str_detect(HDIA, icd)) %>%
    filter(sos_out) %>%
    select(-INDATUM, -HDIA)

  rsdatarep <- bind_rows(
    rsdata %>%
      select(
        lopnr, shf_indexdtm, censdtm
      ),
    sosdata
  ) %>%
    mutate(
      sos_out = if_else(is.na(sos_out), 0, 1),
      sos_outtime = as.numeric(if_else(is.na(sos_outtime), as.numeric(censdtm - shf_indexdtm), sos_outtime))
    )

  rsdatarep <- rsdatarep %>%
    group_by(lopnr, shf_indexdtm, sos_outtime) %>%
    arrange(desc(sos_out)) %>%
    slice(1) %>%
    ungroup() %>%
    arrange(lopnr, shf_indexdtm) %>%
    mutate(
      extra = 0
    )

  extrarsdatarep <- rsdatarep %>%
    group_by(lopnr) %>%
    arrange(shf_indexdtm) %>%
    slice(n()) %>%
    ungroup() %>%
    filter(sos_out == 1) %>%
    mutate(
      sos_out = 0,
      extra = 1
    )

  rsdatarep <- bind_rows(rsdatarep, extrarsdatarep) %>%
    arrange(lopnr, sos_outtime, extra) %>%
    mutate(sos_out = factor(sos_out, levels = 0:1, labels = c("No", "Yes")))
}

rsdatarephosphf <- repoutfunc(data = patregrsdata %>% filter(sos_source == "sv"), icd = global_hficd)
rsdatarephospany <- repoutfunc(data = patregrsdata %>% filter(sos_source == "sv"), icd = " ")
rsdatarepvisit <- repoutfunc(data = patregrsdata %>% filter(sos_source == "ov"), icd = " ")
rsdatarepervisit <- repoutfunc(data = emdata, icd = " ")
