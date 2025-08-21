library(mrgsolve)
library(tidyverse)
library(nlmixr2)

#Vancomycin ----

source("Vancomycin1_1.R")
source("Vancomycin1_2.R")
source("Vancomycin2_1.R")
source("Vancomycin2_2.R")

vancomycin <- list(
  vancomycin1_1 = vancomycin1_1,
  vancomycin1_2 = vancomycin1_2,
  vancomycin2_1 = vancomycin2_1,
  vancomycin2_2 = vancomycin2_2
)

vancomycin_ind <- list(
  vancomycin1_1_ind = mread_cache("Vancomycin1_1_ind.cpp", soloc = getwd()),
  vancomycin1_2_ind = mread_cache("Vancomycin1_2_ind.cpp", soloc = getwd()),
  vancomycin2_1_ind = mread_cache("Vancomycin2_1_ind.cpp", soloc = getwd()),
  vancomycin2_2_ind = mread_cache("Vancomycin2_2_ind.cpp", soloc = getwd())
)

vancomycin_pop <- list(
  vancomycin1_1_pop = mread_cache("Vancomycin1_1_pop.cpp", soloc = getwd()),
  vancomycin1_2_pop = mread_cache("Vancomycin1_2_pop.cpp", soloc = getwd()),
  vancomycin2_1_pop = mread_cache("Vancomycin2_1_pop.cpp", soloc = getwd()),
  vancomycin2_2_pop = mread_cache("Vancomycin2_2_pop.cpp", soloc = getwd())
)


saveRDS(vancomycin, file = "vancomycin_nlmixr2.rds")
saveRDS((vancomycin_ind), "vancomycin_ind.rds")
saveRDS((vancomycin_pop), "vancomycin_pop.rds")

#Cyclosporin ----

source("Cyclosporin1_1.R")
source("cyclosporin1_2.R")
source("Cyclosporin1_3.R")
source("Cyclosporin2.R")
source("Cyclosporin3.R")

cyclosporin <- list(
  cyclosporin1_1 = cyclosporin1_1 ,
  cyclosporin1_2 =cyclosporin1_2 ,
  cyclosporin1_3 = cyclosporin1_3 ,
  cyclosporin2 = cyclosporin2,
  cyclosporin3 = cyclosporin3
)




cyclosporin_ind <- list(
  cyclosporin1_1_ind = mread_cache("cyclosporin1_1_ind.cpp", soloc = getwd()),
  cyclosporin1_2_ind = mread_cache("cyclosporin1_2_ind.cpp", soloc = getwd()),
  cyclosporin1_3_ind = mread_cache("cyclosporin1_3_ind.cpp", soloc = getwd()),  
  cyclosporin2_ind = mread_cache("cyclosporin2_ind.cpp", soloc = getwd()),
  cyclosporin3_ind = mread_cache("cyclosporin3_ind.cpp", soloc = getwd())
)

cyclosporin_pop <- list(
  cyclosporin1_1_pop = mread_cache("cyclosporin1_1_pop.cpp", soloc = getwd()),
  cyclosporin1_2_pop = mread_cache("cyclosporin1_2_pop.cpp", soloc = getwd()),
  cyclosporin1_3_pop = mread_cache("cyclosporin1_3_pop.cpp", soloc = getwd()),  
  cyclosporin2_pop = mread_cache("cyclosporin2_pop.cpp", soloc = getwd()),
  cyclosporin3_pop = mread_cache("cyclosporin3_pop.cpp", soloc = getwd())
)



saveRDS(cyclosporin, file = "cyclosporin_nlmixr2.rds")
saveRDS(cyclosporin_ind, "cyclosporin_ind.rds")
saveRDS(cyclosporin_pop, "cyclosporin_pop.rds")