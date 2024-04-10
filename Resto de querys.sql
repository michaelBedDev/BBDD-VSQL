use EMPRESA

--4. Tarefa de consultas con subconsultas
--? Consultas propostas na BD EMPRESA.

--– Proposta 1. Nome de todos os fabricantes dos que hai produtos na BD. Non se permite
--usar combinacións nesta consulta.
select f.nome
from FABRICANTE f
where codigo IN (select p.cod_fabricante
				  from PRODUTO p
				  )

--– Proposta 2. Nome de todos os fabricantes dos que non hai produtos na BD. Non se
--permite usar combinacións nesta consulta.
select f.nome
from FABRICANTE f
where codigo NOT IN (select p.cod_fabricante
				 from PRODUTO p)

--– Proposta 3. Número de pedido, cantidade e data de pedido para aqueles pedidos recibidos
--nos días en que un novo empregado foi contratado. Non se permite usar combinacións
--nesta consulta.
select p.numero, p.cantidade, p.data_pedido
from PEDIDO p
where p.data_pedido IN (select e.data_contrato
						 from EMPREGADO e)

--– Proposta 4. Cidade e obxectivo das sucursais cuxo obxectivo supera a media das cotas de
--todos os vendedores da BD. Non se permite usar combinacións nesta consulta.
select s.cidade, s.obxectivo
from SUCURSAL s
where obxectivo > (select avg (e.cota_de_vendas)
				    from EMPREGADO e)

--– Proposta 5. Número de empregado e cantidade media dos pedidos daqueles empregados
--cuxa cantidade media de pedido é superior á cantidade media global (de todos os
--pedidos). Non se permite usar combinacións nesta consulta.
select p.num_empregado, avg(p.cantidade)
from  PEDIDO p
GROUP BY p.num_empregado
HAVING avg(p.cantidade) > (select avg(p.cantidade)
					       from PEDIDO p)


--– Proposta 6. Nome dos clientes que aínda non fixeron pedidos. Non se permite usar
--combinacións nesta consulta.
select c.nome
from CLIENTE c
where c.numero NOT IN (select p.num_cliente
					    from PEDIDO p)

--– Proposta 7. Nome completo dos empregados cuxas cotas son iguais ou superiores ao
--obxectivo da sucursal da cidade de Vigo. Ten en conta que se a cota dun vendedor
--(empregado) é nula debemos considerala como un 0, e do mesmo xeito actuaremos co
--obxectivo da sucursal. Non se permite usar combinacións nesta consulta.
select e.nome
from EMPREGADO e
where isnull(cota_de_vendas,0)>=(SELECT isnull(obxectivo,0)
						   from SUCURSAL s
						   where s.cidade='Vigo')

--– Proposta 8. Nome dos produtos para os que existe polo menos un pedido que ten unha
--cantidade de polo menos 20 unidades. Hai que lembrar que a identificación dun produto
--faise pola combinación do código do fabricante e o do produto. A solución deberá facerse
--empregando o predicado EXISTS cunha subconsulta correlacionada. Non se permite usar
--combinacións.
select p.descricion
from PRODUTO p
where      EXISTS (select pe.numero
			   from PEDIDO pe
			   where pe.cantidade >= 20
			   and pe.cod_fabricante= p.cod_fabricante and 
			   p.identificador = pe.id_produto)

--– Proposta 9. Cidades das sucursais onde exista algún empregado cuxa cota de vendas
--represente máis do 80% do obxectivo da oficina onde traballa. Para resolver esta consulta
--deberase empregar unha subconsulta correlacionada precedida de ANY.
select s.cidade
from SUCURSAL s
where 0.80*s.obxectivo < ANY (select e.cota_de_vendas
								 from EMPREGADO e)



--– Proposta 10. Nome dos clientes cuxos empregados asignados traballan en sucursais da
--rexión OESTE. Non se poden usar joins, só subconsultas encadeadas.
use EMPRESA
select c.nome
from CLIENTE c
Where  c.num_empregado_asignado  IN (select e.numero
									 from EMPREGADO e
									 where e.id_sucursal_traballa IN (select s.identificador
																		from  SUCURSAL s
																		where s.rexion = 'OESTE'))

							

								 


