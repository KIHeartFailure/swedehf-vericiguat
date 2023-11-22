# Inclusion/exclusion criteria --------------------------------------------------------

flow <- flow[1:8, ]

flow[, 1] <- str_replace_all(flow[, 1], "Remove", "Exclude")

flow <- rbind(c("General inclusion/exclusion criteria", ""), flow)

flow <- rbind(flow, c("Project specific inclusion/exclusion criteria", ""))

rsdata <- rsdata410 %>%
  filter(!is.na(shf_ef_cat))
flow <- rbind(flow, c("Exclude posts with missing EF", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_ef_cat %in% c("HFrEF"))
flow <- rbind(flow, c("Include posts with EF < 40%", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(!is.na(shf_nyha))
flow <- rbind(flow, c("Exclude posts with missing NYHA", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_nyha %in% c("II", "III", "IV"))
flow <- rbind(flow, c("Include posts with NYHA II-IV", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_location == "Out-patient" & (is.na(sos_timeprevhosphf) | sos_timeprevhosphf > 365 / 2))
flow <- rbind(flow, c("Include posts without a previous HFH within 6 months", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(!is.na(shf_durationhf))
flow <- rbind(flow, c("Exclude posts with missing duration HF", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(shf_durationhf %in% c(">6mo"))
flow <- rbind(flow, c("Include posts with duration HF > 6 months", nrow(rsdata)))

rsdata <- rsdata %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(n()) %>%
  ungroup()

flow <- rbind(flow, c("Last post / patient", nrow(rsdata)))

colnames(flow) <- c("Criteria", "N")

flow <- flow %>%
  as_tibble() %>%
  mutate(N = comma(as.numeric(N)))

rm(rsdata410)
gc()
