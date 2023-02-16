# Objetivo: Estimar la densidad del relacionamiento (rd)
# La densidad varia entre 0 y 1, los valores más grandes indican que la región ha avanzado a
# una VCR en muchos bienes proximos al bien i y tiene mayor probabilidad de exportarlo en el futuro
# mayor densidad, mayor cercanía. Menor densidad, mayor lejanía.
# 1. Cargar una matriz hipotética de datos
# 2. Estimar la VCR de la matriz hipotética
# 3. Calcular las co-ocurrencias y el relacionamiento (espacio-producto)
# 4. Estimar la densidad del relacionamiento (rd)
#Buscamos saber si las industrias que estan relacionadas estan presentes en las regiones o no. Nivel de cercanía
# 5. Predecir la entrada de una nueva industria
#Econometría usar count(densidad del relacionamiento) como regresora (predictora) de la entrada de una nueva industria


#ejecutar libería EconGeo

library(EconGeo)

#identificar los elementos implícitos del concepto de RCA#

?RCA

#usar la documentación para generar ¨mat¨y crear una matriz con RCA,
#copiando los datos de las utilidades de la consola

set.seed(31)
mat <- matrix(sample(0:100,20,replace=T), ncol = 4)
rownames(mat) <- c ("R1", "R2", "R3", "R4", "R5")
colnames(mat) <- c ("I1", "I2", "I3", "I4")

#visualizar la matriz generada#

mat

#obtener el orden de la matriz: renglones(regiones)xcolumnas(industrias)

dim(mat)

#calcular la VCR-RCA - indicador de especialización

mat=RCA(mat,binary=T)

#ver la matriz binaria de VCR

mat

#calcular las co-ocurrencias entre las industrias (matriz transpuesta)#

c=co.occurrence(t(mat))

#visualizar la matriz de co-ocurrencias entre industria#

c

#Estimar relacinamiento o proximidad, no normalizado
#teniendo como input las co-ocurrencias, para aseurar que el número de 
#co-ocurrencias que observamos es mayor al número de co-ocurrencias probables
#(probabilidad condicional)

r=relatedness(c)

#visualizar matriz de proximidad

r

#generar matriz binaria

r[r<1]=0
r[r>1]=1

#visualizar matriz binaria

r

#Densidad del relacionamiento 
#1.Haber computado la matriz binaria de RCA antes de calcular Relacionamiento-densidad
#2. Se usa la matriz de VCR (mat) y el espacio-producto(r)
#Identificar la DENSIDAD del relacionamiento - oscila entre el 0 y 100% 
#(más cercanía a una industria)

#visualizar mat VCR

mat

rd=relatedness.density(mat,r)

#ver matriz de DENSIDAD del relacionamiento generada

rd

#visualizar datos en forma de lista- útil para ecuaciones de regresión econométrica

rd=get.list(rd)

#visualizar lista generada (count es DENSIDAD del Relacionamiento)- solo los primeros datos

head(rd)

#Predecir la entrada de una industria a una región#

?entry.list

#copiar la primera línea de código de la sección de ejemplos

## generate a first region - industry matrix in which cells represent the presence/absence
## of a RCA (period 1)

set.seed(31)
mat1 <- matrix(sample(0:1,20,replace=T), ncol = 4)
rownames(mat1) <- c ("R1", "R2", "R3", "R4", "R5")
colnames(mat1) <- c ("I1", "I2", "I3", "I4")

#visualizar matriz  de VCR en el momento 1 generada#

mat1

#para identificar la entrada de una industria necesitamos al menos 2 momentos en el tiempo

#copiar la segunda línea del código

mat2 <- mat1
mat2[3,1] <- 1

#visualizar matriz 2

mat2

#evidenciar la entrada de una industria a una región (donde antes no estaba)

d =entry.list (mat1, mat2)

#visualizar

d

#visualizar lista de entrada 

head(d)

#aparece variable ¨entry¨ que compara mat1 y mat2 
#existen posibilidades de entrada cuando hay un 0 de VCR 2
#cuando hay 1 se puede permanecer o salir, no entrar 
#NA no puede entrar 


#combinar las bases para ordenar la lista de entrada con la DENSIDAD del relacionamiento

colnames(d)= c ("region", "industry", "entry", "period")
d = merge (d, rd, by = c("Region","Industry"))

colnames(d) = c("Region","Industry","Entry","Period")
d = merge(d, rd, by = c("Region", "Industry"))
d
          
#visualizar la nueva lista de entrada del dato de Count=DENSIDAD del relacionamiento
head(d)
          