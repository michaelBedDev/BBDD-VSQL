--1. BD EMPLEADOS. Consulta que devuelve en una primera columna la descripci�n y el precio de 
--todos los productos, separados por una barra invertida (por ejemplo ARTICULO TIPO2 \ 76), y en 
--una segunda columna el gasto total en pedidos de ese producto. Entre la descripci�n y la barra 
--invertida s�lo puede existir un espacio en blanco y entre la barra invertida y el precio otro espacio 
--en blanco.
--En el resultado s�lo podr�n aparecer aquellos productos cuyo gasto medio es menor de 3000�.
--La primera columna se llamar� Producto y la segunda Gasto total.
--Si de alg�n producto no se han realizado pedidos en la columna del Gasto total deber� aparecer la
--frase PRODUCTO QUE TODAVIA NO SE HA VENDIDO.
--La columna del gasto total deber� mostrar los importes con 6 d�gitos como m�ximo en la parte 
--entera y 2 decimales.
--Deber�n aparecer primero en el resultado los productos con mayor gasto total.

use EMPLEADOS

--select rtrim(pr.DESCRIPCION) +' \ ' + ltrim(convert(varchar,pr.PRECIO,50)) as Producto, sum(p.importe) as 'Gasto total'
--from PRODUCTO pr left join PEDIDO p on ID_FAB = FAB and ID_PRODUCTO = PRODUCTO
--group by pr.ID_FAB+pr.ID_PRODUCTO, pr.DESCRIPCION, pr.PRECIO
--having AVG(p.importe)<3000

select rtrim(pr.descripcion)+ ' \ ' + ltrim(convert(varchar,pr.precio,50)) as Producto, 
isnull(convert(varchar,convert(numeric(8,2),sum(importe)),10),'Todav�a no se ha vendido') as GastoTotal
from PRODUCTO pr left join PEDIDO p on p.PRODUCTO = pr.ID_PRODUCTO and p.FAB = pr.ID_FAB
group by p.FAB,p.PRODUCTO, pr.DESCRIPCION, pr.PRECIO
having isnull(avg(p.importe),0)<3000
order by sum(p.importe) desc

--1.2. BD EMPLEADOS. Consulta que devuelva la lista de los pedidos que hace m�s de 24 a�os y menos 
--de 28 a�os que se han realizado.
--IMPORTANTE: Para hacer la comprobaci�n de los a�os que hace que se ha realizado el pedido no 
--puedes usar ni la cl�usula IN, ni OR ni tampoco los operadores >=, >, <=, !=, = <>.
--En el resultado deber� aparecer el n�mero del pedido, en una segunda columna la fecha del 
--pedido con formato dd-mm-aaaa (F�jate que se separan con guiones y ll�male FechaPed) y en una 
--tercera columna de nombre Unidades aparecer� lo siguiente en funci�n del n�mero de unidades 
--solicitadas en el pedido:
--- Si la cantidad de unidades del pedido es menor que 7 aparecer� el texto POCAS.
--- Si la cantidad de unidades del pedido es mayor o igual que 7 y menor que 30 aparecer� el 
--texto NORMAL.
--- Si la cantidad de unidades del pedido es mayor o igual que 30 aparecer� el texto MUCHAS.
--Deben aparecer los pedidos m�s recientes primero. Aseg�rate que aparecen bien ordenados.
--1.3. BD EMPLEADOS. Consulta que devuelva la ciudad de cada una de las oficinas de la BD, su regi�n en
--min�sculas y en otra tercera columna el importe del pedido m�s barato de la oficina. Ten en cuenta 
--que un pedido es de una oficina si ha sido realizado por un representante de ventas que trabaja en 
--esa oficina.
--S�lo se mostrar�n las oficinas con objetivo de ventas superior a 500000, y que adem�s el pedido 
--con mayor importe (pedido de importe m�ximo) no supera los 30000�.
--Si existiese alguna oficina que no ha vendido nada, no aparecer� en el resultado.
--2� EVALUACI�N UD5. RECUPERAR INFORMACI�N DE LA BASE DE DATOS (DML) PR�CTICA
--BASES DE DATOS EXAMEN
--Docente: M�nica Garc�a Constenla
--IES San Clemente
-- p�gina 2
--1.4. BD EMPRESA. Consulta que devuelva el nombre de cada cliente y al lado la media de unidades 
--compradas en sus pedidos, s�lo para aquellos clientes cuyo empleado asignado/vendedor trabaje 
--en una oficina de la regi�n oeste. Si el cliente no ha comprado nada como media de unidades 
--deber� aparecer 0.
--La columna de las unidades medias tendr� 4 d�gitos como m�ximo en la parte entera y 1 decimal.
--En el resultado deber�n aparecen primero los clientes que tengan mayor n�mero de unidades 
--medias.
--1.5. BD EMPRESA. Consulta que devuelva el total de productos de cada fabricante. En el resultado 
--aparecer�n dos columnas: el nombre del fabricante y el total de productos del fabricante.
--Deber� mostrarse en primer lugar aquellos fabricantes que tienen m�s productos. Si varios 
--fabricantes tienen el mismo n�mero de productos deber�n aparecer ordenados alfab�ticamente 
--por nombre, por ejemplo:
--ASUS 10
--LOGITECH 5
--TOSHIBA 5
--1.6. BD EMPRESA. Sin usar joins ni subconsultas realiza la consulta que muestre la descripci�n y el 
--precio de los productos de los que todav�a no se han hecho pedidos. En el resultado aparecer�n 
--primero los productos m�s caros.
--1.7. BD EMPRESA. Realiza la consulta anterior usando join.
--1.8. BD EMPRESA. Listado de las sucursales cuyo objetivo es mayor que 300.000 y en ellas trabajan 
--empleados cuyo primer apellido acaba por Z o su segundo apellido tiene m�s de 5 letras. En el 
--resultado aparecer� el identificador de la oficina separado de la ciudad por un gui�n medio, por 
--ejemplo 11-BARCELONA.
--1.9. BD EMPRESA. Consulta que devuelva el nombre y apellidos de cada empleado (con formato 
--nombre ape1 ape2) y en una segunda columna el n�mero identificador del director de la oficina en 
--la que trabaja el empleado. Ordena el resultado alfab�ticamente por apellidos y nombre del 
--empleado.
--1.10. BD EMPRESA. Repite la consulta anterior pero en la segunda columna en lugar de aparecer el 
--n�mero identificador del director de la oficina deber� aparecer el nombre del director con formato 
--nombre ape1 ape2.
--1.11. BD EMPRESA. Listado del nombre de todos los clientes siempre que haya alguno cuyo l�mite de 
--cr�dito supere los 65.000�
--1.12. BD EMPRESA. En una �nica columna deber�n aparecer todas las ciudades de las sucursales y todas 
--las regiones ordenadas alfab�ticamente. La columna se llamar� SUCURSALES Y REGIONES (respeta 
--los espacios en blanco del nombre de la columna).
--1.13. BD EMPRESA. Usando una consulta compuesta devuelve el nombre de los clientes que hicieron 
--pedidos