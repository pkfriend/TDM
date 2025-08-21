cyclosporin1_2 <- function() {
  ini({
    
    tK <- 0.254    
    tV2 <- 142     
    tV3 <- 236    
    tQ <- 24.9     
    tKA <- 1.09
    tD3KA <- 4.56
    tALAG1 <- 0.811
    tD3LA <- 1.15
    tF1 <- 1   
    tD3F1 <- 1.09
    
    V_WT <- 0.689   
    V_AGE <- -0.227 
    
    eta.K ~ 0          
    eta.V2 + eta.V3 ~ c(0.0177966951903,
                        0.042538779921 , 0.371729749518)
    eta.Q ~ 0.118063885103     
    eta.KA + eta.D3KA ~ c(1.04717863355,
                          -0.689681624541 ,1.39317066506)
    eta.ALAG1 ~ 0  
    eta.D3LA ~ 0
    eta.D3F1 ~ 0.016251230506
  
    prop.err <- 0.23   
  })
  
  model({
    
    
    K <- tK * exp(eta.K)
    V2 <- tV2 * (WT/60)^V_WT * (AGE/41.2)^V_AGE * eta.V2
    V3 <- tV3 * eta.V3
    Q <- tQ * eta.Q
    KA <- tKA * eta.KA * tD3KA * exp(eta.D3KA)
    ALAG1 <-tALAG1 * eta.ALAG1 * tD3LA * exp(eta.D3LA)
    F1 <- tF1 * tD3F1 * exp(eta.D3F1)
    
    
    d/dt(DEPOT) = -KA*DEPOT
    d/dt(CENT) = KA*DEPOT + Q/V3*PERI - (K + Q/V2)*CENT
    d/dt(PERI) = Q/V2*CENT - Q/V3*PERI
    
    
    alag(DEPOT) = ALAG1
    f(DEPOT) = F1
    
    
    IPRED = CENT/V2*1000
    
    
    IPRED ~ prop(prop.err)
  })
}