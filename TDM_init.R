options(encoding = "UTF-8")
Sys.setlocale("LC_ALL", "ko_KR.UTF-8")

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

# nlmixr2 모델 사전 컴파일 (워밍업)
# -----------------------------------------------------------

# 사전 컴파일을 위한 최소한의 더미 데이터 생성
dummy_data <- tibble(
  ID = 1, TIME = 0, AMT = 100, EVID = 1, DV = NA,
  WT = 70, CRCL = 100, AGE = 50, SEX = 0, TOXI = 0, AUC = 0, CTROUGH = 0
) %>% 
  add_row(
    ID = 1, TIME = 12, AMT = 0, EVID = 0, DV = 10,
    WT = 70, CRCL = 100, AGE = 50, SEX = 0, TOXI = 0, AUC = 0, CTROUGH = 0
  )

# 사전 컴파일을 실행할 모델 이름 목록을 직접 정의합니다.
models_to_compile <- c(
  "vancomycin1_1", "vancomycin1_2", "vancomycin2_1", "vancomycin2_2"
)

message("지정된 nlmixr2 모델 사전 컴파일을 시작합니다. 잠시 기다려 주세요...")

# 위에서 정의한 목록을 순회하며 사전 컴파일 실행
for (model_name in models_to_compile) {
  # 요청된 모델이 model_nlmixr 리스트에 있는지 확인
  if (model_name %in% names(model_nlmixr)) {
    message(paste(" -", model_name, "모델 컴파일 중..."))
    # 불필요한 콘솔 메시지를 숨기면서 실행
    suppressMessages(
      invisible(
        nlmixr2(model_nlmixr[[model_name]], dummy_data, est = "posthoc")
      )
    )
  } else {
    # 리스트에 없는 경우 경고 메시지 출력
    warning(paste("!", model_name, "모델을 'model_nlmixr' 리스트에서 찾을 수 없습니다. 컴파일을 건너뜁니다."))
  }
}

message("✅ 지정된 모델들이 성공적으로 사전 컴파일되었습니다.")
