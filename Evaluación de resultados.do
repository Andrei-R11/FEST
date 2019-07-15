/*********************************************EVALUACIÓN DE RESULTADOS*******************************************/
{
cd "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados FEST\"
*cd "C:\Users\andre\OneDrive\CEDE\Evaluación Resultados FEST\"
use "Encuesta Hogares Colombia FINAL hog+per_sisben_180219", clear
**GLOBALS**
global varTrabajo horasTotales horasSecu horasPrin 
global varIngHog ingTotal ingRent ingAyuFam ingPenDivo ingAgro ingNoAgro ingMFApam ingOtros
*global varPobreza pobreza pobreza_extrema IPMgeneral pcan 
global varAct valActHog valActEspPe valActEspGra valActPro valActIn implementos_cuanto
global  c08_productos_agricolas c019_productos_pecuarios  c38_huerta
*global varProduc2 canAgriHo canAgriHoLi canPerHo canPerHoLi canPerHoAv canPerHoCe canPerHoHu canPerHoGa canOcHo canOcHoLi canOcHoAv canOcHoCe canOcHoHu canOcHoGa 
global varSegAli escInsegAli seguridadMenor seguridadNiño seguridadMenoryNiño seguridadHogar seguridadAdulto gastAlimenAuto punELCSA_1 punELCSA_2 punELCSA_3 punELCSA_4
*global varSegAli2 j1_alimentos_preocupacion j2_sin_alimentos j3_alimentacion_saludable j4_variedad_alimentos j5_dejar_comida j6_comio_menos_debia j7_hambre_no_comio j8_comer_una_vez_o_no j9_pedir_limosna j11_menor_saludable j12_menor_variedad j13_menor_comida j14_menor_comio_debia j15_menor_cantidad_comida j16_menor_hambre j17_menor_comio_una_o_no nutrMen5 sinComMen5
global varAhorroCred ahorPreFormal presenInformal credPreFormal credPreInformal
global varValAhoCred  credFormal credInformal  ahorroInformal
*global varAhorroCred2 si_no_empresa si_no_jefe si_no_tienda si_no_gota_gota si_no_casa_empeno si_no_prestamista si_no_almacen si_no_servicios_publicos si_no_fondo_empleados
*global varAhorroCred3 si_no_efectivo si_no_alcancias si_no_efectivo_extranjera si_no_cadenas_fondos si_no_prestamos_personas si_no_amigos_parientes si_no_patron_jefe si_no_mate_constru si_no_joyas si_no_animales_domesticos
*global varConsumo gastTotal gastDiver2 gastTrans2 gastEdu gastOtros gastServi gastSalud gastAnua gastSinAlimen gastAlimen2
global varEmpod escalRoles decisiones
global varAspyExp lagAsp5 lagExp5 lagAsp2 lagExp2 escBnstar expBnstar5 expBnstar2 aspBnstar5 aspBnstar2 
global varAspyExp2 agencia locInter locPow locChance
global varCapSocial ssc1 ssc2 ssc3 ssc4 SSC csc1 csc2 CSC m7_proyectos_comunitarios m9_participo_proyecto
*global varUNIDOS  estudioPromedioHogar e25_problema_salud programas privacion7 privacion3 preMejorHo
*Variables progrmas*
label var programas "Número de programas por hogar excluyendo FeA, FEST y Red UNIDOS"
label var programas2 "Número de programas por hogar excluyendo FEST"
label var programas4 "Número de programas por hogar excluyendo FEST y Red UNIDOS"
}
/*********************************************Regresiones********************************************************/
{
/*******************************Original************************************************/
{
**EVALUACIÓN FEST VS NO FEST**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 D PUNTAJEsisben IPMgeneral sexo_jefe programas2  gastAlimen2 tenencia1 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Bgeneral_150rep_personas.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVALUACIÓN Y_fest|u=0**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_fest PUNTAJEsisben IPMgeneral sexo_jefe gastAlimen2  programas4 region tenencia1, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_FEST_U_0_150rep_personas.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVALUACIÓN Y_unidos| fest=0**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_unidos PUNTAJEsisben IPMgeneral programas4  edad_jefe arHo tenencia1 porcenReubi region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_UNIDOS_FEST_0_150rep_personas.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVUALUACIÓN Y_unidos*fest**
set seed 72049123	
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_unidos_fest PUNTAJEsisben IPMgeneral sexo_jefe edad_jefe programas4 personas_hogar region ///
		tenencia1 porCul , outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_FEST_UNIDOS_150rep_personas.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
}
/*******************************Nueva especificación************************************/
{
**EVALUACIÓN FEST VS NO FEST**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 D PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Bgeneral_Nueva_Especificacion.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVALUACIÓN Y_fest|u=0**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_fest PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_FEST_U_0_Nueva_Especificacion.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVALUACIÓN Y_unidos| fest=0**
set seed 72049123
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_unidos PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_UNIDOS_FEST_0_Nueva_Especificacion.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
**EVUALUACIÓN Y_unidos*fest**
set seed 72049123	
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  

	cap noi bootstrap r(att), reps(150): psmatch2 Y_unidos_fest PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_FEST_UNIDOS_Nueva_Especificacion.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}
}
/*******************************Cambio FEST/Cambio UNIDOS*******************************/
{

*Cambio en FEST/Cambio en UNIDOS*
set seed 72049123	
	foreach Z in varTrabajo varIngHog varAct varProduc varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
	foreach var of global `Z' {  
	
	cap noi bootstrap r(att), reps(150): psmatch2 Y_unidos PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Y_UNIDOS_FEST_0_Nueva_Especificacion.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")
}
}	

}
}
/*********************************************Pruebas de Robustez************************************************/
{
**DPROBIT INCLUYENDO PSCORE COMO VARIABLE EXPLICATIVA**
dprobit D PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 tenencia1 region
predict pscore, pr
dprobit D pscore  PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 tenencia1 region
outreg2 using "Bootstrap\Bgeneral_EI2_kernel120319_predict.xls"

**PRUEBA DE ROBUSTEZ PUNTAJE SISBEN V2**
set seed 72049123
foreach var of varlist PUNTAJEsisben {  

	cap noi bootstrap r(att), reps(150): psmatch2 D IPMgeneral sexo_jefe programas2 gastAlimen2 personas_hogar tenencia1 region, ///
		outcome(`var') kernel com
	matrix tabla = r(table)
	local pvalue = tabla[4,1]
	outreg2 using "Bootstrap\Bgeneral_EI2_kernelSISBEN_NoPersonas.xls", addstat("p-value",`pvalue',"Observations",e(N)) ctitle("`var'")

}
**EVALUACIÓN FEST VS NO FEST (K-VECINOS MÁS CERCANOS)**
foreach Z in varTrabajo varIngHog varAct varProduc  varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial {
foreach var of global `Z' {
	psmatch2 D PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 personas_hogar tenencia1 region, ///
		outcome(`var') n(1) com
	outreg2 using "Bootstrap\Bgeneral_EI2_KVECINOS_ROBUSTEZ.xls"
}
}
**EVALUACIÓN Y_fest|u=0 (K-VECINOS MÁS CERCANOS)**
foreach Z in varTrabajo varIngHog varAct varProduc  varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
foreach var of global `Z' {  
	psmatch2 Y_fest PUNTAJEsisben IPMgeneral sexo_jefe gastAlimen2 programas4  region tenencia1, ///
		outcome(`var') n(1) com
	outreg2 using "Bootstrap\Y_FEST_U_0_KVECINOS_ROBUSTEZ2.xls"
}
}
**EVALUACIÓN Y_unidos| fest=0 (K-VECINOS MÁS CERCANOS)**
foreach Z in  varTrabajo varIngHog varAct varProduc  varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
foreach var of global `Z' {  
	psmatch2 Y_unidos PUNTAJEsisben IPMgeneral programas4 edad_jefe arHo tenencia1  porcenReubi region, ///
		outcome(`var') n(1) com
	outreg2 using "Bootstrap\Y_UNIDOS_FEST_0_KVECINOS_ROBUSTEZ2.xls"
}
}
**EVUALUACIÓN Y_unidos*fest (K-VECINOS MÁS CERCANOS)**
foreach Z in varTrabajo varIngHog varAct varProduc  varSegAli varAhorroCred varValAhoCred varEmpod varAspyExp varAspyExp2 varCapSocial{
foreach var of global `Z' {  
	psmatch2 Y_unidos_fest PUNTAJEsisben IPMgeneral sexo_jefe edad_jefe programas4  region ///
		tenencia1 porCul , outcome(`var') n(1) com
	outreg2 using "Bootstrap\Y_FEST_UNIDOS_KVECINOS_ROBUSTEZ2.xls"
}
}

}
/*********************************************Prueba de medias***************************************************/
{
use "Encuesta Hogares Colombia FINAL hog+per_sisben_180219", clear

*Diferencia de medias por pertenencia a UNIDOS y MFA

global descrip PUNTAJEsisben edad_jefe sexo_jefe edad_media educ_jefe ocupado_jefe personas_hogar ///
	personas18Men pobreza_monetaria2 IPMgeneral valActHog programas2 region gastAlimen2 tenencia1 c0_predios_hogar arHo porCul porGa
global varTrabajo horasTotales horasSecu horasPrin 
global varIngHog ingTotal ingRent ingAyuFam ingPenDivo ingAgro ingNoAgro ingMFApam ingOtros
global varPobreza pobreza IPMgeneral pcan
global varAct valActHog valActEspPe valActEspGra valActPro valActIn implementos_cuanto
global varProduc c08_productos_agricolas c019_productos_pecuarios  c38_huerta
global varSegAli escInsegAli
global varAhorroCred ahorPreFormal presenInformal credPreFormal credPreInformal
global varValAhoCred  credFormal credInformal ahorroFormal ahorroInformal
global varConsumo gastTotal gastDiver2 gastTrans2 gastEdu gastOtros gastServi gastSalud gastAnua gastSinAlimen gastAlimen2
global varEmpod escalRoles decisiones
global varAspyExp lagAsp5 lagExp5 lagAsp2 lagExp2 escBnstar expBnstar5 expBnstar2 aspBnstar5 aspBnstar2 
global varCapSocial ssc1 ssc2 ssc3 ssc4 SSC csc1 csc2 CSC m7_proyectos_comunitarios m9_participo_proyecto
global varUNIDOS  estudioPromedioHogar e25_problema_salud programas privacion7 privacion3 preMejorHo
**FeA vs No FeA**
foreach var of global descrip {
reg `var' recibio_subsidio_mfa
sum `var' if recibio_subsidio_mfa == 1 & e(sample)
local m1 = r(mean) 
local m2 = r(sd) 
sum `var' if recibio_subsidio_mfa == 0 & e(sample)
local m3 = r(mean) 
local m4 = r(sd) 
outreg2 using "diff_FeA.xls", addstat("Media1",`m1',"Media2",`m3', "sd1",`m2',"sd2",`m4') ctitle("`var'")
}
**FEST vs No FEST**
foreach var of global descrip {
reg `var' D
sum `var' if D == 1 & e(sample)
local m1 = r(mean) 
local m2 = r(sd) 
sum `var' if D == 0 & e(sample)
local m3 = r(mean) 
local m4 = r(sd) 
outreg2 using "diff_FEST.xls", addstat("Media1",`m1',"Media2",`m3', "sd1",`m2',"sd2",`m4') ctitle("`var'")
}
**Y_fest|u=0**
foreach var of global descrip {
reg `var' Y_fest
sum `var' if Y_fest == 1 & e(sample)
local m1 = r(mean) 
local m2 = r(sd) 
sum `var' if Y_fest == 0 & e(sample)
local m3 = r(mean) 
local m4 = r(sd) 
outreg2 using "diff_FESTU=0.xls", addstat("Media1",`m1',"Media2",`m3', "sd1",`m2',"sd2",`m4') ctitle("`var'")
}
**Y_unidos| fest=0**
foreach var of global descrip {
reg `var' Y_unidos
sum `var' if Y_unidos == 1 & e(sample)
local m1 = r(mean) 
local m2 = r(sd) 
sum `var' if Y_unidos == 0 & e(sample)
local m3 = r(mean) 
local m4 = r(sd) 
outreg2 using "diff_UFEST=0.xls", addstat("Media1",`m1',"Media2",`m3', "sd1",`m2',"sd2",`m4') ctitle("`var'")
}
**Y_unidos*fest**
foreach var of global descrip {
reg `var' Y_unidos_fest
sum `var' if Y_unidos_fest == 1 & e(sample)
local m1 = r(mean) 
local m2 = r(sd) 
sum `var' if Y_unidos_fest == 0 & e(sample)
local m3 = r(mean) 
local m4 = r(sd) 
outreg2 using "diff_FESTyU.xls", addstat("Media1",`m1',"Media2",`m3', "sd1",`m2',"sd2",`m4') ctitle("`var'")
}

}
/*********************************************Probabilidad de tratamiento****************************************/
{
*******************************ORIGINAL*******************************************

{
*1. FEST vs No FEST*	
	dprobit D PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 region tenencia1
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if D==0
	scalar max_control=r(max)
	replace pscore_sc=. if D==1 & pscore_sc>max_control
		
	sum pscore_sc if D==1
	scalar min_trat=r(min)
	replace pscore_sc=. if D==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if D==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if D==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST" 2 "No FEST")) 
	graph twoway (histogram pscore_sc if D==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST" 2 "No FEST" ))
*2. FEST | U=0
	dprobit Y_fest PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 region tenencia1
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_fest==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_fest==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_fest==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_fest==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_fest==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_fest==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST" 2 "No FEST")) 
	graph twoway (histogram pscore_sc if Y_fest==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST" 2 "No FEST" ))
*3. U | FEST=0
	dprobit Y_unidos PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 region tenencia1
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_unidos==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_unidos==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_unidos==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_unidos==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_unidos==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_unidos==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST" 2 "No FEST")) 
	graph twoway (histogram pscore_sc if Y_unidos==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST" 2 "No FEST" ))
*4. FEST & U*
	dprobit Y_unidos_fest PUNTAJEsisben IPMgeneral sexo_jefe programas2 gastAlimen2 region tenencia1
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_unidos_fest==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_unidos_fest==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_unidos_fest==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_unidos_fest==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_unidos_fest==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_unidos_fest==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST" 2 "No FEST")) 
	graph twoway (histogram pscore_sc if Y_unidos_fest==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST" 2 "No FEST" ))
*5. Revisión del pstest por variable*
	psmatch2 D PUNTAJEsisben IPMgeneral sexo_jefe programas2  gastAlimen2  tenencia1 region, outcome(ingTotal) kernel com
	
	pstest PUNTAJEsisben IPMgeneral sexo_jefe programas2  gastAlimen2  tenencia1 region, both ///
		ytitle(% de error estandarizado entre variables relacionadas) legend (label(1 No Emparejado)label(2 Emparejado)) ///
		graph graphregion(color(white))
}
*******************************Nueva especificación*******************************
{
*1. FEST vs No FEST*
preserve
	dprobit D PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region 
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if D==0
	scalar max_control=r(max)
	replace pscore_sc=. if D==1 & pscore_sc>max_control
		
	sum pscore_sc if D==1
	scalar min_trat=r(min)
	replace pscore_sc=. if D==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if D==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if D==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST" 2 "No FEST")) 
	graph twoway (histogram pscore_sc if D==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST" 2 "No FEST" ))
restore
*2. FEST | U=0
preserve
	dprobit Y_fest PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_fest==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_fest==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_fest==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_fest==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_fest==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_fest==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST | U=0" 2 "No FEST | U=0")) 
	graph twoway (histogram pscore_sc if Y_fest==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST | U=0" 2 "No FEST | U=0" ))
restore
*3. U | FEST=0
preserve
	dprobit Y_unidos PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_unidos==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_unidos==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_unidos==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_unidos==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_unidos==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_unidos==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "U | FEST=0" 2 "No U | FEST=0")) 
	graph twoway (histogram pscore_sc if Y_unidos==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "U | FEST=0" 2 "No U | FEST=0" ))
restore
*4. FEST & U*
preserve
	dprobit Y_unidos_fest PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region
	
	predict pscore
	kdensity pscore
    
	gen pscore_sc=pscore
	sum pscore_sc if Y_unidos_fest==0
	scalar max_control=r(max)
	replace pscore_sc=. if Y_unidos_fest==1 & pscore_sc>max_control
		
	sum pscore_sc if Y_unidos_fest==1
	scalar min_trat=r(min)
	replace pscore_sc=. if Y_unidos_fest==0 & pscore_sc<min_trat
	
	kdensity pscore_sc if Y_unidos_fest==1, epanechnikov generate(x1 y1)
	kdensity pscore_sc if Y_unidos_fest==0, epanechnikov generate(x0 y0)
	
	twoway (line y1 x1) (line y0 x0, lpattern(dash)), ytitle(Densidad) xtitle(Probabilidad de ser tratado) title(Propensity Score ) ///
		legend(order(1 "FEST & U" 2 "No FEST & U")) 
	graph twoway (histogram pscore_sc if Y_unidos_fest==1, color(emidblue) frequency)(histogram pscore_sc if D==0, fcolor(none) lcolor(maroon) frequency), ///
		legend(order(1 "FEST & U" 2 "No FEST & U" ))
restore
*5. Revisión del pstest por variable (El código para las demás variables esta en el do-file: "Analisis E12 FEST vs NOFEST_definitivo"*
global pruebaps horasTotales ingTotal IPMgeneral valActHog c019_productos_pecuarios escInsegAli ///
	presenInformal credInformal gastTotal escalRoles escBnstar SSC
foreach var of global pruebaps{	
	psmatch2 D PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, outcome(`var') kernel com
	
	pstest PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, both ///
		ytitle(% de error estandarizado entre variables relacionadas) legend (label(1 No Emparejado)label(2 Emparejado)) ///
		graph graphregion(color(white))
	graph export "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados FEST\Graficas\Graph`var'.png", as(png) replace	
	}
	
}
}
/*********************************************Gráficos de coeficientes*******************************************/
{
**LABELS**
	label var horasTotales "Horas de trabajo totales" 
	label var horasSecu "Horas dedicadas a act. secundaria"
	label var horasPrin "Horas dedicadas a act. principal"
	label var c08_productos_agricolas "Número de productos agrícolas"
	label var c019_productos_pecuarios "Número de productos pecuarios"
	label var escInsegAli "Escalera de seguridad alimentaria"
	label var punELCSA_1 "Hogares en seguridad alimentaria"
	label var punELCSA_2 "Hogares en inseguridad leve"
	label var punELCSA_3 "Hogares en inseguridad moderada"
	label var punELCSA_4 "Hogares en inseguridad severa"
	label var ahorPreFormal "Presencia de ahorro formal"
	label var presenInformal "Presencia de ahorro informal"
	label var credPreFormal	"Presencia de crédito formal"
	label var credPreInformal	"Presencia de crédito informal"
tokenize "$varAspyExp"
	label var `1' "Diferencia en las aspiraciones a 5 años"
	label var `2' "Diferencia en las expectativas a 5 años"
	label var `3' "Diferencia en las aspiraciones a 2 años"
	label var `4' "Diferencia en las expectativas a 2 años"
	label var `5' "Escalera de bienestar"
	label var `6' "Expectativas de bienestar a 5 años"
	label var `7' "Expectativas de bienestar a 2 años"
	label var `8' "Aspiraciones de bienestar a 5 años"
	label var `9' "Aspiraciones de bienestar a 2 años"

global t_1 "FEST | UNIDOS=0"
global t_2 "UNIDOS | FEST=0" 
global t_3 "FEST & UNIDOS"
global opt "mlw(thick) mlabs(medium) ciopts(lwidth(thick))"
global opts "mlw(thick) mlabs(medium) ciopts(lwidth(thick)) label(labsize(small))"
********** varTrabajo
 
local graf varTrabajo
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
	}
coefplot ///
(`1'`i', label ("`lab1'") msymbol(O) $opt ) ///
(`2'`i', label ("`lab2'") msymbol(O) $opt ) ///
(`3'`i', label ("`lab3'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.3f) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white)) 
*** varIngHog ingTotal *ingRent *ingAyuFam *ingPenDivo ingAgro ingNoAgro *ingMFApam *ingOtros

tokenize  `""FEST | UNIDOS=0" "UNIDOS | FEST=0" "FEST & UNIDOS""'
forvalues i=1(1)3{
coefplot (ingTotal`i', label ("Ingreso mensual total") msymbol(O) $opt lcolor(gs9)) ///
(ingAgro`i', label ("Ingreso mensual por act. agropecuarias") msymbol(O) $opt ) ///
(ingNoAgro`i', label ("Ingreso mensual por act. no agropecuarias") msymbol(O) $opt ) ///
, name(ing`i', replace) nolabels ci xline(0)  mlabel format(%7.3g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ("``i''") nodraw
}

grc1leg (ing1 ing2 ing3), cols(3) xsize (12) note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
*** varAct *valActHog valActEspPe valActEspGra valActPro valActIn *implementos_cuanto


local graf varAct
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"


forvalues i=1(1)3{

coefplot ///
(`2'`i', label ("Valor total en especies menores") msymbol(O) $opt ) ///
(`3'`i', label ("Valor total en especies mayores") msymbol(O) $opt ) ///
(`4'`i', label ("Valor de los activos productivos") msymbol(O) $opt ) ///
(`5'`i', label ("Valor de la infraestructura del hogar") msymbol(O) $opt ) ///
, name(Act`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (Act1 Act2 Act3), cols(3) xsize (12) note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
***VarProduc c08_productos_agricolas c019_productos_pecuarios  c38_huerta

local num: list sizeof global(varProduc)
disp `num'
tokenize  "$varProduc"

forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
	}
coefplot ///
(`1'`i', label ("`lab1'") msymbol(O) $opt ) ///
(`2'`i', label ("`lab2'") msymbol(O) $opt ) ///
, name(Produc`i', replace) nolabels ci xline(0)  mlabel format(%7.3g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} )
}
grc1leg (Produc1 Produc2 Produc3), cols(3) xsize (12) note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
*************************   SEGALI

local graf varSegAli
local num: list sizeof global(varSegAli)
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
}
coefplot ///
(`8'`i', label ("`lab8'") msymbol(O) $opt ) ///
(`9'`i', label ("`lab9'") msymbol(O) $opt ) ///
(`10'`i', label ("`lab10'") msymbol(O) $opt ) ///
(`11'`i', label ("`lab11'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))

local graf varSegAli
local num: list sizeof global(varSegAli)
disp `num'
tokenize  "${`graf'}"
coefplot ///
(`1'1, label ("$t_1") msymbol(O) $opt ) ///
(`1'2, label ("$t_2") msymbol(O) $opt ) ///
(`1'3, label ("$t_2") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") 
*****************HUERTA

 local graf varProduc
local num: list sizeof global(varSegAli)
disp `num'
tokenize  "${`graf'}"
coefplot ///
(`3'1, label ("$t_1") msymbol(O) $opt ) ///
(`3'2, label ("$t_2") msymbol(O) $opt ) ///
(`3'3, label ("$t_2") msymbol(O) $opt ) ///
, name(`graf', replace) nolabels ci xline(0)  mlabel format(%7.3f) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("")  
*****************varAhorroCred

local graf varAhorroCred
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
local lab1: variable label `1'
local lab2: variable label `2'
local lab3: variable label `3'
local lab4: variable label `4'

coefplot ///
(`1'`i', label ("`lab1'") msymbol(O) $opt ) ///
(`2'`i', label ("`lab2'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}
grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
 
local graf varAhorroCred
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
local lab1: variable label `1'
local lab2: variable label `2'
local lab3: variable label `3'
local lab4: variable label `4'

coefplot ///
(`3'`i', label ("`lab3'") msymbol(O) $opt ) ///
(`4'`i', label ("`lab4'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
******************* varEmpod escalRoles decisiones

local graf varEmpod
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
local lab1: variable label `1'
local lab2: variable label `2'

coefplot ///
(`1'`i', label ("`lab1'") msymbol(O) $opt ) ///
(`2'`i', label ("`lab2'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.4g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
********* varAspyExp *lagAsp5 *lagExp5 *lagAsp2 *lagExp2 escBnstar expBnstar5 expBnstar2 aspBnstar5 aspBnstar2 

 local graf varAspyExp 
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
	}
coefplot ///
(`5'`i', label ("`lab5'") msymbol(O) $opt ) ///
(`6'`i', label ("`lab6'") msymbol(O) $opt ) ///
(`7'`i', label ("`lab7'") msymbol(O) $opt ) ///
(`8'`i', label ("`lab8'") msymbol(O) $opt ) ///
(`9'`i', label ("`lab9'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.3g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
 ******************** CAPITAL SOCIAL *****************
 
*varCapSocial ssc1 ssc2 ssc3 ssc4 SSC csc1 csc2 CSC m7_proyectos_comunitarios m9_participo_proyecto
 label var ssc3 "Expectativas sobre redes y apoyo"
 local graf varCapSocial
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
	}
coefplot ///
(`1'`i', label ("`lab1'") msymbol(O) $opt ) ///
(`2'`i', label ("`lab2'") msymbol(O) $opt ) ///
(`3'`i', label ("`lab3'") msymbol(O) $opt ) ///
(`4'`i', label ("`lab4'") msymbol(O) $opt ) ///
(`5'`i', label ("`lab5'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0)  mlabel format(%7.3g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
************ PROYECTOS COMUNITARIOS **************+

 local graf varCapSocial
local num: list sizeof global(`graf')
disp `num'
tokenize  "${`graf'}"

label var `9' "Presencia de proyectos comunitarios"
label var `10' "Participación en proyectos comunitarios"


forvalues i=1(1)3{
	forvalues j=1/`num'{
		local lab`j': variable label ``j''
	}
coefplot ///
(`9'`i', label ("`lab9'") msymbol(O) $opt ) ///
(`10'`i', label ("`lab10'") msymbol(O) $opt ) ///
, name(`graf'`i', replace) nolabels ci xline(0) mlabel format(%7.3g) mlabposition(12) ///
 levels(90) graphregion(color(white)) ylabel ("") title ( ${t_`i'} ) nodraw xscale(r(0 .3)) xlabel(0(.05).3)
}

grc1leg (`graf'1 `graf'2 `graf'3), cols(3) xsize(12) ///
 note ("Nota: Intervalos de confianza al 90%")  graphregion(color(white))
}
/*********************************************Tratamientos y GPS*************************************************/
{
ssc install gpscore2
update query
h gpscore2
*Variables de Tratamiento*
	gen antioquia=1 if departamento==3
	replace antioquia=0 if departamento!=3

	gen bolivar=1 if departamento==1
	replace bolivar=0 if departamento!=1

	gen grupos2= 0 if grupos==1
	replace grupos2=1 if grupos==3
	replace grupos2=2 if grupos==2
	replace grupos2=3 if grupos==4
	label define tratamientos 0"C: Ninguno" 1"F: U | F=0" 2"AB: F | U=0" 3"DE: F & U"
	label values grupos2 tratamientos
	label values D categorias
	
	gen grupos3=0 if grupos2==0 | grupos2==1 | grupos2==2
	replace grupos3=1 if grupos2==3
	label define tratamientos3 0"C, F y AB" 1"DE"
	label values grupos3 tratamientos3
	
	gen grupos4=1 if grupos2==3
	replace grupos4=0 if grupos2==1
	label defines tratamientos4 0"F: U | F=0" 1"DE: F & U"
	label values grupos4 tratamientos4
	
	gen grupos5=1 if grupos2==2
	replace grupos5=0 if grupos2==0
	label defines tratamiento5 ""
	
	gen grupos6=1 if grupos2==3 | grupos2==1
	replace grupos6=0 if grupos2==2 | grupos2==0

	drop if edad_jefe==.
*GPS* 						Preguntar si se debe quitar sexo_jefe del GPS
	*Multivariado*
		gpscore2 PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
			t(grupos2) gpscore(gps_estimado) predict(t_ajustado) sigma(pearson) cutpoints(grupos2) ///
			index(mean) nq_gps(3) family(p) link(log) det /* poisson, log*/
			
		gpscore2 PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
			t(grupos2) gpscore(gps_estimado) predict(t_ajustado) sigma(pearson) cutpoints(grupos2) ///
			index(mean) nq_gps(3) family(nb) link(log) det /*negative binomial, log*/
		
		gpscore2 PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
			t(grupos2) gpscore(gps_estimado) predict(t_ajustado) sigma(pearson) cutpoints(grupos2) ///
			index(mean) nq_gps(3) family(binomial 4) link(l) det /*binomial (4), logit*/
	*Bivariado*		
		gpscore2 PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
			t(grupos3) gpscore(gps_estimado) predict(t_ajustado) sigma(pearson) cutpoints(grupos3) ///
			index(mean) nq_gps(2) family(binomial 2) link(l) det /*binomial (2), logit*/
		
		gpscore2 PUNTAJEsisben edad_jefe sexo_jefe educ_jefe programas4 region, ///
			t(grupos3) gpscore(gps_estimado) predict(t_ajustado) sigma(pearson) cutpoints(grupos3) ///
			index(mean) nq_gps(2) family(nb) link(log) det /*negative binomial, log*/
*Controles
	global auxvarTrabajo antioquia bolivar PEA estudioPromedioHogar personas_hogar
	global auxvarIngHog antioquia bolivar PEA arHo porcenTitu estudioPromedioHogar
	global auxvarAct antioquia bolivar arHo porcenTitu
	global auxvarProduc antioquia bolivar arHo porcenTitu
	global auxvarSegAli antioquia bolivar PEA arHo personas18Men sexo_jefe
	global auxvarAhorroCred antioquia bolivar estudioPromedioHogar PEA porcenTitu arHo 
	global auxvarEmpod antioquia bolivar estudioPromedioHogar sexo_jefe
	global auxvarAspyExp antioquia bolivar estudioPromedioHogar sexo_jefe
	global auxvarCapSocial antioquia bolivar estudioPromedioHogar sexo_jefe
*****************************************Aproximación tratamiento multivariado*****************************************
*Controles restandole la media*
foreach var of varlist antioquia bolivar PEA arHo porcenTitu estudioPromedioHogar sexo_jefe ///
	personas_hogar personas18Men{
	sum `var', det
	gen `var'_media=`var'-r(mean)
}
*if grupos2=3
*Horas trabajo*
foreach var of global varTrabajo{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2##c.PEA_media ///
	i.grupos2##c.estudioPromedioHogar_media i.grupos2##c.personas_hogar_media  [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Ingresos*
foreach var of global varIngHog{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2##c.PEA_media ///
	i.grupos2##c.estudioPromedioHogar_media i.grupos2##c.arHo_media i.grupos2##c.porcenTitu_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Activos*
foreach var of global varAct{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2##c.arHo_media ///
	i.grupos2##c.porcenTitu_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Productos agrícolas o pecuarios*
foreach var of global varProduc{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2##c.arHo_media ///
	i.grupos2##c.porcenTitu_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Seguridad Alimentaria*
foreach var of global varSegAli{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2#c.PEA_media ///
	i.grupos2##c.arHo_media i.grupos2##c.personas18men_media i.grupos2##c.sexo_jefe_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Ahorro y crédito*
foreach Y in varAhorroCred varValAhoCred{
foreach var of global `Y'{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2#c.PEA_media ///
	i.grupos2#c.estudioPromedioHogar_media i.grupos2##c.arHo_media i.grupos2#c.porcenTitu_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
}
*Empoderamiento*
foreach var of global varEmpod{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2#c.estudioPromedioHogar_media ///
	i.grupos2##c.sexo_jefe_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
*Aspiraciones y expectativas*
foreach Y in varAspyExp varAspyExp2{
foreach var of global `Y'{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2#c.estudioPromedioHogar_media ///
	i.grupos2##c.sexo_jefe_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"
}
}
*Capital Social*
foreach var of global varCapSocial{
	reg `var' i.grupos2##c.antioquia_media i.grupos2##c.bolivar_media i.grupos2#c.estudioPromedioHogar_media ///
	i.grupos2##c.sexo_jefe_media [weight=gps_estimado]
	outreg2 using "Estimaciones con GPS\Tratamiento_multivariado2.xls"

}
*****************************************Aproximación tratamientos binarios*****************************************
*Horas trabajo*
foreach var of global varTrabajo{
	reg `var' i.D##i.UNIDOS $auxvarTrabajo [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Ingresos*
foreach var of global varIngHog{
	reg `var'  i.D##i.UNIDOS $auxvarIngHog [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Activos*
foreach var of global varAct{
	reg `var'  i.D##i.UNIDOS $auxvarAct [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Productos agrícolas o pecuarios*
foreach var of global varProduc{
	reg `var'  i.D##i.UNIDOS $auxvarProduc [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Seguridad Alimentaria*
foreach var of global varSegAli{
	reg `var'  i.D##i.UNIDOS $auxvarSegAli [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Ahorro y crédito*
foreach Y in varAhorroCred varValAhoCred{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS $auxvarAhorroCred [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
}
*Empoderamiento*
foreach var of global varEmpod{
	reg `var'  i.D##i.UNIDOS $auxvarEmpod [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
*Aspiraciones y expectativas*
foreach Y in varAspyExp varAspyExp2{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS $auxvarAspyExp [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
}
*Capital Social*
foreach var of global varCapSocial{
	reg `var'  i.D##i.UNIDOS $auxvarCapSocial [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario1.xls"
}
/******************************************************************************/
*Horas trabajo*
foreach var of global varTrabajo{
	reg `var' i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Ingresos*
foreach var of global varIngHog{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Activos*
foreach var of global varAct{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Productos agrícolas o pecuarios*
foreach var of global varProduc{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Seguridad Alimentaria*
foreach var of global varSegAli{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Ahorro y crédito*
foreach Y in varAhorroCred varValAhoCred{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
}
*Empoderamiento*
foreach var of global varEmpod{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
*Aspiraciones y expectativas*
foreach Y in varAspyExp varAspyExp2{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"
}
}
*Capital Social*
foreach var of global varCapSocial{
	reg `var'  i.D##i.UNIDOS  [pw=1/gps_estimado], vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario2.xls"

}
/******************************************************************************/
*Horas trabajo*
foreach var of global varTrabajo{
	reg `var' i.D##i.UNIDOS $auxvarTrabajo, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Ingresos*
foreach var of global varIngHog{
	reg `var'  i.D##i.UNIDOS $auxvarIngHog, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Activos*
foreach var of global varAct{
	reg `var'  i.D##i.UNIDOS $auxvarAct, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Productos agrícolas o pecuarios*
foreach var of global varProduc{
	reg `var'  i.D##i.UNIDOS $auxvarProduc, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Seguridad Alimentaria*
foreach var of global varSegAli{
	reg `var'  i.D##i.UNIDOS $auxvarSegAli, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Ahorro y crédito*
foreach Y in varAhorroCred varValAhoCred{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS $auxvarAhorroCred, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
}
*Empoderamiento*
foreach var of global varEmpod{
	reg `var'  i.D##i.UNIDOS $auxvarEmpod, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
*Aspiraciones y expectativas*
foreach Y in varAspyExp varAspyExp2{
foreach var of global `Y'{
	reg `var'  i.D##i.UNIDOS $auxvarAspyExp, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
}
*Capital Social*
foreach var of global varCapSocial{
	reg `var'  i.D##i.UNIDOS $auxvarCapSocial, vce(r)
	outreg2 using "Estimaciones con GPS\Tratamiento_binario3.xls"
}
}
