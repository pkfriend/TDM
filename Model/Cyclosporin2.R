cyclosporin2 <- function() {
  ini({
    
    tvCL   <- 21.2    
    tV     <- 430 
    tKTR   <- 2.87   
    tF1    <- 0.81    
    CLCRCL <- 0.836   
     
    V_WT   <- 0.419
    
    eta.CL ~ 0.149801808609
    eta.V  ~ 0.265130435087
    
    prop.err <- 0.132
    add.err  <- 35.8
  })
  
  model({
    CL  <- tvCL * (WT/70)^V_WT * exp(eta.CL)
    V   <- tV * exp(eta.V)
    KTR <- tKTR
    F1  <- tF1
    
    k10 <- CL / V
    
    d/dt(DEPOT) = -KTR*DEPOT
    d/dt(TRANSIT1) = KTR*DEPOT - KTR*TRANSIT1
    d/dt(TRANSIT2) = KTR*TRANSIT1 - KTR*TRANSIT2
    d/dt(CENT) = KTR*TRANSIT2 -k10 * CENT 
    
    f(DEPOT) = F1
    
    cp = CENT / V
    
    
    cp ~ prop(prop.err) + add(add.err)
  })
}