# TDM (치료적 약물 모니터링) 시뮬레이션

mrgsolve를 사용한 치료적 약물 모니터링 시뮬레이션 프레임워크입니다.

## 요구사항

- R (4.0+)
- Rtools (Windows)
- mrgsolve 패키지

## 사용법

### 1단계: 모델 컴파일 및 RDS 생성

```r
source("Model_rds.R")
```

**Model_rds.R의 역할:**
- C++ 모델을 mrgsolve로 컴파일
- 컴파일된 모델을 RDS 파일로 저장
- soloc를 통해 DLL 파일을 현재 작업디렉터리(getwd())에 생성

**왜 필요한가?**
- mrgsolve는 C++ 모델을 매번 컴파일하면 시간이 오래 걸림
- 미리 컴파일된 모델을 RDS로 저장하여 재사용 효율성 증대
- DLL 파일을 로컬에 저장하여 빠른 모델 로딩 가능

### 2단계: 환경 초기화 및 시뮬레이션

```r
source("TDM_init.R")      # 환경 설정
source("tdm_function.R")  # 메인 함수 로드
```

**TDM_init.R의 역할:**
- 1단계에서 생성된 RDS 파일 로드
- 필요한 R 패키지 로드
- getwd()에 위치한 DLL 파일들을 mrgsolve가 인식하도록 설정

**soloc를 getwd()에 위치시키는 이유:**
- mrgsolve는 현재 작업디렉터리에서 DLL을 자동 검색
- 경로 설정 없이 바로 모델 사용 가능
- 다른 경로에 있으면 수동으로 경로 지정 필요

**tdm_function.R:**
- 실제 TDM 시뮬레이션을 수행하는 메인 함수들 포함

## 실행 예시

### R 통합 실행
```r
setup_tdm <- function() {
  source("Model_rds.R")     # 모델 컴파일
  source("TDM_init.R")      # 환경 설정
  source("tdm_function.R")  # 함수 로드
  cat("TDM 설정 완료!\n")
}

setup_tdm()
```

### Python 실행
```python
import subprocess

def setup_tdm():
    scripts = ["Model_rds.R", "TDM_init.R", "tdm_function.R"]
    for script in scripts:
        subprocess.run(["Rscript", script], check=True)
    print("TDM 설정 완료!")

setup_tdm()
```

## 작업 흐름

1. **Model_rds.R** → 모델 컴파일 → RDS + DLL 생성
2. **TDM_init.R** → RDS 로드 + 환경 설정
3. **tdm_function.R** → 시뮬레이션 함수 사용

## 주의사항

- 1단계는 모델 변경 시에만 재실행
- 2단계는 새 R 세션마다 실행 필요
- DLL 파일은 반드시 작업 디렉터리에 위치
