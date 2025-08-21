[PROB]
- Drug : Vancomycin 
- Ref: "https://www.sciencedirect.com/science/article/abs/pii/S0924857916301911?via%3Dihub"
- Model: One compartment model with first order elimination (Early Phase)
- Covariates
- CRCL, TOXI (Co-administration of a nephrotoxic drug) on Clearance
- Weight on Central volume(V)
- Random effects: `CL`

[PARAM] @annotated 
TVCL    : 7.29   : Clearance of Early phase of treatment (L/h)
TVV1    : 81.1   : Central Volume of Early phase of treatment (L) 
CLCRCL  : 0.563  : CRCL in CL

[PARAM] @annotated @covariates
CRCL : 113.6 : Creatinine clearance
TOXI : 1     : Co-administration of a nephrotoxic drug

[CMT] 
CENT

[MAIN]
double CL  = TVCL * pow(CRCL / 113.6, CLCRCL) * pow(0.881, TOXI);
double V   = TVV1;
double ke  = CL / V;

[ODE]

dxdt_CENT = -CENT * ke;

[TABLE]

double IPRED = CENT / V;


[CAPTURE] IPRED EVID