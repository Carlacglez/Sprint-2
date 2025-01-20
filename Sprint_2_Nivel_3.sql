-- NIVEL 3

/*Presenta el nombre, teléfono, país, fecha y amount, de aquellas
 empresas que realizaron transacciones con un valor comprendido
 entre 100 y 200 euros y en alguna de estas fechas: 29 de abril de 2021, 20 de julio de 2021 y 13 de marzo de 2022.
 Ordena los resultados de mayor a menor cantidad. */  
 
 

SELECT company_name, phone, country, timestamp, amount
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE date(timestamp) IN ('2021-04-29', '2021-07-20', '2022-03-13') 
AND transaction.amount BETWEEN 100 AND 200
ORDER BY amount DESC;






/* Ejercicio 2
Necesitamos optimizar la asignación de los recursos y dependerá 
de la capacidad operativa que se requiera, por lo que te piden 
la información sobre la cantidad de transacciones que realizan las empresas,
pero el departamento de recursos humanos es exigente y quiere un listado de 
las empresas donde especifiques si tienen más de 4 o menos transacciones.*/

SELECT company.company_name as nombre, count(transaction.amount) as monto,
CASE
    WHEN count(transaction.amount) > 4 THEN 'Más de 4'
    WHEN count(transaction.amount) < 4 THEN 'Menos de 4'
    ELSE '4 transacciones'
END AS Numero_transacciones-- tengo que hacer un case
FROM company
JOIN transaction ON company.id = transaction.company_id
GROUP BY company.company_name
ORDER BY monto DESC;