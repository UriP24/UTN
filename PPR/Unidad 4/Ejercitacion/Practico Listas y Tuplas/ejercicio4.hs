{-
1.	Definir la lista de precios 
2.	Retornar el promedio de los precios de los productos
3.	Retornar la sumatoria de los precios precios mayores a 2
4.	Retornar la sumatoria de los precios mayores a un valor pasado por parametro
5.	Retornar una lista con los precios aumentados en un 10%, usando recursividad y listas por compresión
-}

-- Ejercicio4.hs
--lista de importes productos
lista::[Float]
lista = [1.5,2.4,3.0,7.6,29.8,33.6]

--2.	Retornar el promedio de los precios de los productos
--calcular la sumatoria y la cantidad
suma::[Float] -> Float
--funcion de corte
suma [] = 0
--funcion recursiva
suma (x:xs) = x + suma xs

conteo::[Float]->Int
--corte
conteo [] = 0
--recursivo
conteo (x:xs) = 1 + conteo xs

punto2::[Float]->Float
punto2 lista = suma lista / fromIntegral(conteo lista)

--3.	Retornar la sumatoria de los precios mayores a 2
punto3::[Float]->Float
punto3 [] = 0
punto3 (x:xs) = if (x > 2)
		   then x + punto3 xs
		   else punto3 xs

--4.	Retornar la sumatoria de los precios mayores 
--a un valor pasado por parametro
punto4::[Float] -> Float -> Float
punto4 [] _ = 0
punto4 (x:xs) p = if (x > p)
		     then x + punto4 xs p
		     else punto4 xs p

--5.	Retornar una lista con los precios aumentados en un 10%, 
-- usando recursividad y listas por compresión
--auxiliar que incrementa en 10%
aumento::Float->Float
aumento p = p + ( p * 0.10)

--recursividad
punto5a::[Float]->[Float]
punto5a [] = []
punto5a (x:xs) = (aumento x) : punto5a xs

-- lista por comprension
punto5b::[Float]->[Float]
punto5b lista = [ (aumento x) | x <-lista ]










