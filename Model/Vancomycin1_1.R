vancomycin1_1 <- function() {
  ini({
    tvCL   <- 2.82    
    tvV1   <- 31.8 
    tvQ    <- 11.7   
    tvV2   <- 75.4    
    
    eta.CL ~ 0.6851473
    eta.V2 ~ 0.2167745
    
    prop.err <- 0.253
  })
  
  model({
    CL  <- tvCL * (CRCL/72)* exp(eta.CL)
    V1  <- tvV1
    Q   <- tvQ
    V2  <- tvV2 * (WT / 60) * exp(eta.V2)
    
    k10 <- CL / V1
    k12 <- Q / V1
    k21 <- Q / V2
    
    K <- k10
    
    d/dt(CENT) = -k10 * CENT - k12 * CENT + k21 * PERI
    d/dt(PERI) =  k12 * CENT - k21 * PERI
    
    
    cp = CENT / V1
    
    
    cp ~ prop(prop.err)
  })
}