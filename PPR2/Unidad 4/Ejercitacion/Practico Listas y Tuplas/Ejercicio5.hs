{-
1.	Definir la lista de productos 
2.	Retornar el promedio de los precios de los productos
3.	Mostrar los nombres de todos los productos
4.	Retornar una lista con los precios de todos los productos, que sean mayores a un valor pasado por parametro 
5.	Retornar la sumatoria de los precios que se encuentren en un rango de valores pasados por parametro
-}

-- Ejercicio5.hs
--lista de productos, la tupla representa producto(nombre, precio)
lista::[(String, Float)]
lista = [("Tornillo",1.5), ("Tuerca",2.4), ("Anillo",3.0)]

--lst
importeProducto:: (String, Float) -> Float
importeProducto (_,precio) = precio

--fst
nombreProducto:: (String, Float) -> String
nombreProducto (nombre,_) = nombre

--cuando usan tuplas
-- sum(lista)  NO APLICA en este ejemplo
--length(lista) la cantidad de elementos de la lista, se podría usar 

--2.	Retornar el promedio de los precios de los productos
suma:: [(String, Float)] -> Float
suma [] = 0
suma (x:xs) = importeProducto x + suma xs

funcion2::[(String, Float)] -> Float
funcion2 lista = suma lista / fromIntegral(length lista)

--3.	Mostrar los nombres de todos los productos
funcion3::[(String, Float)] -> String
funcion3 [] = ""
funcion3 (x:xs) = show(nombreProducto x) ++ " " ++ funcion3 xs

--4.	Retornar una lista con los precios de todos los productos, 
-- que sean mayores a un valor pasado por parametro
funcion4::[(String, Float)] -> Float -> [Float]
funcion4 lista p = [ ( importeProducto x) | x <- lista, (importeProducto x) > p]

--5.	Retornar la sumatoria de los precios que se encuentren en un 
--rango de valores pasados por parametro
funcion5::[(String, Float)] -> Float -> Float -> Float
--corte
funcion5 [] _ _ = 0
funcion5 (x:xs) inf sup = let p = importeProducto x in if (p >= inf && p <= sup)
							 then p + funcion5 xs inf sup
							 else funcion5 xs inf sup