--5. Tarefa de consultas con funcións integradas no
--xestor
use empresa;
--? Consultas propostas na BD EMPRESA.
--– Proposta 1. Desexamos coñecer o código ASCII da vogal E. Na consulta deberás devolver
--nunha columna a vogal en maiúscula, e nunha segunda o código ASCII que lle corresponde.
select 'E', ASCII('E') as ASCII

--– Proposta 2. Consulta que devolve o carácter que lle corresponde aos seguintes códigos
--ASCII: 70, 80, 90.
select char(70), char(80),char(90)

--– Proposta 3. Queremos obter unha listaxe que en cada liña teña o seguinte texto: O
--empregado con nome e apelidos X ten que acadar unha cota de vendas anual de Y. Sendo X
--o nome e os apelidos do empregado, e Y a cota de vendas. É importante fixarse no
--segundo apelido. A listaxe terá por título Empregados e cotas.

select 'O empregado con nome e apelidos ' + e.nome + ' ' + e.ape1 + rtrim(' ' + isnull(e.ape2, ' ')) + ' ten que acadar unha cota de vendas anual de '
+ cast(e.cota_de_vendas as varchar(12)) as 'Empregados e cotas' 
FROM EMPREGADO e


--– Proposta 4. Consulta que devolva as datas nas que se contrataron empregados. O formato
--das diferentes datas será dd-mm-aaaa e o nome da columna Datas de contratación.
select CONVERT(char(20),e.data_contrato,105) as 'Datas de contratación'
from EMPREGADO e

--– Proposta 5. Queremos obter un nome abreviado das sucursais. Ese nome comporase polos
--tres primeiros caracteres da cidade, os dous últimos da rexión e separado por un guión
--baixo, o número de caracteres do nome da cidade.
select LEFT(s.cidade,3)+ RIGHT(s.rexion,2) +'_' + cast(len(s.cidade) as varchar(2)) as Abrev_sucursais
from SUCURSAL s

--– Proposta 6. Queremos obter un nome abreviado dos produtos. Ese nome comporase polo
--segundo carácter do código do fabricante en minúscula, máis o terceiro, cuarto, quinto e
--sexto da descrición do produto. Nunha primeira columna o código aparecerá en
--minúsculas, e nunha segunda en maiúsculas.
select  lower(substring(p.cod_fabricante,2,1) + substring(p.descricion,3,4)),
		upper(substring(p.cod_fabricante,2,1) + substring(p.descricion,3,4))
FROM PRODUTO p

--– Proposta 7. Listaxe cos nomes dos empregados co formato ape1 ape2, nome. Se algún
--empregado non ten segundo apelido, por exemplo Susanne Smith, no resultado aparecerá
--Smith, Sussane, sen espazos antes da coma.

select RTRIM( e.ape1 + ' ' + isnull(e.ape2, ' ')) + ' ' + e.nome as 'Nome e apelidos'
from EMPREGADO e

--– Proposta 8. Queremos amosar os distintos títulos dos nosos empregados en castelán, e
--para iso deberemos substituír a palabra VENDAS por VENTAS.
select replace(e.titulo,'VENDAS', 'VENTAS') as títulos
from EMPREGADO e

--– Proposta 9. Consulta que devolva a seguinte información de tempo en distintas columnas
--co nome adecuado cada unha:
--– data e hora actuais sen axuste de zona horaria,
--– data e hora actuais con axuste de zona horaria,
--– mes actual en número,
--– mes actual en número (emprega unha función diferente á da anterior columna),
--– ano actual,
--– mes actual en nome,
--– hora actual,
--– nanosegundos actuais.

--– Proposta 10. Listaxe que devolva o nome de todos os empregados (nome, ape1, ape2), a
--data de contrato, e nunha última columna a data de contrato adiantada un ano. O formato
--das dúas datas será dd/mm/aaaa (con barras).

--– Proposta 11. Listaxe que devolva o número de cada pedido coa data de pedido. Nunha
--terceira columna deberá aparecer a mesma data de pedido pero retrasada dous meses. O
--formato das dúas datas será dd-mm-aaaa (con guións).

