# Hecho con gusto por Carla Carolina Pérez Hernández (UAEH)
# Ejecutado por María Guadalupe Montiel Hernández 
# T1_04_REDES COMPLEJAS(1) - Visión de redes complejas - parte 1

# Objetivo: Estimar el Maximum Spanning Tree -árbol de expansión máxima- (asegurar una visión clara del espacio-producto)
# Red troncal: Estructura general de la red: vamos a poder v. redes complejas

# Regla 1: mantener n-1 conexiones como máximo
# Regla 2: Quitar las conexiones con el peso más bajo, nos vamos quedar con las del peso máximo (menos conexiones)
# Regla 3: No crear nodos aislados
# ------------------------------------------------------------------------------------------------------
# En este ejercicio vamos a:
# 1. Usar un matriz hipotetica de datos
# 2. Graficar sus próximos adyacentes


##################################################################
# practica 3: Visión clara del espacio-producto: CASO HIPOTÉTICO #
##################################################################

# 1)la visualización del espacio - producto sea una red conectada: evitar islas de productos aislados. 
# 2)PROBLEMA: tratar de visualizar demasiados enlaces puede crear una complejidad visual innecesaria 
# donde se obstruirán las conexiones más relevantes.
#calculamos el árbol de expansión máxima (MST) de la matriz de proximidad. 
# MST es el conjunto de enlaces que conecta todos los nodos de la red utilizando un número mínimo de conexiones
# y la suma máxima posible de proximidades. 
#Calculamos el MST usando el algoritmo de Kruskal: Básicamente, el algoritmo clasifica los valores de la matriz
# de proximidad en orden descendente y luego incluye enlaces en el MST si y solo si conectan un producto aislado. 
#Por definición, el MST incluye todos los productos, pero el número de enlaces es el mínimo posible.
#Después de seleccionar los enlaces utilizando los criterios mencionados anteriormente, 
# construimos una visualización utilizando un algoritmo de diseño dirigido por la fuerza. 



#crear una matriz aleatoria de 200*200
M<-matrix(runif(200*200, min=0, max=100), ncol=200)
#Generar ceros en la diagonal 
diag(M)<-0
#Visualizar el encabezado
head(M[,1:6])
#dimensionar 
dim(M)
#llamar a paquetería
library(igraph)
#crear gráfico de adyacencia g del espacio-producto
g<-graph.adjacency(M, mode= "undirected", weighted=TRUE)
#Visualizar gráfico g del espacio-producto
plot(g)
#Transformar la matriz en NEGATIVA para identificar los máximos
M<- -M
#Visualizar la matriz con el árbol de expansión máxima (primeroa 6 datos)
head(M[,1:6])
#Generar el nuevo gráfico con la matriz negativa para ver el espacio-producto tecnológico
g<-graph.adjacency(M, mode= "undirected", weighted=TRUE)
#Calcular el árbol de expansión mínima del gráfico g
MST<-minimum.spanning.tree(g)
#Visualizar el gráfico generado
plot(MST,vertex.shape="none",vertex.label.cex=.7)
#Generar la nueva matriz de adyacencias A (nuevo relacionamiento)
A<-get.adjacency(MST,sparse=F)
#Visualizar las aristas (pesos) que hay entre los nodos (solo las primeras)
head(A)
#Exportar gráfico para una paquetería especializada
write.graph(MST,file="g.gml",format = "gml")
#Exportar red de adyacencias
write.csv(A,file="Adyacentes.csv")

