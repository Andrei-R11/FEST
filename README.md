# FEST
Evaluación de resultados de FEST

	cd "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados FEST\"
	*cd "C:\Users\andre\OneDrive\CEDE\Evaluación Resultados FEST\"
	use "Encuesta Hogares Colombia FINAL hog+per_sisben_180219", clear
	
	
**GLOBALS**

	global varTrabajo horasTotales horasSecu horasPrin 
	global varIngHog ingTotal ingRent ingAyuFam ingPenDivo ingAgro ingNoAgro ingMFApam ingOtros
	*global varPobreza pobreza pobreza_extrema IPMgeneral pcan 
	global varAct valActHog valActEspPe valActEspGra valActPro valActIn implementos_cuanto
	global varProduc c08_productos_agricolas c019_productos_pecuarios  c38_huerta
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
