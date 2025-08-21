
#input_data <- jsonlite::fromJSON("input_dataset.json")
#model_name <- "vancomycin1_1"

tdm_function <- function (input_data, model_name) {
  
  # json data에서 
  tdm_data <- input_data$dataset |> 
    as_tibble()
  
  # nlmixr2으로 POSTHOC EBE 계산
  fit <- nlmixr2(model_nlmixr[[model_name]], tdm_data, est="posthoc")
  
  # 10 반감기 계산
  halflife <- fit |> 
    distinct(k10) |> 
    mutate(k10 = log(2)/k10*10) |> 
    as_vector()
  
  # 현재 dataset에서 마지막시간 가져오기
  last_time <- max(tdm_data$TIME)
  
  # 10반감기 까지 dosing 횟수 올림 게산 
  pred_number <- ceiling( halflife/input_data$input_tau) 
  
  
  # 10반감기 포함하는 tdm data셋 생성
  covariate <- tibble(
    WT     = input_data$input_WT,
    CRCL = input_data$input_CRCL,
    AGE = input_data$input_AGE,
    SEX = input_data$input_SEX,
    TOXI = input_data$input_TOXI,
    AUC = input_data$input_AUC,
    CTROUGH = input_data$input_CTROUGH
  ) 
  
  #Population Mean Simulation 
  model_pop <- model_pop[[paste0(model_name,"_pop")]]  
  
  model_pop <- model_pop |> 
    param(covariate)
  
  #10반감기 까지 simdata 생성 
  temp <-  tdm_data[rep(1, pred_number),] |> 
    mutate(AMT = tdm_data[nrow(tdm_data),]$AMT)
  
  temp$TIME <-  seq(last_time + input_data$input_tau, last_time + input_data$input_tau*pred_number, input_data$input_tau)
  
  temp <-  tdm_data[rep(1, pred_number),] |> 
    mutate(AMT = input_data$input_amount
    )
  temp$TIME <-  seq(last_time + input_data$input_tau, last_time + input_data$input_tau*pred_number, input_data$input_tau)
  
  sim_data <- tdm_data  |> 
    bind_rows(temp) |> 
    filter(EVID ==1)
  
  
  event <- ev(amt = sim_data[sim_data$EVID==1,]$AMT, time = sim_data[sim_data$EVID==1,]$TIME)
  
  
  
  PRED_CONC <- model_pop |> 
    ev(event) |> 
    mrgsim(end = last_time+(input_data$`input_tau`*(pred_number+1)), delta = 1/60) |> 
    as_tibble() |> 
    filter(EVID ==0) |> 
    select(time, IPRED)
  
  #Individual SImulation 
  model_ind <- model_ind[[paste0(model_name,"_ind")]]  
  
  idata <- fit |>
    distinct(ID,.keep_all = TRUE) |> 
    as_tibble()
  
  model_ind <- model_ind |> 
    param(idata)
  
  IPRED_CONC <- model_ind |> 
    ev(event) |> 
    mrgsim(end = last_time+(input_data$input_tau*(pred_number+1)), delta = 1/60) |> 
    as_tibble() |> 
    filter(EVID == 0) |> 
    select(time, IPRED)
  
  tdm_clean <- tdm_data |> 
    mutate(DV = as.numeric(DV)) |> 
    filter(!is.na(DV), !is.na(TIME), is.finite(DV), is.finite(TIME))
  
   ggplot()  + geom_line(data = IPRED_CONC,aes(x = time, y = IPRED, color = "IPRED")) + geom_line(data = PRED_CONC, aes(x = time, y = IPRED, color = "PRED")) +
     geom_point(data = tdm_clean |> mutate(DV = as.double(DV)), aes(x = TIME, y = DV)) +theme_light() 
  
  # 10반감기 이후의 AUC CMAX CTROUGH 계산 로직 
  
  Result_after <- IPRED_CONC |>  
    filter(time >=max(sim_data$TIME))
  
  AUC_after <- AUC(Result_after$time, Result_after$IPRED)[nrow(Result_after),1] |> 
    as_vector()
  
  
  #CTROUGH_after <- IPRED_CONC |> 
  # filter(time == (max(sim_data$TIME)+tau)) |> 
  #  select(IPRED) |> 
  # as_vector()
  
  CTROUGH_after <- Result_after$IPRED[which(Result_after$time == max(Result_after$time))] |> 
    as_vector()
  
  
  CMAX_after  <- Result_after$IPRED[which(Result_after$IPRED == max(Result_after$IPRED))] |> 
    as_vector()
  
  # 현재의 AUC CMAX CTROUGH 계산 로직 
  
  Result_before <- IPRED_CONC |>  
    filter(time >=max(tdm_data$TIME) & time <=max(tdm_data$TIME+input_data$input_tau))
  
  AUC_before <- AUC(Result_before$time, Result_before$IPRED)[nrow(Result_before),1] |> 
    as_vector()
  
  CTROUGH_before  <- Result_before$IPRED[which(Result_before$time == max(Result_before$time))] |> 
    as_vector()
  
  
  CMAX_before  <- Result_before$IPRED[which(Result_before$IPRED == max(Result_before$IPRED))] |> 
    as_vector()
  
  
  
  output_data <- list(
    AUC_after       = unbox(AUC_after),
    CTROUGH_after   = unbox(CTROUGH_after),
    CMAX_after      = unbox(CMAX_after),
    
    AUC_before      = unbox(AUC_before),
    CTROUGH_before  = unbox(CTROUGH_before),
    CMAX_before     = unbox(CMAX_before),
    
    PRED_CONC       = PRED_CONC,
    IPRED_CONC      = IPRED_CONC
  ) |> 
    toJSON()
  
  
  # prettify(output_data) |> 
  #   write( file = "Demo/output_dataset.json")
  
  return(output_data)
  
}