--– Proposta 12. Listaxe que devolva o nome e apelidos (nome, ape1, ape2) de cada
--empregado, a data de contrato e o número de anos que hai que leva traballando na
--empresa cada un deles.

--– Proposta 13. Consulta que devolva a descrición de cada produto co seu prezo nunha
--segunda columna, e ademais deberán amosarse en columnas diferentes:
--– o prezo como un enteiro aproximado por defecto,
--– o prezo como un enteiro aproximado por exceso,
--– a raíz cadrada do prezo,
--– o cadrado do prezo, e,
--– o cubo do prezo.

--– Proposta 14. Repite a consulta anterior pero agora só amosaremos a descrición, o prezo e
--a raíz cadrada, pero a raíz cadrada deberá amosarse con como moito 4 cifras na parte
--enteira e 3 na decimal.

--– Proposta 15. Consulta que devolva a seguinte información do servidor no que está a nosa
--instancia de SQL Server: idioma, número máximo de conexións permitidas, nome do
--servidor e da instancia e versión do xestor.

--– Proposta 16. Consulta que amose a descrición do produto e as súas existencias. Nunha
--terceira columna de nome estado_existencias amosarase o seguinte:
--– Se o número de existencias é superior a 20 aparecerá a palabra Suficientes.
--– Se o número de existencias é menor ou igual a 20 aparecerá Insuficientes.
--Esta consulta deberás resolvela de dous xeitos posibles, en dúas consultas diferentes,
--empregando dúas funcións lóxicas distintas.




--6. Tarefa de consultas compostas
--? Consultas propostas na BD EMPRESA.
use empresa

--– Proposta 1. Empregando unha consulta composta realizar unha listaxe do código do
--fabricante e identificador daqueles produtos con prezo superior a 60€ ou que teñan
--pedidos de cantidade inferior a 5 unidades. O resultado aparecerá ordenado por fabricante
--e para o mesmo fabricante por produto.

select p.cod_fabricante, p.identificador
from PRODUTO p
where p.prezo >= 60 
UNION
select pe.cod_fabricante, pe.id_produto
from PEDIDO pe
where pe.cantidade < 5
ORDER BY cod_fabricante, p.identificador

--– Proposta 2. Empregando unha consulta composta amosar os código dos empregados que
--non fixeron pedidos. Deberán aparecer primeiro os empregados con código maior.
select e.numero
from EMPREGADO e
EXCEPT
select p.num_empregado
from PEDIDO p
ORDER BY e.numero





--– Proposta 3. Empregando unha consulta composta amosar o código dos clientes que
--fixeron pedidos e con límite de crédito maior ou igual a 40000. Usa unha diferenza para
--resolver esta consulta.
select p.num_cliente
from PEDIDO p
EXCEPT
select c.numero
from CLIENTE c
where c.limite_de_credito < 40000


--– Proposta 4. Empregando unha consulta composta amosar os código dos clientes que
--fixeron pedidos e con límite de crédito maior ou igual a 40000. Usa unha intersección para
--resolver esta consulta. Ordena o resultado por código de cliente en orde ascendente.
select p.num_cliente
from PEDIDO p
INTERSECT
select c.numero
from CLIENTE c
where c.limite_de_credito >= 40000
ORDER BY p.num_cliente





--– Proposta 5. Empregando unha consulta composta amosar o código dos empregados que
--son directores dalgunha sucursal ou que teñen unha cota de vendas superior a 250000€.
--– Debes propoñer dúas solucións:
--– na primeira só pode aparecer unha vez cada empregado no resultado, e,
--– na segunda se un empregado é director dunha sucursal e ademais ten unha cota
--superior a 250000€, aparecerá no resultado máis dunha vez.

select s.num_empregado_director
from SUCURSAL s
UNION
select e.numero
from EMPREGADO e
where e.cota_de_vendas > 250000

select s.num_empregado_director
from SUCURSAL s
UNION ALL
select e.numero
from EMPREGADO e
where e.cota_de_vendas > 250000



