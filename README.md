# Base de datos SINADEF

Este repositorio contiene las bases de datos procesadas y curadas del Sistema Nacional de Defunciones (SINADEF) del Ministerio de Salud del Perú (MINSA).

- Acceso: https://www.dropbox.com/home/db_SINADEF_repo o por correo: jorge.ruiz.c@upch.pe


El archivo principal (base de datos curada) es "sinadef_YYMMDD.Rdata".

Este archivo es el resultado del pre-procesamiento realizado en "./Procesamiento/0. Pre-procesamiento".

Un segundo grupo de archivos en formato "long" se encuentran nombrados como "sinadef_longBy[variable]_YYMMDD.Rdata" y son procesados en "./Procesamiento/1- Formato Long completa".

![](https://raw.githubusercontent.com/healthinnovation/db_SINADEF/main/Documentos/Workflow%20de%20datos.png)

La estructura de "sinadef_YYMMDD.Rdata" es:

| Domicilio  | Sexo | Edad |
| ------------- | ------------- |  ------------- |
| Distrito A  | Masculino  | 15 |
| Distrito B  | Femenino | 34  |
| Distrito B  | Femenino | 46  |
| Distrito C  | Femenino | 63 |
| Distrito C  | Masculino | 23  |


La estructura de "sinadef_longBy[variable]_YYMMDD.Rdata" es:

| Domicilio  | Sexo | Número |
| ------------- | ------------- |  ------------- |
| Distrito A  | Masculino  | 1 |
| Distrito A  | Femenino  | 0 |
| Distrito B  | Masculino  | 0 |
| Distrito B  | Femenino  | 2 |
| Distrito C  | Femenino  | 1 |
| Distrito C  | Masculino   | 1 |

# Bibliografía del SINADEF

El SINADEF fue descrito y presentado en el artículo https://rpmesp.ins.gob.pe/index.php/rpmesp/article/view/3913/3111
Un resumen del mismo (en inglés) se encuentra aquí: https://crvsgateway.info/file/16356/3011

Trabajos relacionados utilizando el SINADEF:

 - A divergence between underlying and final causes of death in selected conditions: an analysis of death registries in Peru: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6237111/
 - Causes of global mortality: https://www.thelancet.com/journals/langlo/article/PIIS2214-109X(14)70227-X/fulltext#sec1
