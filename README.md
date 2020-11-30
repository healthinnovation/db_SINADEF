# Base de datos SINADEF

Este repositorio contiene las bases de datos procesadas y curadas del Sistema Nacional de Defunciones (SINADEF) del Ministerio de Salud del Perú (MINSA).

El archivo principal (base de datos curada) es "sinadef_YYMMDD.Rdata".

Este archivo es el resultado del pre-procesamiento realizado en "./Procesamiento/0. Pre-procesamiento". 

| Domicilio  | Sexo | Edad |
| ------------- | ------------- |  ------------- |
| Distrito A  | Masculino  | 15 |
| Distrito B  | Femenino | 34  |
| Distrito B  | Femenino | 46  |
| Distrito C  | Femenino | 63 |
| Distrito C  | Masculino | 23  |


Los archivos con formato "sinadef_longBy[variable]_YYMMDD.Rdata" se encuentran ordenados en formato long.

| Domicilio  | Sexo | Número |
| ------------- | ------------- |  ------------- |
| Distrito A  | Masculino  | 1 |
| Distrito A  | Femenino  | 0 |
| Distrito B  | Masculino  | 0 |
| Distrito B  | Femenino  | 2 |
| Distrito C  | Femenino  | 1 |
| Distrito C  | Masculino   | 1 |
