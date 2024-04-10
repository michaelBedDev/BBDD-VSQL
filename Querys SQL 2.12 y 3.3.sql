use EMPRESA

EXEC dbo.sp_changedbowner @loginame = N'sa', @map = false



--Proposta 1. Nome e apelidos (cada un nunha columna) de todos os empregados.
select e.nome, e.ape1
from EMPREGADO e

--– Proposta 2. Número, nome e apelidos (cada un nunha columna) de todos
--empregados.
select e.numero, e.nome, e.ape1, e.ape2
from EMPREGADO e

--– Proposta 3. Número, nome e apelidos (cada un nunha columna) de todos os
--empregados por orde alfabética de apelidos e nome.
select e.numero, e.nome, e.ape1, e.ape2
from EMPREGADO e
ORDER BY e.ape1 ASC, e.ape2 ASC, e.nome ASC

--– Proposta 4. Número, nome e apelidos (cada un nunha columna) de todos os
--empregados por orde alfabética de apelidos e nome. Os nomes das columnas no
--resultado serán: num_socio, nome_socio, apelido1, apelido2.
select e.numero as num_socio, e.nome as nome_socio, e.ape1 as apelido1, e.ape2 as apelido2
from EMPREGADO e

--– Proposta 5. Número, nome completo (os 4 campos nunha única columna, de nome
--socio, co formato numero - ape1 ape2, nome) e salario de todos os empregados. No
--resultado deberán aparecer primeiro os que máis cobran.
select e.ape1 +' ' + e.ape2 + ' ' + e.nome as socio, e.salario_mes
from EMPREGADO e
ORDER BY e.salario_mes DESC

--– Proposta 6. Número, nome completo (os 4 campos nunha única columna, de nome
--socio, co formato numero - ape1 ape2, nome) e salario de todo o profesorado. No
--resultado deberán aparecer primeiro os que máis cobran. O campo cargo contén
--PRF para o profesorado, e ADM se é un ou unha administrativo.
select cast(e.numero as varchar(5)) + ' - ' + e.ape1 + ' ' + e.ape2 + ', ' + e.nome as socio, e.salario_mes
from EMPREGADO e
WHERE e.cargo='PRF'
ORDER BY e.salario_mes DESC

--– Proposta 7. Número identificador do profesorado que imparte clases. Como é
--lóxico, se un profesor imparte máis dunha actividade, o seu número só pode
--aparecer unha vez.
select distinct e.numero
from EMPREGADO e, PROFESORADO p
where e.numero=p.num_prof

--– Proposta 8. Número identificador das actividades ás que asiste profesorado, é dicir,
--cursadas por profesorado.
select a.identificador
from ACTIVIDADE a, PROFE_CURSA_ACTI pca
where pca.num_profesorado is not null

--– Proposta 9. Nome, importe, e importe rebaixado un 20%, da actividade de nome
--xadrez.
select a.nome, a.prezo, a.prezo*0.8 as 'prezo 80%'
from ACTIVIDADE a
where a.nome='XADREZ'

--– Proposta 10. NIF, nome e apelidos dos socios dos que non temos teléfono gardado.
select s.nif, s.nome, s.ape1 + ' ' + s.ape2 as apellidos
from SOCIO s
where s.telefono1 is null and s.telefono2 is null

--– Proposta 11. NIF, nome, apelidos e data de nacemento dos socios nados entre 1980
--e 1990, ambos incluídos.
select s.nif, s.nome, s.ape1 + s.ape2 as apellidos, s.data_nac
from SOCIO s
where s.data_nac between '31-12-1979' and '1-1-1991'

--– Proposta 12. Todos os datos das actividades cuxo nome contén a letra T.
select *
from ACTIVIDADE a
where a.nome like 't%'

--– Proposta 13. Nome e importe das cotas cun custo de 30 ou 100 euros.
select c.nome, c.importe
from COTA c
where c.importe= 30 or c.importe = 100

--– Proposta 14. Nome e número de prazas das actividades que non teñen nin 15 nin 20
--prazas.
select a.nome, a.num_prazas
from ACTIVIDADE a
where a.num_prazas!=15 and a.num_prazas!=20

-- Consultas propostas na BD EMPRESA.
--– Proposta 15. Nome de todos os clientes por orde alfabética.
select c.nome
from CLIENTE c
ORDER BY c.nome ASC

--– Proposta 16. Nome das rexións nas que ten sucursais a empresa.
select s.rexion
from SUCURSAL s
where s.rexion is not null

