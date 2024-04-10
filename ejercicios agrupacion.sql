use EMPLEADOS

-- TAREA 1: Resuelve las siguientes consultas en la BD EMPLEADOS usando T-SQL. Aunque en esta
--pr�ctica se trata de repasar sentencias con agrupamiento, deber�s decidir si es necesario usarlo o no
--en las consultas que se te plantean.
--1.1. Media de ventas de todas las oficinas.

select avg(o.VENTAS) as media_ventas
from OFICINA o

--1.2. Gasto total realizado por el cliente ACME MFG.

select * from CLIENTE

select sum(p.IMPORTE) as gasto_total
from CLIENTE c join PEDIDO p on p.CLIE = c.NUM_CLIE
where c.EMPRESA='ACME MFG.'

--1.3. Gasto total realizado por cada cliente. En el resultado aparecer� el nombre de la empresa cliente y
--en una segunda columna el importe del gasto en pedidos que lleva realizado el cliente hasta ahora.
--En el resultado deber�n aparecer primero los clientes con mayor gasto.

select c.empresa, isnull(sum(p.IMPORTE),0) as gasto_total
from CLIENTE c left join PEDIDO p on p.CLIE = c.NUM_CLIE
group by c.NUM_CLIE, c.EMPRESA
order by gasto_total desc

--1.4. Realiza de nuevo la consulta anterior, pero ahora s�lo deber�n aparecer los clientes que hayan
--realizado m�s de 10000 euros de gasto total.

select c.empresa, sum(p.IMPORTE) as gasto_total
from CLIENTE c join PEDIDO p on p.CLIE = c.NUM_CLIE
group by c.NUM_CLIE, c.EMPRESA
having sum(p.IMPORTE) >=10000
order by gasto_total desc

--1.5. Realiza de nuevo la consulta anterior, pero ahora s�lo deber�n aparecer los clientes que hayan
--realizado m�s de 10000 euros de gasto total y adem�s hayan hecho m�s de 2 pedidos.

select c.empresa, sum(p.IMPORTE) as gasto_total
from CLIENTE c join PEDIDO p on p.CLIE = c.NUM_CLIE
group by c.NUM_CLIE, c.EMPRESA
having sum(p.IMPORTE) >=10000 and 
count(p.num_pedido)>2
order by gasto_total desc

--1.6. Nombre de aquellos clientes cuyo l�mite de cr�dito supera el l�mite de cr�dito medio.
select c.EMPRESA, c.LIMITE_CREDITO
from CLIENTE c
where c.LIMITE_CREDITO > (select avg(c.LIMITE_CREDITO)
						  from CLIENTE c )

--1.7. C�digo y descripci�n del producto o productos con el precio menor.
select p.ID_PRODUCTO + ' ' + p.ID_FAB as cod_producto, p.DESCRIPCION, PRECIO 
from PRODUCTO p
where precio = (select min(precio)
				from PRODUCTO)

--1.8. N�mero total de pedidos que se han realizado del producto con descripci�n ARTICULO TIPO 2.
select COUNT(p.NUM_PEDIDO) as total_pedidos
from PEDIDO p join PRODUCTO pr on pr.ID_FAB = p.FAB and pr.ID_PRODUCTO=p.PRODUCTO
where pr.DESCRIPCION = 'ARTICULO TIPO 2'

--hecho hasta aqu�

--1.9. N�mero total de pedidos que se han realizado del producto con descripci�n ARTICULO TIPO 2 cuyo
--importe supera los 800 euros.
select COUNT(p.NUM_PEDIDO) as total_pedidos
from PEDIDO p join PRODUCTO pr on pr.ID_FAB = p.FAB and pr.ID_PRODUCTO=p.PRODUCTO
where pr.DESCRIPCION = 'ARTICULO TIPO 2' and p.IMPORTE >800

--1.10. N�mero total de pedidos de cada producto. En el resultado aparecer� la clave de cada producto, la
--descripci�n y el n�mero de pedidos que se han realizado de ese producto.
use EMPLEADOS
select pr.ID_FAB + pr.ID_PRODUCTO as codigo_producto, pr.descripcion, count(p.NUM_PEDIDO) as total_pedidos 
from PRODUCTO pr left join PEDIDO p  on pr.ID_FAB = p.FAB and pr.ID_PRODUCTO=p.PRODUCTO
group by pr.ID_FAB + pr.ID_PRODUCTO, pr.DESCRIPCION

--1.11. N�mero de t�tulos diferentes que tienen los representantes de ventas.
select count(distinct rp.TITULO) as total_titulos
from REPVENTAS rp

--1.12. Nombre de los empleados que son directores de m�s de una oficina.
select ofi.dir, rp.NOMBRE
from OFICINA ofi join REPVENTAS rp on ofi.DIR = rp.NUM_EMPL
group by ofi.DIR, rp.nombre
having count(oficina)>1

--1.13. Nombre de los vendedores que han realizado m�s de 3 pedidos.
select rp.NOMBRE, count(NUM_PEDIDO)
from REPVENTAS rp join PEDIDO p on rp.NUM_EMPL = p.REP
group by rp.num_empl, rp.NOMBRE
having count(NUM_PEDIDO)>3

--1.14. N�mero de oficinas que hay por regi�n. Aparecer� el nombre de la regi�n y en la misma columna
--separada por un gui�n, la cantidad de oficinas situadas en esa regi�n.
select rtrim(region) + '-' +convert(varchar,count(oficina)) as region
from OFICINA
group by region

--1.15. N�mero total de empleados que hay en cada oficina. Aparecer� la ciudad de la oficina y en una
--segunda columna la cantidad de empleados que trabajan en la misma.
select  ofi.CIUDAD, count(ofi.OFICINA) as total_empleados
from OFICINA ofi left join REPVENTAS rp on rp.OFICINA_REP = ofi.OFICINA
group by ofi.OFICINA, ofi.CIUDAD