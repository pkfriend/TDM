cyclosporin3 <- function() {
  ini({
    
    tF     <- 1    
    tKA    <- 1.04 
    tQ     <- 26   
    tV1    <- 86.3    
    tV2    <- 1350
    tCL    <- 25.4
    tALAG  <- 0.302 

    eta.F     ~ 0.020807024681
    eta.K     ~ 0.170384762562
    eta.Q     ~ 0.145671403585
    eta.V1    ~ 0.123141100002
    eta.CL    ~ 0.0188649328962
    eta.ALAG  ~ 0.267670163258  
    
    add.err  <- 12.4
    prop.err <- 0.258
    
  })
  
  model({
    
    F1    <- tF * exp(eta.F)
    KA   <- tKA * exp(eta.KA)
    Q    <- tQ * exp(eta.Q)
    V1   <- tV1 * exp(eta.V1)
    V2   <- tV2 * exp(eta.V2)
    CL   <- tvCL * 1.37^SEX * exp(eta.CL)
    ALAG1 <- tALAG * exp(eta.ALAG)
    
    
    k10 <- CL / V1
    k12 <- Q/V1
    k21 <- Q/V2
    
    d/dt(DEPOT) = -KA*DEPOT
    d/dt(CENT) = KA*DEPOT -k10 * CENT -k12*CENT + k21*PERI
    d/dt(PERI) = k12*CENT - k21*PERI
    
    alag(DEPOT) = ALAG1
    f(DEPOT) = F1
    
    
    cp = CENT / V1
    
    
    cp ~ add(add.err) + prop(prop.err)
  })
}