--– Proposta 17. Identificador dos produtos que nos pediron nalgún momento. No
--resultado debe aparecer nunha soa columna o código do fabricante e o identificador
--do produto separados por un guión. A columna do resultado deberá chamarse
--produtos.
select distinct p.identificador + ' - ' + p.cod_fabricante as produtos
from PRODUTO p, PEDIDO ped
where ped.id_produto = p.identificador


--– Proposta 18. Información completa das sucursais non dirixidas polo empregado
--número 108.
select *
from SUCURSAL s
where s.num_empregado_director != 108

--– Proposta 19. Nome e límite de crédito do cliente número 1107.
select c.nome, c.limite_de_credito
from CLIENTE c
where c.numero=1107

--– Proposta 20. Número e data dos pedidos feitos entre o 1 de agosto e o 31 de
--decembro de 2014. Só debe aparecer a data de cada pedido, sen a hora, co formato
--dd-mm-aaaa. Deben aparecer primeiro no resultado os pedidos máis recentes. Para
--resolver esta consulta non se poden utilizar operadores de comparación (>, <, >=,
--<=, < >, !=).
select  convert (char(20), ped.data_pedido,103)
from PEDIDO ped
where ped.data_pedido between '01-08-2014' and '31-12-2014'
ORDER BY ped.data_pedido ASC

--– Proposta 21. Código e nome dos fabricantes cuxo nome ten por segunda letra O.
select f.codigo, f.nome
from FABRICANTE f
where f.nome like '_O%'

--– Proposta 22. Descrición e prezo dos produtos dos que non temos existencias.
select p.descricion, p.prezo
from PRODUTO p
where p.existencias=0

--– Proposta 23. Número identificador e nome completo dos empregados que non
--teñen xefe.
select e.numero, e.nome + ' ' + e.ape1 + ' ' + e.ape2 as nome
from EMPREGADO e
where e.num_empregado_xefe is null

--– Proposta 24. Descrición e unidades existentes, dos produtos con existencias maiores
--de 10 unidades e menores de 100. Para resolver esta consulta non se poden utilizar
--operadores de comparación (>, <, >=, <=, < >, !=).
select p.descricion, p.existencias
from PRODUTO p
where p.existencias between 10 and 100
ORDER BY p.existencias ASC







use EMPRESA
--– Proposta 1. Media de unidades vendidas de cada vendedor. O resultado terá dúas
--columnas, na primeira o número identificador do empregado (vendedor) e nunha
--segunda columna a media de unidades vendidas (campo cantidade) nos seus
--pedidos
select p.num_empregado as vendedor, avg(p.cantidade) as media_ventas 
from PEDIDO p
GROUP BY p.num_empregado

--– Proposta 2. Prezo máis barato de produto, prezo máis caro, prezo medio, suma total
--dos prezos de produto, e número de produtos distintos existentes.
select MIN(p.prezo) as prezo_minimo, MAX(p.prezo) as prezo_maximo, AVG(p.prezo)as prezo_medio, sum(p.prezo) as suma_total_dos_prezos, count(p.prezo) as numero_produtos_totales
from PRODUTO p
GROUP BY existencias

--– Proposta 3. Número de pedidos realizados polo cliente 1103.
select count(p.numero)
from PEDIDO p
where p.num_cliente=1103
GROUP BY p.num_cliente

--– Proposta 4. Número de pedidos realizados por cada cliente. No resultado aparecerá
--o identificador do cliente e na segunda columna o número de pedidos que leva
--feitos cada cliente ata o de agora.
select p.num_cliente, count(p.numero), c.nome
from PEDIDO p, Cliente c
where p.num_cliente = c.numero
GROUP BY p.num_cliente, c.nome;


--– Proposta 5. Repite a consulta anterior, pero agora no resultado só poderán aparecer
--os clientes que fixeron máis de 2 pedidos.
select p.num_cliente, count(p.numero) as 'numero de Pedidos hechos'
from PEDIDO p
GROUP BY p.num_cliente
having count(*)>2

--– Proposta 6. Repite a consulta anterior, pero agora no resultado só poderán aparecer
--os clientes que fixeron máis de 2 pedidos e que ademais teñen unha media de
--unidades mercadas (cantidade) inferior a 10.
select p.num_cliente, count(p.numero) as 'numero de Pedidos hechos'
from PEDIDO p
GROUP BY p.num_cliente
having count(*)>2 and avg(p.cantidade)<10

--– Proposta 7. Cantidade total de sucursais que hai por rexión. Aparecerá o nome da
--rexión e na mesma columna separado por un guión, a cantidade de sucursais
--situadas nesa rexión.
select s.rexion + ' - ' + cast(count(s.identificador) as varchar) as 'nomeRexion - CantidadSucursais'
from SUCURSAL s
Group BY s.rexion