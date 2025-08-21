[PROB]
- Drug : Vancomycin 
- Ref: "https://www.mdpi.com/1999-4923/11/5/224"
- Model: Two compartment model with first order elimination (Patients without CRRT)
- Covariates
- CRCL on Clearance
- Weight on Peripheral volume(V2)
- Random effects: `CL`, `V2`
- Residual error: Proportional error


[PARAM] @annotated 
TVCL    : 2.82   : Clearance with no CRRT and HD (L/h)
TVV1    : 31.8   : Central Volume (L) 
TVQ     : 11.7   : Intercompartmental Clearance (L/h) 
TVV2    : 75.4   : Peripheral Volume (L) 
CLCRCL  : 0.836  : CRCL in CL

[PARAM] @annotated @covariates
CRCL : 72 : Creatinine clearance
WT   : 60 : Body weight

[CMT] 
CENT PERI

[MAIN]

double CL  = TVCL * pow(CRCL / 72, CLCRCL) ;
double V1  = TVV1;
double Q   = TVQ;
double V2  = TVV2 * (WT / 60);
double k12 = Q / V1;
double k21 = Q / V2;
double ke  = CL / V1;

[ODE]

dxdt_CENT = PERI * k21 - CENT * (ke + k12);
dxdt_PERI = CENT * k12 - PERI * k21;

[TABLE]

double IPRED = (CENT / V1);

[CAPTURE] IPRED EVID