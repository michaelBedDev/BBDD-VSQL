--Consulta con 4 columnas: el n�mero identificador, el nombre completo (apellido 1
--apellido2, nombre), los d�as que lleva contratado en la empresa y la cuota de ventas, de
--cada uno de los empleados que est�n asignados a alg�n cliente. Si alg�n vendedor no
--tiene cuota asignada deber� aparecer un 0 en su lugar.
--En el resultado deben aparecer primero los empleados que lleven menos d�as contratados.
--IMPORTANTE: No puedes usar ning�n tipo de join ni tampoco una consulta compuesta.

use empresa;

select e.numero, rtrim(e.ape1 + ' ' + isnull(e.ape2,' '))+', ' + e.nome as nome_completo,
datediff(day, e.data_contrato, getdate()) as dias_contratado, 
isnull(e.cota_de_vendas,0) as ventas_a_alcanzar
from EMPREGADO e
where e.numero in (select c.num_empregado_asignado
					from CLIENTE c)
ORDER BY dias_contratado;

use empresa;
--Consulta que devuelva la lista de los pedidos que hace m�s de 50 meses y menos de 60
--meses que se han realizado.
--IMPORTANTE: Para hacer la comprobaci�n de los meses que hace que se ha realizado el
--pedido no puedes usar ni la cl�usula IN, ni OR ni tampoco los operadores >=, >, <, <=, !=, =
--<>.
--En el resultado deber� aparecer el n�mero del pedido y en una segunda columna la
--fecha del pedido con formato dd-mm-aaaa (F�jate que se separan con guiones y ll�male
--FechaPed).
--Deben aparecer los pedidos m�s recientes primero. Aseg�rate que aparecen bien
--ordenados.

select p.numero, CONVERT(char(20),p.data_pedido,105) as FechaPed
from PEDIDO p
where DATEDIFF(month,p.data_pedido,GETDATE()) between 109 and 115
ORDER BY p.data_pedido desc;

--Utiliza una consulta compuesta para obtener el c�digo de los productos de los que no se
--han hecho pedidos. En el resultado deben aparecer el identificador del fabricante y el del
--producto en una �nica columna de nombre PRODUCTOS SIN PEDIDO, por ejemplo
--aparecer� ASUAK47A. El resultado deber� aparecer ordenado alfab�ticamente.
--IMPORTANTE: El nombre de la columna debe ser exactamente el que se indica, incluidos
--los espacios en blanco.

select (pr.cod_fabricante + pr.identificador) as 'PRODUCTOS SIN PEDIDO'
from PRODUTO pr
EXCEPT
select p.cod_fabricante + p.id_produto
from PEDIDO p
ORDER BY 'PRODUCTOS SIN PEDIDO'

--Consulta que devuelva el nombre de cada uno de los empleados de la BD, su fecha de
--contrato con formato dd/mm/aaaa y en otra tercera columna el importe medio de los
--pedidos del empleado (o llamado tambi�n vendedor).
--Si existiese alg�n vendedor (empleado) que no ha vendido nada, en la columna del
--importe medio deber� aparecer la frase �ESTE EMPLEADO NO TIENE PEDIDOS�.
--S�lo se mostrar�n los empleados cuyo pedido m�s caro no supere los 20000� de
--importe y que adem�s, hayan sido contratados un d�a 1, 6 � 26 de cualquier mes y de
--cualquier a�o.
--En la columna del importe medio se deber�n mostrar los importes con 8 d�gitos como
--m�ximo en la parte entera y 2 decimales.
--Deber�n aparecer primero en el resultado los empleados con mayor importe medio. En
--caso de que hubiese varios empleados con el mismo importe medio, deber�n aparecer
--primero los que tienen mayor antig�edad en la empresa. Aseg�rate que aparecen bien
--ordenados.

use EMPRESA

select e.nome, convert(char(10),e.data_contrato,103) as FechaContrato,
isnull(convert(varchar(30),convert(numeric(10,2),avg(p.cantidade*pr.prezo))),'ESTE EMPLEADO NO TIENE PEDIDOS') as MediaPedidos
from (EMPREGADO e left join PEDIDO p on e.numero = p.num_empregado)
	left join  PRODUTO pr on p.cod_fabricante =pr.cod_fabricante and
	p.id_produto = pr.identificador
where day(e.data_contrato) in (1,6,26)
GROUP BY e.numero, e.nome, e.data_contrato
HAVING isnull(max(p.cantidade*pr.prezo),0)<=20000
order by avg(p.cantidade*pr.prezo) DESC, e.data_contrato;



--Consulta que devuelva el 50% de los socios cuyo nombre de pila tiene por segunda letra
--una A y que pagan cuotas cuyo importe sea mayor o igual que 29 y menor o igual que 100.
--La consulta mostrar� en 5 columnas el n�mero de socio, el nombre de pila, el primer
--apellido, el n�mero de caracteres del primer apellido, el nombre del mes en que naci� y el
--importe de la cuota que paga. El nombre del mes en que naci� y el importe de la cuota
--aparecer�n en una �nica columna separados por un gui�n (-). Esta columna se llamar�
--MesNac-Cuota (con un gui�n medio).
--El resultado deber� aparecer ordenado por mes de nacimiento, es decir, los de enero
--aparecer�n antes que los de febrero, los de febrero antes que los de marzo, y as�
--sucesivamente.use SOCIOSselect top 50 percent s.numero,s.nome, s.ape1, len(s.ape1) as long_ape1, datename(month,s.data_nac)+'-'+convert(varchar(10),c.importe) as 'SOCIEDADE CULTURAL'from SOCIO s inner join cota c on s.cod_cuota=c.codigowhere SUBSTRING(s.nome,2,1) = 'A' and c.importe between 29 and 100order by month(s.data_nac)