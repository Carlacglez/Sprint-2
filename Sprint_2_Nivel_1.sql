-- SPRINT 2 NIVEL 1

-- EJERCICIO 2
-- Utilizando JOIN realizarás las siguientes consultas:

-- 01) Listado de paises que estan haciendo compras 
SELECT DISTINCT country
FROM company
	JOIN transaction ON company.id = transaction.company_id;

-- me aseguro de mirar si alguno de los paises hizo una compra pero despues la canceló pero da el mismo resultado 15 rows;


-- 02) Desde cuántos países se realizan las compras.

SELECT COUNT(DISTINCT country) AS Numero_Paises
FROM company
	JOIN transaction ON company.id = transaction.company_id;
-- el resultado arroja 15 al igual que la consulta anterior 



-- 03) Identifica a la compañía con la mayor media de ventas.


SELECT company.company_name as Name, round(AVG(transaction.amount),2) as AvgAmount
FROM company
	JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0 -- aqui como es ventas hay que sacar las transacciones declined 
GROUP BY Name
ORDER BY AvgAmount DESC
LIMIT 1;  


-- EJERCICIO 3 
-- Utilizando sólo subconsultas (sin utilizar JOIN):

-- 1) Muestra todas las transacciones realizadas por empresas de Alemania.

-- primero lo hago con join para saber cuantas rows me deberia devolver, son 118 rows 
/*SELECT company.company_name as nombre, company.country , transaction.amount as monto
FROM company
	JOIN transaction ON company.id = transaction.company_id
WHERE company.country  = "Germany";*/


SELECT *
FROM transaction
WHERE transaction.company_id IN (SELECT id
								 FROM company
								 WHERE company.country = 'Germany');
								
                                                                
                                
-- 2) Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones.

SELECT company.company_name
FROM company
WHERE company.id IN (SELECT transaction.company_id
					 FROM transaction
                     WHERE transaction.amount > (SELECT avg(transaction.amount)
                                                 FROM transaction))
ORDER BY company.company_name;



-- 3) Eliminarán del sistema las empresas que carecen de transacciones registradas, entrega el listado de estas empresas.

SELECT company.id
FROM company
WHERE company.id NOT IN (SELECT transaction.company_id
						 FROM transaction);
                         
-- Como el resultado es 0 significa que todas las compañias tienen transacciones registradas ya sean declined o no. 


								