--7. Tarefa de consultas complexas optimizadas
--? Consultas propostas nas BBDD EMPRESA e SOCIEDADE_CULTURAL:
use socios
--– Proposta 1. DB SOCIEDADE_CULTURAL. Nif e nome completo nunha columna (ape1 ape2,
--nome) de cada socio, só para os socios que deben algunha actividade. Nunha segunda
--columna aparecerá o importe total que debe en actividades. A columna do nome
--chamarase nome_completo e a do importe debido cantidade_debe. O resultado aparecerá
--por orde alfabética de apelidos e nome dos socios.
select s.nif, rtrim(s.ape1 + ' ' + (isnull(s.ape2, ' ')) + ' ' + s.nome) as nome_completo, sum(a.prezo) as cantidade_debe
from SOCIO s, SOCIO_REALIZA_ACTI sa, ACTIVIDADE a
where s.numero = sa.num_socio and sa.pagada = 'N' and a.identificador = sa.id_actividade
GROUP BY s.numero, s.nif, s.ape1, s.ape2, s.nome
ORDER BY s.ape1, s.ape2, s.nome

--solución
SELECT s.nif,
 rtrim(s.ape1+' '+isnull(s.ape2,''))+', '+s.nome as nome_completo,
 sum(a.prezo) as cantidade_debe
FROM SOCIO s, SOCIO_REALIZA_ACTI sr, ACTIVIDADE a
WHERE sr.pagada='N' AND
 s.numero=sr.num_socio AND
 sr.id_actividade=a.identificador
GROUP BY s.numero, s.nif, s.ape1, s.ape2, s.nome
ORDER BY s.ape1, s.ape2, s.nome;



--– Proposta 2. BD EMPRESA. Número de pedido, descrición e prezo do produto, unidades
--vendidas e importe de todos os pedidos da BD ordenados de maior a menor importe. No
--caso de coincidir os importes deberá ordenarse alfabeticamente pola descrición do
--produto.
--– Proposta 3. BD EMPRESA. Número de pedido, descrición e prezo do produto, unidades
--vendidas e importe dos pedidos da BD con importe superior a 1000€, ordenados de maior
--a menor importe. No caso de coincidir os importes deberá ordenarse alfabeticamente pola
--descrición do produto.
--– Proposta 4. BD EMPRESA. Número de pedido, nome do cliente e data de pedido dos
--pedidos recibidos nos días en que se contrataron empregados. No resultado deben
--aparecer primeiro os pedidos máis recentes.
--– Proposta 5. DB EMPRESA. Nome completo dos empregados co nome do empregado que
--teñen por xefe. Na primeira columna de nome empregado aparecerá o nome completo de
--cada empregado co formato ape1 ape2, nome, teña ou non teña xefe. Na segunda
--columna de nome xefe aparecerá o nome completo do xefe dese empregado co mesmo
--formato que o campo empregado. No caso de non ter xefe na segunda columna aparecerá
--a frase 'XEFE POR DETERMINAR'.
--Non se amosan os empregados que dirixen a sucursal onde traballa cada un deles,
--senón o xefe directo. (Ver campo EMPREGADO.num_empregado_xefe).
--– Proposta 6. DB SOCIEDADE_CULTURAL. Gasto en actividades por socio. Na primeira
--columna aparecerá o nif do socio e na segunda o gasto, pagado ou non, que leva feito en
--actividades. Os socios que non participaron en actividades non aparecerán no resultado.
--– Proposta 7. DB SOCIEDADE_CULTURAL. Nome e apelidos, (en tres columnas de nomes
--apelido1, apelido2 e nome_propio) das persoas que forman parte da nosa sociedade
--cultural independentemente da súa labor na sociedade. Nunha cuarta columna cargo se a
--persoa é empregado aparecerá a frase 'É EMPREGADO' e noutro caso 'NON É
--EMPREGADO'. O resultado aparecerá ordenado alfabeticamente por apelidos e nome.
--– Proposta 8. BD EMPRESA. Empregando unha consulta composta amosa o identificador das
--sucursais que non teñen empregados traballando nelas.
--– Proposta 9. BD EMPRESA. Nunha columna nome_abreviado amosa os tres primeiros
--caracteres en minúsculas do primeiro apelido de cada empregado.
--– Proposta 10. DB SOCIEDADE_CULTURAL. Nome e apelidos, (en tres columnas de nomes
--apelido1, apelido2 e nome_propio) dos socios que cumpren anos no mes actual.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 9



