-- SPRINT 2 NIVEL 2

/* 1) Identifica los cinco días que se generó la mayor cantidad de ingresos en la empresa por ventas.
 Muestra la fecha de cada transacción junto con el total de las ventas*/
 
 
 -- hago la suma de los ingresos, filtro los declined ya que nos estan pidiendo las ventas no todas las transacciones 
 
SELECT date(timestamp) AS Fecha, sum(amount) Total_ingresos
FROM transaction
WHERE declined = 0 
GROUP BY Fecha
ORDER BY Total_ingresos DESC 
LIMIT 5;



-- 2) ¿Cuál es la media de ventas por país? Presenta los resultados ordenados de mayor a menor medio.

 SELECT company.country as Pais, round(avg(transaction.amount),2) as Media_monto 
FROM company
	LEFT JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0
GROUP BY company.country
ORDER BY Media_monto DESC;

/*Ejercicio 3
En tu empresa, se plantea un nuevo proyecto para lanzar algunas campañas publicitarias 
para hacer competencia a la compañía “Non Institute”. Para ello, te piden la lista de todas las transacciones 
realizadas por empresas que están ubicadas en el mismo país que esta compañía.

Muestra el listado aplicando JOIN y subconsultas.
Muestra el listado aplicando solo subconsultas.*/
 

SELECT *
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE company_name != 'Non Institute' AND country = (SELECT country
													 FROM company
                                                     WHERE company_name = 'Non Institute');

-- Si hago la misma consulta solo con subconsultas

SELECT * 
FROM transaction
WHERE transaction.company_id IN (SELECT id
								 FROM company
								 WHERE company.company_name != 'Non Institute' AND company.country= (SELECT country
																									 FROM company
                                                                                                     WHERE company_name = 'Non Institute'));                                