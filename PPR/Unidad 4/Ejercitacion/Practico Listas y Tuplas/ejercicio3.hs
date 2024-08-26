{-
1.	Definir la lista de precios 
2.	Retornar el promedio de los precios de los productos
3.	Buscar si un elemento está en la lista, si está, retornar su doble sino su negativo
4.	Retornar una lista con los precios aumentados en un 10%
-}

--Ejercicio3.hs
--lista de importes productos
lista::[Float]
lista = [1.5, 2.4, 3.0, 7.6, 29.8, 33.6]

--2.	Retornar el promedio de los precios de los productos
-- promedio = sumatoria / cantidad
punto2::[Float] -> Float
punto2 lista = sum lista / fromIntegral(length lista)

--3.	Buscar si un elemento está en la lista, 
--si está, retornar su doble sino su negativo
punto3::[Float]->Float->Float
punto3 lista x = if (elem x lista)
		   then x * 2
		   else (-1) * x

--4.	Retornar una lista con los precios aumentados en un 10%
--map funcion xs
aumento:: Float -> Float
aumento p = p + (p * 0.10)

punto4::[Float]->[Float]
punto4 lista = map aumento lista
