# report
library(rmarkdown)
library(kableExtra)

# data import/export
library(haven)
library(openxlsx)
# library(xlsx)

# general dm
library(purrr)
library(dplyr)
library(tidyr)
library(tibble)
library(stringr)
library(lubridate)
library(forcats)
library(hfmisc)
library(here)

# desk stat
library(tableone)

# plots
library(ggplot2)
library(gridExtra)
library(ggrepel)
library(patchwork)
library(scales)

# outcomes
library(survival)
library(cmprsk)
library(epitools)
library(MASS) # neg bin regression
library(survminer) # check assumptions
library(EValue)
library(reda) # for MCF (repeated events)

# imputation
library("mice")
library("miceadds")
library("parallel")
library("doParallel")
library("foreach")