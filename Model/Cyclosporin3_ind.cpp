[PROB]
- Drug : Cyclosporin 
- Ref: "https://link.springer.com/article/10.1007/s40262-013-0037-x?utm_source=chatgpt.com"
- Model: Two compartment model with first order absorption and elimination
- Covariates
- Sex on Clearance
- Random effects: `F`, `ka` `Q`, `V1`, `CL`, `Lag`
- Residual error: Combined error

[PARAM] @annotated 
F1        : 1      : Bioavailbility  
KA      : 1.04   : Absroption rate constant (1/h) 
Q       : 26     : Intercompartmental Clearance (L/h)
V1      : 86.3   : Central Volume (L/h)
V2      : 1350   : Peripheral Volume (L/h) 
CL      : 25.4   : Clearance (L/L) 
ALAG1     : 0.302  : Lag Time (h)


[CMT] 
DEPOT CENT PERI


[MAIN]
double k12  = Q / V1;
double k21  = Q / V2;
double ke   = CL / V1;

F_DEPOT = F1;
ALAG_DEPOT = ALAG1;

[ODE]
dxdt_DEPOT = -KA*DEPOT;
dxdt_CENT  = KA*DEPOT + PERI * k21 - CENT * (ke + k12);
dxdt_PERI  = CENT*k12 - PERI*k21;

[TABLE]

double IPRED = CENT / V1* 1000;

[CAPTURE]  IPRED 