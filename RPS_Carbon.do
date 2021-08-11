xtset fips year
gen lnelec = ln(elec_em)


***************Log-linear Baseline**********************
***naive model1
eststo clear
xtreg lnelec rps intensity perc_adj pop fuel coal avgprice_adj i.year, fe
eststo model1

**model 2: controlling for rps strength
xtreg lnelec rps rps_str intensity perc_adj pop fuel coal rps_str avgprice_adj i.year, fe
eststo model2

**model 3: controlling for rps strength and whether neighbors have rps
xtreg lnelec rps rps_str neighbor intensity perc_adj pop fuel coal avgprice_adj i.year, fe 
eststo model3

esttab using table1.csv, se replace


*****************Endogeneity Tests*******************
eststo clear
gen rps_t = rps*year

***Test 1: RPS interacted with t***
**model 1
xtreg elec_em rps rps_t perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe 
eststo model1

**model 2
xtreg elec_em rps rps_t rps_str perc_adj pop fuel_cost coal_cost rps_str avgprice_adj i.year, fe robust
eststo model2

**model 3 
xtreg elec_em rps rps_t rps_str neighbor perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe robust
eststo model3

esttab using table2.csv, se replace

*********Test 2: Coal Price interacted with RPS*********
eststo clear

gen coal_rps = coal*rps

***model1
xtreg elec_em rps coal_rps perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe robust

eststo model1

**model2
xtreg elec_em rps coal_rps rps_str perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe robust

eststo model2

**model3
xtreg elec_em rps coal_rps rps_str neighbor perc_adj pop coal_cost fuel_cost avgprice_adj i.year, fe robust

eststo model3
esttab using table3.csv, se replace

**********Test 3: Fuel Price interacted with RPS*********

eststo clear
gen fuel_rps = fuel*rps

***model1
xtreg elec_em rps fuel_rps perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe robust

eststo model1

**model2
xtreg elec_em rps fuel_rps rps_str perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe robust

eststo model2

**model3
xtreg elec_em rps fuel_rps rps_str neighbor perc_adj pop coal_cost fuel_cost avgprice_adj i.year, fe robust

eststo model3
esttab using table4.csv, se replace




**************************RPG specification test******************************
eststo clear

***naive model
xtreg lnelec rps rpg intensity perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe
eststo model1

**model 2: controlling for rps strength
xtreg lnelec rps rpg rps_str intensity perc_adj pop fuel_cost coal_cost rps_str avgprice_adj i.year, fe
eststo model2

**model 3: controlling for rps strength and whether neighbors have rps
xtreg lnelec rps rpg rps_str neighbor intensity perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe 
eststo model3


esttab using table5.csv, se replace



**************dropping DC, Maine, Vermont**************
eststo clear

drop if state == "Vermont" | state == "DC" | state == "Maine"
**model1**

xtreg lnelec rps rpg intensity perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe
eststo model1

**model 2: controlling for rps strength
xtreg lnelec rps rpg rps_str intensity perc_adj pop fuel_cost coal_cost rps_str avgprice_adj i.year, fe
eststo model2

**model 3: controlling for rps strength and whether neighbors have rps
xtreg lnelec rps rpg rps_str intensity neighbor perc_adj pop fuel_cost coal_cost avgprice_adj i.year, fe 
eststo model3

esttab using table6.csv, se replace