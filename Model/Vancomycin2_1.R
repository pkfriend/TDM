vancomycin2_1 <- function() {
  ini({
    tvCL   <- 7.29    
    tvV1   <- 81.1
    CLCRCL <-  0.563
    
    eta.CL ~ 0.125
    
    add.err <- 1.92
    prop.err <- 0.0859
  })
  
  model({
    CL  <- tvCL * (CRCL / 113.6)^CLCRCL * 0.881^TOXI * exp(eta.CL) 
    V1  <- tvV1
    
    k10 <- CL / V1
    
    d/dt(CENT) = -k10 * CENT 
    
    
    cp = CENT / V1
    
    
    cp ~ add(add.err) + prop(prop.err)
  })
}