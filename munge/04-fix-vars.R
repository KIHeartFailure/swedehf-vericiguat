# Cut outcomes at 5 years

rsdata <- cut_surv(rsdata, sos_out_deathcvhosphf, sos_outtime_hosphf, global_followup * 365.25, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathhosphf, sos_outtime_hosphf, global_followup * 365.25, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hosphf, sos_outtime_hosphf, global_followup * 365.25, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hospany, sos_outtime_hospany, global_followup * 365.25, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hospcv, sos_outtime_hospcv, global_followup * 365.25, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hospnoncv, sos_outtime_hospnoncv, global_followup * 365.25, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathcv, sos_outtime_death, global_followup * 365.25, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathnoncv, sos_outtime_death, global_followup * 365.25, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_death, sos_outtime_death, global_followup * 365.25, cuttime = TRUE, censval = "No")

asnum <- function(x) {
  x <- if_else(x == "Yes", 1, 0)
}

rsdata <- rsdata %>%
  mutate(nmed = rowSums(across(c("shf_rasiarni", "shf_bbl", "shf_mra", "shf_sglt2"), asnum))) %>%
  mutate(
    shf_ef = droplevels(shf_ef),
    shf_age_cat = factor(
      case_when(
        shf_age < 80 ~ 1,
        shf_age >= 80 ~ 2
      ),
      levels = 1:2, labels = c("<80", ">=80")
    ),
    shf_indexyear_cat = factor(case_when(
      shf_indexyear <= 2010 ~ "2000-2010",
      shf_indexyear <= 2015 ~ "2011-2015",
      shf_indexyear <= 2018 ~ "2016-2018",
      shf_indexyear <= 2021 ~ "2019-2021"
    )),
    shf_bpsys_cat = factor(
      case_when(
        shf_bpsys < 100 ~ 1,
        shf_bpsys < 140 ~ 2,
        shf_bpsys >= 140 ~ 3
      ),
      levels = 1:3, labels = c("<100", "100-139", ">=140")
    ),
    shf_sos_com_metabolic_syndrome = factor(case_when(
      sos_com_hyperlipidemia == "Yes" &
        shf_sos_com_diabetes == "Yes" &
        shf_sos_com_hypertension == "Yes" ~ 1,
      TRUE ~ 0
    ), levels = 0:1, labels = c("No", "Yes")),
    shf_trippel = factor(
      case_when(
        is.na(shf_rasiarni) | is.na(shf_bbl) | is.na(shf_mra) ~ NA_real_,
        shf_rasiarni == "Yes" & shf_bbl == "Yes" & shf_mra == "Yes" ~ 1,
        shf_rasiarni == "Yes" & shf_bbl == "Yes" & shf_mra == "No" ~ 2,
        shf_rasiarni == "Yes" & shf_bbl == "No" & shf_mra == "Yes" ~ 3,
        shf_rasiarni == "No" & shf_bbl == "Yes" & shf_mra == "Yes" ~ 4,
        shf_rasiarni == "Yes" & shf_bbl == "No" & shf_mra == "No" ~ 5,
        shf_rasiarni == "No" & shf_bbl == "Yes" & shf_mra == "No" ~ 6,
        shf_rasiarni == "No" & shf_bbl == "No" & shf_mra == "Yes" ~ 7,
        TRUE ~ 8
      ),
      levels = 1:8, labels = c(
        "ACEi/ARB/ARNi + Beta-blocker + MRA",
        "Only ACEi/ARB/ARNi + Beta-blocker",
        "Only ACEi/ARB/ARNi + MRA",
        "Only Beta-blocker + MRA",
        "Only ACEi/ARB/ARNi",
        "Only Beta-blocker",
        "Only MRA",
        "No ACEi/ARB/ARNi, Beta-blocker, MRA"
      )
    ),
    shf_sglt2 = if_else(shf_indexdtm < ymd("2020-11-01"), NA, shf_sglt2),
    shf_quadruple = factor(
      case_when(
        is.na(shf_rasiarni) | is.na(shf_bbl) | is.na(shf_mra) | is.na(shf_sglt2) ~ NA_real_,
        shf_rasiarni == "Yes" & shf_bbl == "Yes" & shf_mra == "Yes" & shf_sglt2 == "Yes" ~ 1,
        shf_rasiarni == "Yes" & shf_bbl == "Yes" & shf_mra == "Yes" & shf_sglt2 == "No" ~ 2,
        shf_rasiarni == "Yes" & shf_bbl == "Yes" & shf_mra == "No" & shf_sglt2 == "Yes" ~ 3,
        shf_rasiarni == "Yes" & shf_bbl == "No" & shf_mra == "Yes" & shf_sglt2 == "Yes" ~ 4,
        shf_rasiarni == "No" & shf_bbl == "Yes" & shf_mra == "Yes" & shf_sglt2 == "Yes" ~ 5,
        nmed == 2 ~ 6,
        nmed == 1 ~ 7,
        nmed == 0 ~ 8
      ),
      levels = 1:8, labels = c(
        "ACEi/ARB/ARNi + Beta-blocker + MRA + SGLT2i",
        "Only ACEi/ARB/ARNi + Beta-blocker + MRA",
        "Only ACEi/ARB/ARNi + Beta-blocker + SGLT2i",
        "Only ACEi/ARB/ARNi + MRA + SGLT2i",
        "Only Beta-blocker + MRA + SGLT2i",
        "Only 2 medications",
        "Only 1 medication",
        "No ACEi/ARB/ARNi, Beta-blocker, MRA, SGLT2i"
      )
    )
  ) %>%
  select(-shf_bmiimp, -shf_bmiimp_cat)