--TAREFAS DE AUTOAVALIACIÓN
--1. Tarefa de consultas simples
--? Consulta 1.1. BD EMPRESA. Consulta que devolva o código e nome dos fabricantes cuxo
--nome non ten por segunda letra O.
--? Consulta 1.2. BD EMPRESA. Número identificador, nome completo e data de nacemento dos
--empregados que traballan na sucursal con identificador 12, e naceron no ano 1985. No
--resultado aparecerán primeiro os empregados máis novos.
--? Consulta 1.3. BD EMPRESA. Número de pedido daqueles nos que se pediron 6 ou 10
--unidades. Para resolver esta consulta non se poden utilizar operadores de comparación (>, <,
-->=, <=, < >, !=).
--? Consulta 1.4. BD EMPRESA. Número e nome propio (nunha única columna separados por un
--guión, número - nome_propio) dos empregados que non teñen segundo apelido. A columna
--do resultado deberá chamarse datos_empregados.
--2. Tarefa de consultas resumo
--? Consulta 2.1. BD EMPRESA. Cantidade total de empregados que hai por sucursal. Aparecerá
--o identificador da sucursal e nunha segunda columna a cantidade de empregados que
--traballan na mesma.
--? Consulta 2.2. BD EMPRESA. Prezo medio dos produtos por fabricante. Nunha primeira
--columna aparecerá o código de tres caracteres do fabricante, e na segunda o prezo medio
--dos produtos dese fabricante. No resultado deberán aparecer os fabricante teñan produtos
--con maior prezo medio.
--? Consulta 2.3. BD EMPRESA. Repite a consulta anterior, pero agora só poden aparecer os
--fabricantes con número de produtos a venda superior a 3.
--? Consulta 2.4. BD EMPRESA. Cantidade de empregados que son directores dalgunha sucursal.
--Ten en conta que distintas sucursais poden ter o mesmo director.
--3. Tarefa de consultas con combinacións
--? Consulta 3.1. BD SOCIEDADE_CULTURAL. Nome das actividades co nome completo do
--profesor/a que as imparten, só para as actividades que custan máis de 70€. Na primeira
--columna Actividade aparecerá o nome da actividade e na segunda de nome Docente,
--aparecerá o nome completo do docente co formato apelido1 apelido2, nome. Deberanse
--propoñer dúas solucións, unha primeira coa condición de combinación na cláusula FROM, e
--unha segunda coa condición de combinación na cláusula WHERE.
--? Consulta 3.2. BD EMPRESA. Listaxe dos produtos da BD ordenados alfabeticamente por
--descrición. No resultado aparecerán dúas columnas, na primeira o nome do fabricante e na
--segunda a descrición do produto. As columnas chamaranse Fabricante e Produto. Deberanse
--propoñer dúas solucións, unha primeira coa condición de combinación na cláusula FROM, e
--unha segunda coa condición de combinación na cláusula WHERE.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 10
--? Consulta 3.3. BD SOCIEDADE_CULTURAL. Deséxase saber quen paga cada cota, e tamén se
--hai cotas que non están asignadas a ningún socio ou socios que non teñen cota asignada. A
--consulta deberá devolver dúas columnas Socio/a e Cota. En Socio aparecerán os números de
--cada socio e en Cota os nomes de cada cota. Se un socio non tivese cota asignada, na
--columna Cota aparecerá a frase -SEN DESIGNAR-. Se unha cota non está asociada a ningún
--socio, na columna Socio/a aparecerá a frase -SEN SOCIO/A-. Para que a consulta teña sentido
--débese supoñer que a columna cod_cota de SOCIO puidese admitir nulos.
--? Consulta 3.4. BD EMPRESA. Consulta que devolva cada empregado co cliente ou clientes que
--ten asignados. Se un empregado ten máis dun cliente aparecerá en tantas filas como clientes
--teña. Na primeira columna Empregado aparecerá o número e o primeiro apelido do
--empregado separados por un guión. Na segunda columna Cliente aparecerá o nome do
--mesmo. Se un empregado non ten clientes especificarase -SEN CLIENTES- e se un cliente non
--ten empregado indicarase deixando en branco o empregado. Na solución na cláusula FROM
--a primeira táboa que se debe poñer será a de EMPREGADO.
--? Consulta 3.5. BD SOCIEDADE_CULTURAL. Empregados coas actividades que imparten. No
--resultado aparecerá na primeira columna Empregado o número da seguridade social (NSS)
--do empregado, e na segunda columna Actividades o nome da actividade. Se un empregado
--non imparte actividades aparecerá a frase -SEN ACTIVIDADES- e se imparte varias aparecerá
--en varias filas, cada unha cunha das actividades. Na solución na cláusula FROM a primeira
--táboa que se debe poñer será a de ACTIVIDADE.
--? Consulta 3.6. BD SOCIEDADE_CULTURAL. Produto cartesiano entre a táboa de aulas e a de
--actividades. Nunha primeira columna aparecerá o nome da aula e na segunda o nome da
--actividade. Débense propoñer dúas solucións, segundo as sintaxes estudadas para o produto
--cartesiano.
--? Consulta 3.7. BD SOCIEDADE_CULTURAL. Consulta que devolva o NIF de cada socio
--combinado con cada un dos nomes das cotas da BD. O resultado terá unha columna co
--formato NIF socio - Nome cota. Débense propoñer dúas solucións, segundo cómo se
--dispoñan as táboas no FROM.



