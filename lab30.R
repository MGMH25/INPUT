# Hecho con gusto por Carla Carolina Pérez Hernández(UAEH)
#Ejecutado por María Guadalupe Montiel Hernández 

# LABORATORIO - Merge- fundir tablas


#llamar paquetes
library(data.table)
library(readr)

#cargar la base de datos
file.choose()
#leer archivo

green_products <- read.csv("/Users/lu/Downloads/drive-download-20230222T003137Z-001/green products.csv")
all.products <- read.csv("/Users/lu/Downloads/drive-download-20230222T003137Z-001/COMPLETE_YEARS_PRODUCTS.csv")

green_products <- as.data.table(green_products)
all.products <- as.data.table(all.products)

#merge

merge.allproducts = merge(all.products, green_products, by="product_code")
merge.full = merge(all.products, green_products, by="product_code", all.x = TRUE)

#guardar documento
write.csv(merge.full, file = "merge.full.csv")