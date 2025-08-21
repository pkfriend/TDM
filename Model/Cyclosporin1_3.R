cyclosporin1_3 <- function() {
  ini({
    
    tK <- 0.254    
    tV2 <- 142     
    tV3 <- 236    
    tQ <- 24.9     
    tKA <- 1.09
    tD3KA <- 4.56
    tD7KA <- 1
    tF1 <- 1   
    tD3F1 <- 1.09
    tD7F1 <- 0.807
    
    V_WT <- 0.689   
    V_AGE <- -0.227
    F_AGE <- -0.293
    
    eta.K ~ 0          
    eta.V2 + eta.V3 ~ c(0.0177966951903,
                        0.042538779921 , 0.371729749518)
    eta.Q ~ 0.118063885103     
    eta.KA + eta.D3KA ~ c(1.04717863355,
                          -0.689681624541, 1.39317066506)
    eta.D7KA ~ 2.10198550611
    eta.D3F1 ~ 0.016251230506
    eta.D7F1 ~ 0.0439632954641
    
    prop.err <- 0.23   
  })
  
  model({
    
    
    K <- tK * exp(eta.K)
    V2 <- tV2 * (WT/60)^V_WT * (AGE/41.2)^V_AGE * eta.V2
    V3 <- tV3 * eta.V3
    Q <- tQ * eta.Q
    KA <- tKA * eta.KA * tD3KA * exp(eta.D3KA) * tD7KA * exp(eta.D7KA)
    F1 <- tF1 * tD3F1 * exp(eta.D3F1) * tD7F1 * (AGE/41.2)^F_AGE * exp(eta.D7F1)
    
    
    d/dt(DEPOT) = -KA*DEPOT
    d/dt(CENT) = KA*DEPOT + Q/V3*PERI - (K + Q/V2)*CENT
    d/dt(PERI) = Q/V2*CENT - Q/V3*PERI
    
    
    f(DEPOT) = F1
    
    
    IPRED = CENT/V2*1000
    
    
    IPRED ~ prop(prop.err)
  })
}