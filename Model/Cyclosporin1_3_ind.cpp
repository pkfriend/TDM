[PROB]
- Drug : Cyclosporin 
- Ref: "https://www.tandfonline.com/doi/full/10.2147/DDDT.S70595#d1e489"
- Model: Two compartment model with first order absorption and elimination (POD2)
- Covariates
- WT and AGE on Centarl Volume (V2)

[PARAM] @annotated 
K         : 0.254  : Elimination rate constant (1/h) 
V2        : 142    : Central Volume (L/h)
V3        : 236    : Peripheral Volume (L/h)
Q         : 24.9   : Intercompartmental Clearance (L/h) 
KA        : 1.09   : Initial value of ka on POD7 (1/L) 
F1        : 1      : Initial value of F1 on POD7

[CMT] 
DEPOT CENT PERI



[MAIN]

F_DEPOT = F1;

double k12 = Q / V2;
double k21 = Q / V3;
double ke  = K;

[ODE]
dxdt_DEPOT = -KA*DEPOT;
dxdt_CENT  = KA*DEPOT + PERI * k21 - CENT * (ke + k12);
dxdt_PERI  = CENT * k12 - PERI * k21;

[TABLE]

double IPRED = CENT / V2 *1000 ;

[CAPTURE]  IPRED EVID