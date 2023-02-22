# Hecho con gusto por Carla Carolina Pérez Hernández(UAEH)
#Ejecutado por María Guadalupe Montiel Hernández 

# LABORATORIO - Data.Table: AGRUPAMIENTO EN R

# Objetivo: agrupar datos en R de una base de datos en csv.
# --------------------------------------------------------------------------------------------------------------------
# En este ejercicio vamos a:
#Cargar nuestra base datos
#leer la base de datos como data table
#agrupar lo datos para hacer operaciones con ellos (en este caso los agrupamos para sumarlos)


#############################################
#LABORATORIO: data.table(AGRUPAMIENTO EN R)   #
#############################################
#Prerrequisitos
#install.packages("data.table")
install.packages("data.table")
install.packages("dplyr")

#llamar paquetes
library(data.table)
library(dplyr)
library(readr)

#cargar la base de datos
file.choose()
#leer archivo
data2013<- read.csv("/Users/lu/Downloads/greenR_2013.csv")


#leerlo como data table

data2013<- as.data.table(data2013)

#para averiguar el tipo de datos que son, uso class y me doy cuenta que lo reconoce como data.table y data.frame

class(data2013)

#nombro resultados 2013 para agruparlos, aquí sumo diferentes variables por localidad y hago un conteo.

resultados2013 <- data2013 %>% 
  group_by(location_name) %>% 
  summarise(suma_GCI_2013 = sum(GCI_2013, na.rm = TRUE),
            suma_GP_SINVCR = sum(GP_SINVCR, na.rm = TRUE),
            suma_GCP_2013 = sum(GCP_2013, na.rm = TRUE),
            count= n())

#exportar resultado
write.csv(resultados2013, file ="resultados2013.csv")

