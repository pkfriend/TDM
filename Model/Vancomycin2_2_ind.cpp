[PROB]
- Drug : Vancomycin 
- Ref: "https://www.sciencedirect.com/science/article/abs/pii/S0924857916301911?via%3Dihub"
- Model: One compartment model with first order elimination (Early Phase)
- Covariates
- CRCL, TOXI (Co-administration of a nephrotoxic drug) on Clearance
- Weight on Central volume(V)
- Random effects: `CL`

[PARAM] @annotated 
CL    : 7.29   : Clearance of Early phase of treatment (L/h)
V1    : 81.1   : Central Volume of Early phase of treatment (L) 

[CMT] 
CENT

[MAIN]
double ke  = CL / V1;

[ODE]

dxdt_CENT = -CENT * ke;

[TABLE]

double IPRED = CENT / V1;


[CAPTURE] IPRED EVID