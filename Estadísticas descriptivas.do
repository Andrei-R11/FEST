***Variables discretas

drop pobreza_monetaria2
gen pobreza_monetaria2= 1 if pobreza==1 | pobreza_extrema==1
replace pobreza_monetaria2=0 if no_pobreza==1
***Estadisticas descriptivas
foreach X of var pobreza_monetaria2 c38_huerta ahorPreFormal presenInformal credPreFormal credPreInformal   ///
	m7_proyectos_comunitarios tipoHogarIPM m9_participo_proyecto e25_problema_salud privacion7 privacion3 preMejorHo programas{
eststo clear
eststo: estpost tabulate `X' , m nol
local labelvar=e(labels)
local label : variable label `X'
count if `X'==.
if r(N)>0 {
bys D: eststo: estpost tabulate `X' , m nol
esttab using "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados\Estadístcias descriptivas.rtf", /*
*/ cells("b(label(Freq)) pct(label(Perc) fmt(1)) cumpct(label(Cum.) fmt(1))") /*
*/ modelwidth(15)  mtitle("Todo" "No FEST" "FEST") varlabels(`labelvar')/*
*/ append nonumber title("Variable - `X' - `label'")
} 
else {
bys D: eststo: estpost tabulate `X' , m nol
esttab using "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados\Estadístcias descriptivas.rtf", /*
*/ cells("b(label(Freq)) pct(label(Perc) fmt(1)) cumpct(label(Cum.) fmt(1))") /*
*/ modelwidth(15)  mtitle("Todo" "No FEST" "FEST")/*
*/ append nonumber title("Variable - `X' - `label'") 
}
}

*Variables continuas
foreach X of var edad_jefe sexo_jefe sexo_jefe_mujer edad_jefe2 horasTotales horasSecu horasPrin ingTotal ingRent ingAyuFam ingPenDivo ingAgro ingNoAgro ingMFApam ingOtros ///
	IPMgeneral pcan valActHog valActEspPe valActEspGra valActPro valActIn implementos_cuanto   credFormal ///
	credInformal ahorroFormal ahorroInformal gastTotal gastDiver2 gastTrans2 gastEdu gastOtros gastServi gastSalud gastAnua gastSinAlimen gastAlimen2 ///
	escalRoles decisiones lagAsp5 lagExp5 lagAsp2 lagExp2 escBnstar  expBnstar2 aspBnstar5 aspBnstar2 porcen* ssc1 ssc2 ssc3 ssc4  csc1 csc2 SSC CSC c08_productos_agricolas c019_productos_pecuarios expBnstar5{
preserve
gen `X'_1=`X' if D==0
gen `X'_2=`X' if D==1

eststo clear
eststo: estpost tabstat `X' `X'_1 `X'_2, s(count mean sd min max p1 p5 p10 p25 med p75 p90 p95 p99) c(v)
local label: variable label `X'
esttab using "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados\Estadístcias descriptivas2.rtf", /*
*/ c("`X'(label(Todos) fmt(%10.2gc)) `X'_1(label(No FEST) fmt(%10.2gc)) `X'_2(label(FEST) fmt(%10.2gc))") /*
*/ nonum nomtitle title(Variable `X' - `label') append 
restore
}

rename c019_productos_pecuarios c019_produ_pecua
foreach X of var  {
preserve
gen `X'_1=`X' if D==0
gen `X'_2=`X' if D==1

eststo clear
eststo: estpost tabstat `X' `X'_1 `X'_2, s(count mean sd min max p1 p5 p10 p25 med p75 p90 p95 p99) c(v)
local label: variable label `X'
esttab using "C:\Users\a.romero11\OneDrive\CEDE\Evaluación Resultados\Estadístcias descriptivas3.rtf", /*
*/ c("`X'(label(Todos) fmt(%10.2gc)) `X'_1(label(No FEST) fmt(%10.2gc)) `X'_2(label(FEST) fmt(%10.2gc))") /*
*/ nonum nomtitle title("Variable `X' - `label'") append 
restore
}