--4. Tarefa de consultas con subconsultas
--? Consulta 4.1. BD EMPRESA. Número e data dos pedidos realizados por empregados sen cota
--de vendas. Deberase resolver sen usar combinacións de táboas.
--? Consulta 4.2. BD SOCIEDADE_CULTURAL. Nome e prezo das actividades con prezo superior
--ao prezo medio das cotas. Deberase resolver sen usar combinacións de táboas.
--? Consulta 4.3. BD SOCIEDADE_CULTURAL. Listaxe do nif de todos os socios sempre que non
--exista ningún vivindo na provincia de Madrid. Deberase resolver sen usar combinacións de
--táboas.
--? Consulta 4.4. BD SOCIEDADE_CULTURAL. Nome e prezo das actividades con prezo superior
--ao da cota máis cara. Deberase resolver sen usar combinacións de táboas nin a función
--colectiva max.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 11



--5. Tarefa de consultas con funcións integradas no
--xestor
--? Consulta 5.1. BD EMPRESA. Consulta que devolva información dos empregados nas
--seguintes columnas:
--– número identificador e nome propio separados polo símbolo # (cancelo).
--– Tres primeiras letras do primeiro apelido.
--– Tres últimas letras do primeiro apelido.
--– Terceiro e cuarto caracteres do primeiro apelido.
--– Nome propio en minúsculas.
--– Nome propio en maiúsculas.
--– Título eliminándolle os posibles espazos en branco á esquerda.
--– Título eliminándolle os posibles espazos en branco á dereita.
--– Título eliminándolle todos os espazos.
--– Nome propio substituíndo E por O.
--? Consulta 5.2. BD EMPRESA. Consulta que devolva información dos empregados nas
--seguintes columnas:
--– Nome completo dos empregados co formato apelido1 apelido2, nome.
--– Cota de vendas.
--– Cota de vendas aproximada por exceso.
--– Cota de vendas aproximada por defecto.
--– Cota de vendas elevada ao cadrado.
--– Cota de vendas elevada ao cubo.
--– Raíz cadrada da cota de vendas.
--Todos os valores nulos do resultado deberán aparecer substituídos polo valor 0.
--? Consulta 5.3. BD EMPRESA. Consulta que devolva información dos pedidos nas seguintes
--columnas:
--– Número do pedido.
--– Data actual con axuste de zona horaria.
--– Data do pedido co formato dd-mm-aaaa.
--– Día no que se fixo o pedido.
--– Nome do mes no que se fixo o pedido.
--– Ano no que se fixo o pedido.
--– Meses que pasaron desde que se fixo o pedido.
--– Data de pedido adiantada 4 anos.
--– Data de pedido retrasada 1 mes.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 12
--? Consulta 5.4. BD SOCIEDADE_CULTURAL. Consulta que devolve unha columna
--Linguaxe_usada na que dependendo da linguaxe en uso na sesión, aparecerá unha frase ou
--outra:
--– se a linguaxe é Español deberá aparecer a frase SU IDIOMA ES ESPAÑOL.
--– se a linguaxe é us_english deberá aparecer a frase YOUR LANGUAGE IS ENGLISH.
--– se a linguaxe é outra deberá aparecer a frase VOSTEDE NON ESTÁ USANDO NIN
--ESPAÑOL NIN INGLÉS.



