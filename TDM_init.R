library(rxode2)
library(nlmixr2)
library(tidyverse)
library(mrgsolve)
library(NonCompart)


vancomycin_nlmixr <- readRDS("Model/vancomycin_nlmixr2.rds")
cyclosporin_nlmxir <- readRDS("Model/cyclosporin_nlmixr2.rds")
model_nlmixr <- c(vancomycin_nlmixr, cyclosporin_nlmxir)

vancomycin_pop <- readRDS("Model/vancomycin_pop.rds")
cyclosporin_pop <- readRDS("Model/cyclosporin_pop.rds")
model_pop <- c(vancomycin_pop, cyclosporin_pop)

vancomycin_ind <- readRDS("Model/vancomycin_ind.rds")
cyclosporin_ind <- readRDS("Model/cyclosporin_ind.rds")
model_ind <- c(vancomycin_ind,cyclosporin_ind)
