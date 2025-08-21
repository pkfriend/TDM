cyclosporin1_1 <- function() {
  ini({
    
    tK <- 0.254    
    tV2 <- 142     
    tV3 <- 236    
    tQ <- 24.9     
    tKA <- 1.09   
    tALAG1 <- 0.811 
    tF1 <- 1   
    
    
    V_WT <- 0.689   
    V_AGE <- -0.227 
    
    eta.K ~ 0          
    eta.V2 + eta.V3 ~ c(0.0177966951903, 
                        0.042538779921 , 0.371729749518)
    eta.Q ~ 0.118063885103     
    eta.KA ~ 1.04717863355     
    eta.ALAG1 ~ 0    
    
    
    prop.err <- 0.23
  })
  
  model({
    
    
    K <- tK * exp(eta.K)
    V2 <- tV2 * (WT/60)^V_WT * (AGE/41.2)^V_AGE * exp(eta.V2)
    V3 <- tV3 * exp(eta.V3)
    Q <- tQ * exp(eta.Q)
    KA <- tKA * exp(eta.KA)
    ALAG1 <-tALAG1 * exp(eta.ALAG1)
    F1 <- tF1
    
    
    d/dt(DEPOT) = -KA*DEPOT
    d/dt(CENT) = KA*DEPOT + Q/V3*PERI - (K + Q/V2)*CENT
    d/dt(PERI) = Q/V2*CENT - Q/V3*PERI
    
    
    alag(DEPOT) = ALAG1
    f(DEPOT) = F1
    
    
    IPRED = CENT/V2*1000
    
    
    IPRED ~ prop(prop.err)
  })
}