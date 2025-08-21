[PROB]
- Drug : Cyclosporin 
- Ref: "https://www.tandfonline.com/doi/full/10.2147/DDDT.S70595#d1e489"
- Model: Two compartment model with first order absorption and elimination (POD2)
- Covariates
- WT and AGE on Centarl Volume (V2)

[PARAM] @annotated 
TVK       : 0.254  : Elimination rate constant (1/h) 
TVCOV2    : 142    : Central Volume (L/h)
TVV3      : 236    : Peripheral Volume (L/h)
TVQ       : 24.9   : Intercompartmental Clearance (L/h) 
TVINKA    : 1.09   : Initial value of ka on POD2 (1/L) 
TVINLA    : 0.811  : Initial value of ALAG1 on POD2
TVF1      : 1      : Initial value of F1 on POD2

[PARAM] @annotated @covariates
WT  : 60   : Weight on V2
AGE : 41.2 : Age on V2

[CMT] 
DEPOT CENT PERI


[MAIN]
double K     = TVK ;
double V2    = TVCOV2 * pow(WT / 60, 0.689) * pow(AGE/41.2, -0.227);
double V3    = TVV3;
double Q     = TVQ;
double KA    =TVINKA;
double ALAG1 =TVINLA;
double F     = TVF1;

F_DEPOT = F;
ALAG_DEPOT = ALAG1;

double k12 = Q / V2;
double k21 = Q / V3;
double ke  = K;

[ODE]
dxdt_DEPOT = -KA*DEPOT;
dxdt_CENT  = KA*DEPOT + PERI * k21 - CENT * (ke + k12);
dxdt_PERI  = CENT * k12 - PERI * k21;

[TABLE]

double IPRED = CENT / V2 * 1000;

[CAPTURE]  IPRED EVID