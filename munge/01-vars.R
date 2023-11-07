# Variables for baseline tables -----------------------------------------------

tabvars <- c(
  # demo
  "shf_indexyear_cat",
  "shf_sex",
  "shf_age",
  "shf_age_cat",

  # organizational
  "shf_location",
  "shf_followuphfunit",
  "shf_followuplocation_cat",

  # clinical factors and lab measurements
  "shf_ef",
  "shf_nyha",
  "shf_bmi",
  "shf_bmi_cat",
  "shf_bpsys",
  "shf_bpsys_cat",
  "shf_bpdia",
  "shf_map",
  "shf_map_cat",
  "shf_heartrate",
  "shf_heartrate_cat",
  "shf_gfrckdepi",
  "shf_gfrckdepi_cat",
  "shf_crea",
  "shf_potassium",
  "shf_potassium_cat",
  "shf_hb",
  "shf_ntprobnp",

  # treatments
  "shf_rasiarni",
  "shf_mra",
  "shf_bbl",
  "shf_sglt2",
  "shf_trippel",
  "shf_quadruple",
  "shf_digoxin",
  "shf_diuretic",
  "shf_nitrate",
  "shf_asaantiplatelet",
  "shf_anticoagulantia",
  "shf_statin",
  "shf_device_cat",

  # comorbs
  "shf_smoke",
  "shf_sos_com_diabetes",
  "shf_sos_com_hypertension",
  "shf_sos_com_ihd",
  "sos_com_mi",
  "sos_com_pad",
  "sos_com_stroketia",
  "shf_sos_com_af",
  "shf_anemia",
  "sos_com_valvular",
  "sos_com_liver",
  "sos_com_cancer3y",
  "sos_com_copd",
  "sos_com_sleepapnea",
  "sos_com_thyroidism",
  "sos_com_hyperkalemia",
  "sos_com_hyperlipidemia",
  "shf_sos_com_metabolic_syndrome",
  "sos_com_depression",
  "sos_com_charlsonci",
  "sos_com_charlsonci_cat",

  # socec
  "scb_famtype",
  "scb_child",
  "scb_education",
  "scb_dispincome",
  "shf_qol",
  "shf_qol_cat"
)

outvars <- tibble(
  var = c(
    "sos_out_death", "sos_out_deathcv", "sos_out_deathnoncv", "sos_out_hospany", "sos_out_hospcv",
    "sos_out_hospnoncv", "sos_out_hosphf", "sos_out_deathcvhosphf", "sos_out_deathhosphf",
    "sos_out_renal", "sos_out_hyperkalemia", "sos_out_syncope", "sos_out_stroke",
    "sos_out_counthosphf", "sos_out_counthospany", "sos_out_countvisit", "sos_out_countervisit"
  ),
  time = c(
    "sos_outtime_death", "sos_outtime_death", "sos_outtime_death", "sos_outtime_hospany", "sos_outtime_hospcv",
    "sos_outtime_hospnoncv", "sos_outtime_hosphf", "sos_outtime_hosphf", "sos_outtime_hosphf",
    "sos_outtime_renal", "sos_outtime_hyperkalemia", "sos_outtime_syncope", "sos_outtime_stroke",
    "sos_outtime_death", "sos_outtime_death", "sos_outtime_death", "sos_outtime_death"
  ),
  name = c(
    "All-cause death", "CV death", "Non-CV death", "First All-cause hospitalization", "First CV hospitalization",
    "First Non-CV hospitalization", "First HF hospitalization", "CV death/First HF hospitalization", "All-cause death/First HF hospitalization",
    "First Renal failure", "First Hyperkalemia", "First Syncope", "First Stroke",
    "Total HF hospitalization", "Total All-cause hospitalization", "Total All-cause outpatient visit", "Total A&E visit"
  ),
  shortname = c(
    "ACD", "CVD", "Non-CVD", "ACH", "CVH",
    "Non-CVH", "HFH", "CVD/HFH", "ACD/HFH",
    "Renal failure", "Hyperkalemia", "Syncope", "Stroke",
    "HFH", "ACH", "ACV", "A&E"
  )
) %>%
  mutate(
    order = 1:n(),
    composite = str_detect(name, "/"),
    rep = str_detect(name, "Total")
  ) %>%
  arrange(order)


metavars <- bind_rows(
  metavars,
  tibble(
    variable = c(
      "sos_com_metabolic_syndrome",
      "sos_com_hyperlipidemia",
      "sos_com_thyroidism",
      "shf_trippel",
      "shf_quadruple"
    ),
    label = c(
      "Metabolic syndrome (hyperlipidemia & hypertension & diabetes)",
      "Hyperlipidemia",
      "Thyroidism",
      "Tripple therapy",
      "Quadruple therapy"
    )
  )
)
