use empresa

--Proposta 1. Nome de todos os fabricantes dos que se fixeron pedidos. Debes
--propo�er d�as soluci�ns, unha coa sintaxe coa condici�n de combinaci�n no
--WHERE, e outra coa sintaxe coa condici�n de combinaci�n no FROM.
select f.nome
from FABRICANTE f, PEDIDO p
where f.codigo = p.cod_fabricante
GROUP BY f.nome

select distinct f.nome
from FABRICANTE f INNER JOIN PEDIDO p
	ON f.codigo = p.cod_fabricante



--� Proposta 2. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron
--pedidos aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun
--fabricante se fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como n�mero de pedido deber� aparecer o
--valor 99.
select f.nome,
	ISNULL (p.numero,99) as num_pedido
from FABRICANTE f LEFT JOIN PEDIDO p
	ON p.cod_fabricante = f.codigo


--� Proposta 3. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron
--pedidos aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun
--fabricante se fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como n�mero de pedido deber� aparecer a
--frase 'Sen pedidos.'.

select f.nome,
	ISNULL (cast(p.numero as varchar(15)), 'Sen Pedidos') 
as num_pedido
from FABRICANTE f LEFT JOIN PEDIDO p
	ON p.cod_fabricante = f.codigo


--� Proposta 4. C�digo dos produtos (co formato cod_fabricante-id_produto) e
--descrici�n, dos produtos que non foron pedidos nunca.

select pr.cod_fabricante + ' - ' + pr.identificador as 'C�digo de productos', pr.descricion
from PRODUTO pr LEFT JOIN PEDIDO p
	ON pr.identificador = p.id_produto
where p.numero is null

--� Proposta 5. Produto cartesiano entre a t�boa de sucursais e a de empregados.
--Nunha primeira columna aparecer� a cidade da sucursal e na segunda o nome
--completo do empregado (co formato nome ape1 ape2). D�bense propo�er d�as
--soluci�ns, segundo a sintaxe empregada para o produto cartesiano.

select s.cidade, em.nome + ', ' + em.ape1 + ', ' + ISNULL(em.ape2,'') as 'Nome empregado'
from SUCURSAL s CROSS JOIN EMPREGADO em

select s.cidade, em.nome + ', ' + em.ape1 + ', ' + ISNULL(em.ape2,'') as 'Nome empregado'
from SUCURSAL s, EMPREGADO em

--� Proposta 6. N�mero e nome completo (co formato nome ape1 ape2) de todos os
--empregados, as� como a cidade da sucursal que dirixen, se � que dirixen algunha. Na
--terceira columna, de nome sucursal_que_dirixe, nas filas dos empregados que non
--son directores de sucursais, deber� aparecer a frase 'Non � director.'.

select em.numero, 
em.nome + ', ' + em.ape1 + ', ' +  ISNULL(em.ape2,'') as 'Nome empregado',
ISNULL (s.cidade,'Non � director') as 'Cidade dirixida'
from EMPREGADO em LEFT JOIN  SUCURSAL s
	ON em.numero = s.num_empregado_director

--� Proposta 7. N�mero e nome completo dos empregados que te�en xefe, co n�mero
--e o nome completo do seu xefe nunha segunda columna. (Revisa o concepto
--� Autocombinaci�n ou self join). Nas columnas aparecer�n o n�mero separado do
--nome completo por un gui�n.

select 
e.numero,  e.nome + ', ' + e.ape1 + ', ' + ISNULL(e.ape2,'') as 'Nome empregado',

jefe.numero, jefe.nome + ', ' + jefe.ape1 + ', ' + ISNULL(jefe.ape2,'Nome jefe') as 'Nome xefe'

from EMPREGADO e JOIN EMPREGADO jefe
	ON  e.num_empregado_xefe=jefe.numero 

--� Proposta 8. N�mero e nome completo de todos os empregados, co n�mero e o
--nome completo do seu xefe nunha segunda columna. Nas columnas aparecer�n o
--n�mero separado do nome completo por un gui�n. Se alg�n empregado non tivese
--xefe, na segunda columna debe aparecer a frase 'Xefe por designar.'

select 
cast(e.numero as varchar(5)) + ' - ' + e.nome + ', ' + e.ape1 + ', ' + ISNULL(e.ape2,'') as 'Nome empregado',

ISNULL(cast(jefe.numero as varchar(5)) + ' - ' + jefe.nome + ', ' + jefe.ape1 + ', ' + ISNULL(jefe.ape2,'Nome jefe'),'Xefe por designar') as 'Nome Xefe'

from EMPREGADO e LEFT JOIN EMPREGADO jefe
	ON  e.num_empregado_xefe=jefe.numero 




--� Proposta 9. Nome completo de todos os empregados co nome do cliente que te�en
--asignado. No caso de que non tivesen ning�n cliente aparecer� no nome do cliente a
--frase 'Sen cliente.'. Do mesmo xeito se un cliente non ten empregado asignado, na
--columna do empregado aparecer� 'Sen vendedor.'. � importante que aparezan
--todos os empregados, te�an ou non clientes e todos os clientes te�an ou non
--empregados.

select ISNULL(e.nome + ', ' + e.ape1 + ', ' + ISNULL(e.ape2,''), 'Sen empregado') as 'Nome empregado',
	   ISNULL(c.nome, 'Sen cliente') as 'Nome cliente'
from EMPREGADO e FULL JOIN CLIENTE c
	ON e.numero = c.num_empregado_asignado


--� Proposta 10. Escolle unha das t�as soluci�ns das consultas propostas nas que
--empregaches un LEFT JOIN, e modif�caa usando RIGHT JOIN.

select f.nome,
	ISNULL (p.numero,99) as num_pedido
from PEDIDO p RIGHT JOIN FABRICANTE f
	ON p.cod_fabricante = f.codigo

--primer consulta left join