--6. Tarefa de consultas compostas
--? Consulta 6.1. BD SOCIEDADE_CULTURAL. Empregando unha consulta composta pídese a
--listaxe dos identificadores das actividades con prezo superior a 15€ ou que se impartan en
--aulas con superficie inferior a 100 metros cadrados. O resultado aparecerá ordenado de
--maior a menor identificador.
--? Consulta 6.2. BD SOCIEDADE_CULTURAL. Empregando unha consulta composta amosar o nif
--dos socios que asisten a actividades e que pagaron a cota anual.
--? Consulta 6.3. BD EMPRESA. Empregando unha consulta composta amosar o número
--identificador dos clientes que aínda non fixeron pedidos. Ordena o resultado polo número de
--cliente en orde ascendente.



--7. Tarefa de consultas complexas optimizadas
--? Consulta 7.1. Consulta que devolve na primeira columna a descrición dos produtos, e nunha
--segunda columna o gasto total en pedidos dese produto. No resultado só poderán aparecer
--aqueles produtos cuxo gasto medio é menor de 1000€.
--A primeira columna chamarase Produto e a segunda Gasto total.
--Se de algún produto non se realizaron pedidos na columna do Gasto total deberá aparecer o
--número cero.
--Deberán aparecer primeiro no resultado os produtos con maior gasto total.
--? Consulta 7.2. Consulta que devolva a lista dos pedidos que hai máis de 12 meses e menos de
--25 meses que se realizaron.
--Para facer a comprobación dos anos que hai que se realizou o pedido non está permitido
--usar nin o predicado IN, nin OR nin tampouco os operadores de comparación >=, >, <=, !=, =
--<>.
--No resultado deberá aparecer o número do pedido, nunha segunda columna FechaPed
--aparecerá a data do pedido con formato dd-mm-aaaa (separación empregando guións), e
--nunha terceira columna de nome Unidades aparecerá o seguinte en función do número de
--unidades solicitadas no pedido:
--– Se a cantidade de unidades do pedido é inferior a 15 aparecerá o texto POUCAS.
--– Se a cantidade de unidades do pedido é superior ou igual a 15 e menor que 20
--aparecerá o texto NORMAL.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 13
--– Se a cantidade de unidades do pedido é superior ou igual a 20 aparecerá o texto
--MOITAS.
--Deben aparecer os pedidos máis recentes primeiro.
--? Consulta 7.3. Consulta que devolva a cidade en maiúsculas de cada unha das sucursais da
--BD, a súa rexión en minúsculas e noutra terceira columna de nome pedido_minimo as
--unidades do pedido con menor número de unidades da sucursal. Ten en conta que un pedido
--pertence a unha sucursal se foi realizado por un empregado que traballa nesa sucursal.
--Se existise algunha sucursal que non teña vendido nada, non aparecerá no resultado.
--? Consulta 7.4. Nome completo nunha columna (co formato ape1 ape2, nome) e noutra a data
--de contratación (co formato dd/mm/aaaa), dos empregados que foron contratados un día
--12, 19 ou 20 de calquera mes e de calquera ano. Importante: Non se pode usar o operador
--OR nin a función day para resolver a consulta.
--? Consulta 7.5. Executa no servidor a seguinte instrución e comproba que foi agregado un
--produto novo coa descrición PROBA_AVALIACION.
--INSERT INTO PRODUTO
--(cod_fabricante, identificador, descricion, prezo, existencias)
--VALUES ('ASU', '41777', 'PROBA_AVALIACION', 300, 40);
--Unha vez comprobado que a nova fila está na táboa, realiza a consulta que devolve o número
--total de produtos cuxa descrición contén algún dos seguintes tres caracteres: / (barra
--diagonal ou slash), _ (guión baixo), - (guión medio). Para facelo non está permitido o uso dos
--corchetes ([ ]).
--/ (barra diagonal ou slash) _ (guión baixo) - (guión medio)
--Unha vez rematada a consulta é necesario eliminar o produto engadido coa seguinte
--instrución:
--DELETE FROM PRODUTO WHERE descricion='PROBA_AVALIACION';
--? Consulta 7.6. Número, data e cantidade, dos pedidos con maior número de unidades. No
--resultado aparecerán primeiro os pedidos máis antigos.
--? Consulta 7.7. Consulta que devolva o 25% dos empregados cuxo primeiro apelido ten por
--segunda letra un A. A consulta amosará en diferentes columnas o número, nome propio, o
--primeiro apelido dos empregados, o número de caracteres do primeiro apelido e o nome do
--mes en que foi contratado. Para resolver a busca da letra A na segunda posición do primeiro
--apelido, deberase empregar unha función integrada no xestor.
--? Consulta 7.8. Descrición dos produtos dos que non se fixeron pedidos. Para obter o
--resultado non se pode empregar ningunha combinación externa, nin a palabra reservada
--DISTINCT, nin subconsultas.
--? Consulta 7.9. Nunha consulta haberá que devolver a hora actual (só a hora, sen minutos), as
--data e hora actuais con axuste de zona horaria (seguindo o estándar Europeo
--predeterminado+milisegundos), o nome da linguaxe do servidor e o número máximo de
--conexións permitidas no servidor.
--UD5. RECUPERAR INFORMACIÓN DA BASE DE DATOS (DML) TAREFAS
--Docente: Mónica García Constenla
--IES San Clemente
--páxina 14
--? Consulta 7.10. Nome de cada cliente e ao lado do mesmo as unidades vendidas de media
--(columna cantidade) nos seus pedidos, só para aqueles clientes cuxo representante de
--vendas (empregado que ten asociado) ten por título RP VENDAS. Se non mercaron nada
--deberá aparecer como media de unidades 0.
--A columna das unidades medias deberá ter 3 díxitos como máximo na parte enteira e 2
--decimais.
--Deberán aparecer primeiro no resultado os clientes con maior número de unidades medias.
--? Consulta 7.11. Produto cartesiano de FABRICANTE e PRODUTO. No resultado aparecerán
--dúas columnas, o nome do fabricante e a descrición do produto. Esta consulta deberá
--facerse sen empregar no FROM combinacións internas.
--? Consulta 7.12. Produto cartesiano de FABRICANTE e PRODUTO. No resultado aparecerán
--dúas columnas, o nome do fabricante e a descrición do produto. Esta consulta deberá
--facerse empregando no FROM só combinacións internas.
--? Consulta 7.13. Nome dos fabricantes dos que non hai produtos na BD.
--? Consulta 7.14. Número identificador e data dos pedidos que teñan 9,7,10 ou 8 unidades e
--que foron comprados polo cliente 1108 ou vendidos polo empregado 101.
--? Consulta 7.15. Nomes de tódolos clientes e de tódolos fabricantes da BD nunha única
--columna. A columna que se chamará empresas, deberá aparecer ordenada alfabeticamente.

use SOCIOS

select a.nome as 'Actividade', e.ape1 + ',' + e.ape2 + ',' + e.nome as 'Docente'
from ACTIVIDADE a left join EMPREGADO e
	on a.num_profesorado_imparte = e.numero
where a.prezo > 70;



use EMPRESA

select f.nome as 'Fabricante', p.descricion as 'Descricion'
FROM FABRICANTE f inner join PRODUTO p
	 on f.codigo= p.cod_fabricante
ORDER BY p.descricion
