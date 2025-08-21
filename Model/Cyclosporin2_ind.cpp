[PROB]
- Drug : Cyclosporin 
- Ref: "https://journals.sagepub.com/doi/abs/10.1177/1060028015577798"
- Model: One compartment model with transit compartment
- Covariates
- WT on Clearance

[PARAM] @annotated 
CL    : 21.2   : Clearance (L/h) 
V     : 430    : Central Volume (L)
KTR   : 2.87   : Rate constant for Transit Compartment (1/h)
F1    : 0.81   : Bioavailability


[CMT] 
DEPOT TRANSIT1 TRANSIT2 CENT

[MAIN]

F_DEPOT = F1;
double KE = CL/V;


[ODE]

dxdt_DEPOT = -KTR*DEPOT;
dxdt_TRANSIT1 = KTR*DEPOT - KTR*TRANSIT1;
dxdt_TRANSIT2 = KTR*TRANSIT1 - KTR*TRANSIT2;
dxdt_CENT = KTR*TRANSIT2 - KE*CENT;

[TABLE]

double IPRED = CENT / V * 1000;

[CAPTURE]  IPRED 