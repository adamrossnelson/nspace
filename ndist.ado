*! Jan 2019 Adam Ross Nelson - Started ndist
*! Maintained at   : https://github.com/adamrossnelson

capture program drop ndist
program define ndist, rclass
    version 15.1
    suntax varlist [if] [in]
    tokenize `varlist'
    
    preserve
    
    foreach var in `varlist' {
        qui sum `var' if `1' == 1
        qui scalar `var'ctd = r(mean)
    }
    
    foreach var in `varlist' {
        qui sum `var'
        qui gen `var'sd = (`var' - r(mean)) / r(sd)
    }
    
    foreach var in `varlist' {
        gen `var'pnt = (`var' - `var'ctd)^2
    }
    
    egen float dist = rowtotal(*pnt)
    replace dist = sqrt(dist)
    
    restore
end
    
    
