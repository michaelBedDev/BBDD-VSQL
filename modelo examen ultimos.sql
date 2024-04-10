--1. BD EMPLEADOS. Consulta que devuelve en una primera columna la descripción y el precio de 
--todos los productos, separados por una barra invertida (por ejemplo ARTICULO TIPO2 \ 76), y en 
--una segunda columna el gasto total en pedidos de ese producto. Entre la descripción y la barra 
--invertida sólo puede existir un espacio en blanco y entre la barra invertida y el precio otro espacio 
--en blanco.
--En el resultado sólo podrán aparecer aquellos productos cuyo gasto medio es menor de 3000€.
--La primera columna se llamará Producto y la segunda Gasto total.
--Si de algún producto no se han realizado pedidos en la columna del Gasto total deberá aparecer la
--frase PRODUCTO QUE TODAVIA NO SE HA VENDIDO.
--La columna del gasto total deberá mostrar los importes con 6 dígitos como máximo en la parte 
--entera y 2 decimales.
--Deberán aparecer primero en el resultado los productos con mayor gasto total.

use EMPLEADOS

--select rtrim(pr.DESCRIPCION) +' \ ' + ltrim(convert(varchar,pr.PRECIO,50)) as Producto, sum(p.importe) as 'Gasto total'
--from PRODUCTO pr left join PEDIDO p on ID_FAB = FAB and ID_PRODUCTO = PRODUCTO
--group by pr.ID_FAB+pr.ID_PRODUCTO, pr.DESCRIPCION, pr.PRECIO
--having AVG(p.importe)<3000

select rtrim(pr.descripcion)+ ' \ ' + ltrim(convert(varchar,pr.precio,50)) as Producto, 
isnull(convert(varchar,convert(numeric(8,2),sum(importe)),10),'Todavía no se ha vendido') as GastoTotal
from PRODUCTO pr left join PEDIDO p on p.PRODUCTO = pr.ID_PRODUCTO and p.FAB = pr.ID_FAB
group by p.FAB,p.PRODUCTO, pr.DESCRIPCION, pr.PRECIO
having isnull(avg(p.importe),0)<3000
order by sum(p.importe) desc

--1.2. BD EMPLEADOS. Consulta que devuelva la lista de los pedidos que hace más de 24 años y menos 
--de 28 años que se han realizado.
--IMPORTANTE: Para hacer la comprobación de los años que hace que se ha realizado el pedido no 
--puedes usar ni la cláusula IN, ni OR ni tampoco los operadores >=, >, <=, !=, = <>.
--En el resultado deberá aparecer el número del pedido, en una segunda columna la fecha del 
--pedido con formato dd-mm-aaaa (Fíjate que se separan con guiones y llámale FechaPed) y en una 
--tercera columna de nombre Unidades aparecerá lo siguiente en función del número de unidades 
--solicitadas en el pedido:
--- Si la cantidad de unidades del pedido es menor que 7 aparecerá el texto POCAS.
--- Si la cantidad de unidades del pedido es mayor o igual que 7 y menor que 30 aparecerá el 
--texto NORMAL.
--- Si la cantidad de unidades del pedido es mayor o igual que 30 aparecerá el texto MUCHAS.
--Deben aparecer los pedidos más recientes primero. Asegúrate que aparecen bien ordenados.
--1.3. BD EMPLEADOS. Consulta que devuelva la ciudad de cada una de las oficinas de la BD, su región en
--minúsculas y en otra tercera columna el importe del pedido más barato de la oficina. Ten en cuenta 
--que un pedido es de una oficina si ha sido realizado por un representante de ventas que trabaja en 
--esa oficina.
--Sólo se mostrarán las oficinas con objetivo de ventas superior a 500000, y que además el pedido 
--con mayor importe (pedido de importe máximo) no supera los 30000€.
--Si existiese alguna oficina que no ha vendido nada, no aparecerá en el resultado.
--2ª EVALUACIÓN UD5. RECUPERAR INFORMACIÓN DE LA BASE DE DATOS (DML) PRÁCTICA
--BASES DE DATOS EXAMEN
--Docente: Mónica García Constenla
--IES San Clemente
-- página 2
--1.4. BD EMPRESA. Consulta que devuelva el nombre de cada cliente y al lado la media de unidades 
--compradas en sus pedidos, sólo para aquellos clientes cuyo empleado asignado/vendedor trabaje 
--en una oficina de la región oeste. Si el cliente no ha comprado nada como media de unidades 
--deberá aparecer 0.
--La columna de las unidades medias tendrá 4 dígitos como máximo en la parte entera y 1 decimal.
--En el resultado deberán aparecen primero los clientes que tengan mayor número de unidades 
--medias.
--1.5. BD EMPRESA. Consulta que devuelva el total de productos de cada fabricante. En el resultado 
--aparecerán dos columnas: el nombre del fabricante y el total de productos del fabricante.
--Deberá mostrarse en primer lugar aquellos fabricantes que tienen más productos. Si varios 
--fabricantes tienen el mismo número de productos deberán aparecer ordenados alfabéticamente 
--por nombre, por ejemplo:
--ASUS 10
--LOGITECH 5
--TOSHIBA 5
--1.6. BD EMPRESA. Sin usar joins ni subconsultas realiza la consulta que muestre la descripción y el 
--precio de los productos de los que todavía no se han hecho pedidos. En el resultado aparecerán 
--primero los productos más caros.
--1.7. BD EMPRESA. Realiza la consulta anterior usando join.
--1.8. BD EMPRESA. Listado de las sucursales cuyo objetivo es mayor que 300.000 y en ellas trabajan 
--empleados cuyo primer apellido acaba por Z o su segundo apellido tiene más de 5 letras. En el 
--resultado aparecerá el identificador de la oficina separado de la ciudad por un guión medio, por 
--ejemplo 11-BARCELONA.
--1.9. BD EMPRESA. Consulta que devuelva el nombre y apellidos de cada empleado (con formato 
--nombre ape1 ape2) y en una segunda columna el número identificador del director de la oficina en 
--la que trabaja el empleado. Ordena el resultado alfabéticamente por apellidos y nombre del 
--empleado.
--1.10. BD EMPRESA. Repite la consulta anterior pero en la segunda columna en lugar de aparecer el 
--número identificador del director de la oficina deberá aparecer el nombre del director con formato 
--nombre ape1 ape2.
--1.11. BD EMPRESA. Listado del nombre de todos los clientes siempre que haya alguno cuyo límite de 
--crédito supere los 65.000€
--1.12. BD EMPRESA. En una única columna deberán aparecer todas las ciudades de las sucursales y todas 
--las regiones ordenadas alfabéticamente. La columna se llamará SUCURSALES Y REGIONES (respeta 
--los espacios en blanco del nombre de la columna).
--1.13. BD EMPRESA. Usando una consulta compuesta devuelve el nombre de los clientes que hicieron 
--pedidos