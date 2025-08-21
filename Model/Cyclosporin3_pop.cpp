[PROB]
- Drug : Cyclosporin 
- Ref: "https://link.springer.com/article/10.1007/s40262-013-0037-x?utm_source=chatgpt.com"
- Model: Two compartment model with first order absorption and elimination
- Covariates
- Sex on Clearance
- Random effects: `F`, `ka` `Q`, `V1`, `CL`, `Lag`
- Residual error: Combined error

[PARAM] @annotated 
TVF       : 1      : Bioavailbility  
TVKA      : 1.04   : Absroption rate constant (1/h) 
TVQ       : 26     : Intercompartmental Clearance (L/h)
TVV1      : 86.3   : Central Volume (L/h)
TVV2      : 1350   : Peripheral Volume (L/h) 
TVCL      : 25.4   : Clearance (L/L) 
TVALAG1     : 0.302  : Lag Time (h)


[PARAM] @annotated @covariates
SEX : 1   : Sex on CL


[CMT] 
DEPOT CENT PERI



[MAIN]

double F    = TVF ; 
double KA   = TVKA ;
double Q    = TVQ ;
double V1   = TVV1 ;
double V2   = TVV2;
double CL   = TVCL * pow(1.37, SEX) ;
double ALAG1 = TVALAG1;
double k12  = Q / V1;
double k21  = Q / V2;
double ke   = CL / V1;

F_DEPOT = F;

ALAG_DEPOT = ALAG1;

[ODE]
dxdt_DEPOT = -KA*DEPOT;
dxdt_CENT  = KA*DEPOT + PERI * k21 - CENT * (ke + k12);
dxdt_PERI  = CENT*k12 - PERI*k21;

[TABLE]

double IPRED = CENT / V1* 1000;

[CAPTURE]  IPRED 