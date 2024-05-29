--Funcion Cuadrado
cuadrado x = x^2

--Definicion del caso base
sumatoria 0 = 0
--Funcion Sumatoria
sumatoria x = x + sumatoria (x-1)

--ejercicio 18
sumatoria_18 0 = 0
sumatoria_18 x  | x > 0 = x + sumatoria_18 (x-1)
		| otherwise = -1

--ejercicio 20
sumatoria_20 x  | x == 0 = 0 
		| x>0 = x + sumatoria_18 (x-1) --debo aproximar al positivo a 0, disminuyendo
		| x<0 = x + sumatoria_18 (x+1) --debo aproximar al negativo a 0, aumentando

--ejercicio 21
contar [] = 0
contar(x:xs)= 1 + contar xs


--Ejercicio 22
cabeza (x:xs) = x

--Ejercicio 23
ultimo [v]=v
ultimo (x:xs) = ultimo xs

--Ejercicio 24
penultimo[v,b]=v
penultimo (x:xs) = penultimo xs

--Ejercicio 26
sumar::[Float] -> Float
sumar[]=0
sumar(x:xs) = x + sumar xs

-- Ejercicio 26
hay_algun_true [] = False
hay_algun_true(x:xs)  	| x = True
			| otherwise = hay_algun_true xs





