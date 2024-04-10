use EMPRESA

--4. Tarefa de consultas con subconsultas
--? Consultas propostas na BD EMPRESA.

--� Proposta 1. Nome de todos os fabricantes dos que hai produtos na BD. Non se permite
--usar combinaci�ns nesta consulta.
select f.nome
from FABRICANTE f
where codigo IN (select p.cod_fabricante
				  from PRODUTO p
				  )

--� Proposta 2. Nome de todos os fabricantes dos que non hai produtos na BD. Non se
--permite usar combinaci�ns nesta consulta.
select f.nome
from FABRICANTE f
where codigo NOT IN (select p.cod_fabricante
				 from PRODUTO p)

--� Proposta 3. N�mero de pedido, cantidade e data de pedido para aqueles pedidos recibidos
--nos d�as en que un novo empregado foi contratado. Non se permite usar combinaci�ns
--nesta consulta.
select p.numero, p.cantidade, p.data_pedido
from PEDIDO p
where p.data_pedido IN (select e.data_contrato
						 from EMPREGADO e)

--� Proposta 4. Cidade e obxectivo das sucursais cuxo obxectivo supera a media das cotas de
--todos os vendedores da BD. Non se permite usar combinaci�ns nesta consulta.
select s.cidade, s.obxectivo
from SUCURSAL s
where obxectivo > (select avg (e.cota_de_vendas)
				    from EMPREGADO e)

--� Proposta 5. N�mero de empregado e cantidade media dos pedidos daqueles empregados
--cuxa cantidade media de pedido � superior � cantidade media global (de todos os
--pedidos). Non se permite usar combinaci�ns nesta consulta.
select p.num_empregado, avg(p.cantidade)
from  PEDIDO p
GROUP BY p.num_empregado
HAVING avg(p.cantidade) > (select avg(p.cantidade)
					       from PEDIDO p)


--� Proposta 6. Nome dos clientes que a�nda non fixeron pedidos. Non se permite usar
--combinaci�ns nesta consulta.
select c.nome
from CLIENTE c
where c.numero NOT IN (select p.num_cliente
					    from PEDIDO p)

--� Proposta 7. Nome completo dos empregados cuxas cotas son iguais ou superiores ao
--obxectivo da sucursal da cidade de Vigo. Ten en conta que se a cota dun vendedor
--(empregado) � nula debemos considerala como un 0, e do mesmo xeito actuaremos co
--obxectivo da sucursal. Non se permite usar combinaci�ns nesta consulta.
select e.nome
from EMPREGADO e
where isnull(cota_de_vendas,0)>=(SELECT isnull(obxectivo,0)
						   from SUCURSAL s
						   where s.cidade='Vigo')

--� Proposta 8. Nome dos produtos para os que existe polo menos un pedido que ten unha
--cantidade de polo menos 20 unidades. Hai que lembrar que a identificaci�n dun produto
--faise pola combinaci�n do c�digo do fabricante e o do produto. A soluci�n deber� facerse
--empregando o predicado EXISTS cunha subconsulta correlacionada. Non se permite usar
--combinaci�ns.
select p.descricion
from PRODUTO p
where      EXISTS (select pe.numero
			   from PEDIDO pe
			   where pe.cantidade >= 20
			   and pe.cod_fabricante= p.cod_fabricante and 
			   p.identificador = pe.id_produto)

--� Proposta 9. Cidades das sucursais onde exista alg�n empregado cuxa cota de vendas
--represente m�is do 80% do obxectivo da oficina onde traballa. Para resolver esta consulta
--deberase empregar unha subconsulta correlacionada precedida de ANY.
select s.cidade
from SUCURSAL s
where 0.80*s.obxectivo < ANY (select e.cota_de_vendas
								 from EMPREGADO e)



--� Proposta 10. Nome dos clientes cuxos empregados asignados traballan en sucursais da
--rexi�n OESTE. Non se poden usar joins, s� subconsultas encadeadas.
use EMPRESA
select c.nome
from CLIENTE c
Where  c.num_empregado_asignado  IN (select e.numero
									 from EMPREGADO e
									 where e.id_sucursal_traballa IN (select s.identificador
																		from  SUCURSAL s
																		where s.rexion = 'OESTE'))

							

								 


--5. Tarefa de consultas con funci�ns integradas no
--xestor
use empresa;
--? Consultas propostas na BD EMPRESA.
--� Proposta 1. Desexamos co�ecer o c�digo ASCII da vogal E. Na consulta deber�s devolver
--nunha columna a vogal en mai�scula, e nunha segunda o c�digo ASCII que lle corresponde.
select 'E', ASCII('E') as ASCII

--� Proposta 2. Consulta que devolve o car�cter que lle corresponde aos seguintes c�digos
--ASCII: 70, 80, 90.
select char(70), char(80),char(90)

--� Proposta 3. Queremos obter unha listaxe que en cada li�a te�a o seguinte texto: O
--empregado con nome e apelidos X ten que acadar unha cota de vendas anual de Y. Sendo X
--o nome e os apelidos do empregado, e Y a cota de vendas. � importante fixarse no
--segundo apelido. A listaxe ter� por t�tulo Empregados e cotas.

select 'O empregado con nome e apelidos ' + e.nome + ' ' + e.ape1 + rtrim(' ' + isnull(e.ape2, ' ')) + ' ten que acadar unha cota de vendas anual de '
+ cast(e.cota_de_vendas as varchar(12)) as 'Empregados e cotas' 
FROM EMPREGADO e


--� Proposta 4. Consulta que devolva as datas nas que se contrataron empregados. O formato
--das diferentes datas ser� dd-mm-aaaa e o nome da columna Datas de contrataci�n.
select CONVERT(char(20),e.data_contrato,105) as 'Datas de contrataci�n'
from EMPREGADO e

--� Proposta 5. Queremos obter un nome abreviado das sucursais. Ese nome comporase polos
--tres primeiros caracteres da cidade, os dous �ltimos da rexi�n e separado por un gui�n
--baixo, o n�mero de caracteres do nome da cidade.
select LEFT(s.cidade,3)+ RIGHT(s.rexion,2) +'_' + cast(len(s.cidade) as varchar(2)) as Abrev_sucursais
from SUCURSAL s

--� Proposta 6. Queremos obter un nome abreviado dos produtos. Ese nome comporase polo
--segundo car�cter do c�digo do fabricante en min�scula, m�is o terceiro, cuarto, quinto e
--sexto da descrici�n do produto. Nunha primeira columna o c�digo aparecer� en
--min�sculas, e nunha segunda en mai�sculas.
select  lower(substring(p.cod_fabricante,2,1) + substring(p.descricion,3,4)),
		upper(substring(p.cod_fabricante,2,1) + substring(p.descricion,3,4))
FROM PRODUTO p

--� Proposta 7. Listaxe cos nomes dos empregados co formato ape1 ape2, nome. Se alg�n
--empregado non ten segundo apelido, por exemplo Susanne Smith, no resultado aparecer�
--Smith, Sussane, sen espazos antes da coma.

select RTRIM( e.ape1 + ' ' + isnull(e.ape2, ' ')) + ' ' + e.nome as 'Nome e apelidos'
from EMPREGADO e

--� Proposta 8. Queremos amosar os distintos t�tulos dos nosos empregados en castel�n, e
--para iso deberemos substitu�r a palabra VENDAS por VENTAS.
select replace(e.titulo,'VENDAS', 'VENTAS') as t�tulos
from EMPREGADO e

--� Proposta 9. Consulta que devolva a seguinte informaci�n de tempo en distintas columnas
--co nome adecuado cada unha:
--� data e hora actuais sen axuste de zona horaria,
--� data e hora actuais con axuste de zona horaria,
--� mes actual en n�mero,
--� mes actual en n�mero (emprega unha funci�n diferente � da anterior columna),
--� ano actual,
--� mes actual en nome,
--� hora actual,
--� nanosegundos actuais.

--� Proposta 10. Listaxe que devolva o nome de todos os empregados (nome, ape1, ape2), a
--data de contrato, e nunha �ltima columna a data de contrato adiantada un ano. O formato
--das d�as datas ser� dd/mm/aaaa (con barras).

--� Proposta 11. Listaxe que devolva o n�mero de cada pedido coa data de pedido. Nunha
--terceira columna deber� aparecer a mesma data de pedido pero retrasada dous meses. O
--formato das d�as datas ser� dd-mm-aaaa (con gui�ns).

--� Proposta 12. Listaxe que devolva o nome e apelidos (nome, ape1, ape2) de cada
--empregado, a data de contrato e o n�mero de anos que hai que leva traballando na
--empresa cada un deles.

--� Proposta 13. Consulta que devolva a descrici�n de cada produto co seu prezo nunha
--segunda columna, e ademais deber�n amosarse en columnas diferentes:
--� o prezo como un enteiro aproximado por defecto,
--� o prezo como un enteiro aproximado por exceso,
--� a ra�z cadrada do prezo,
--� o cadrado do prezo, e,
--� o cubo do prezo.

--� Proposta 14. Repite a consulta anterior pero agora s� amosaremos a descrici�n, o prezo e
--a ra�z cadrada, pero a ra�z cadrada deber� amosarse con como moito 4 cifras na parte
--enteira e 3 na decimal.

--� Proposta 15. Consulta que devolva a seguinte informaci�n do servidor no que est� a nosa
--instancia de SQL Server: idioma, n�mero m�ximo de conexi�ns permitidas, nome do
--servidor e da instancia e versi�n do xestor.

--� Proposta 16. Consulta que amose a descrici�n do produto e as s�as existencias. Nunha
--terceira columna de nome estado_existencias amosarase o seguinte:
--� Se o n�mero de existencias � superior a 20 aparecer� a palabra Suficientes.
--� Se o n�mero de existencias � menor ou igual a 20 aparecer� Insuficientes.
--Esta consulta deber�s resolvela de dous xeitos posibles, en d�as consultas diferentes,
--empregando d�as funci�ns l�xicas distintas.




--6. Tarefa de consultas compostas
--? Consultas propostas na BD EMPRESA.
use empresa

--� Proposta 1. Empregando unha consulta composta realizar unha listaxe do c�digo do
--fabricante e identificador daqueles produtos con prezo superior a 60� ou que te�an
--pedidos de cantidade inferior a 5 unidades. O resultado aparecer� ordenado por fabricante
--e para o mesmo fabricante por produto.

select p.cod_fabricante, p.identificador
from PRODUTO p
where p.prezo >= 60 
UNION
select pe.cod_fabricante, pe.id_produto
from PEDIDO pe
where pe.cantidade < 5
ORDER BY cod_fabricante, p.identificador

--� Proposta 2. Empregando unha consulta composta amosar os c�digo dos empregados que
--non fixeron pedidos. Deber�n aparecer primeiro os empregados con c�digo maior.
select e.numero
from EMPREGADO e
EXCEPT
select p.num_empregado
from PEDIDO p
ORDER BY e.numero





--� Proposta 3. Empregando unha consulta composta amosar o c�digo dos clientes que
--fixeron pedidos e con l�mite de cr�dito maior ou igual a 40000. Usa unha diferenza para
--resolver esta consulta.
select p.num_cliente
from PEDIDO p
EXCEPT
select c.numero
from CLIENTE c
where c.limite_de_credito < 40000


--� Proposta 4. Empregando unha consulta composta amosar os c�digo dos clientes que
--fixeron pedidos e con l�mite de cr�dito maior ou igual a 40000. Usa unha intersecci�n para
--resolver esta consulta. Ordena o resultado por c�digo de cliente en orde ascendente.
select p.num_cliente
from PEDIDO p
INTERSECT
select c.numero
from CLIENTE c
where c.limite_de_credito >= 40000
ORDER BY p.num_cliente





--� Proposta 5. Empregando unha consulta composta amosar o c�digo dos empregados que
--son directores dalgunha sucursal ou que te�en unha cota de vendas superior a 250000�.
--� Debes propo�er d�as soluci�ns:
--� na primeira s� pode aparecer unha vez cada empregado no resultado, e,
--� na segunda se un empregado � director dunha sucursal e ademais ten unha cota
--superior a 250000�, aparecer� no resultado m�is dunha vez.

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
--� Proposta 1. DB SOCIEDADE_CULTURAL. Nif e nome completo nunha columna (ape1 ape2,
--nome) de cada socio, s� para os socios que deben algunha actividade. Nunha segunda
--columna aparecer� o importe total que debe en actividades. A columna do nome
--chamarase nome_completo e a do importe debido cantidade_debe. O resultado aparecer�
--por orde alfab�tica de apelidos e nome dos socios.
select s.nif, rtrim(s.ape1 + ' ' + (isnull(s.ape2, ' ')) + ' ' + s.nome) as nome_completo, sum(a.prezo) as cantidade_debe
from SOCIO s, SOCIO_REALIZA_ACTI sa, ACTIVIDADE a
where s.numero = sa.num_socio and sa.pagada = 'N' and a.identificador = sa.id_actividade
GROUP BY s.numero, s.nif, s.ape1, s.ape2, s.nome
ORDER BY s.ape1, s.ape2, s.nome

--soluci�n
SELECT s.nif,
 rtrim(s.ape1+' '+isnull(s.ape2,''))+', '+s.nome as nome_completo,
 sum(a.prezo) as cantidade_debe
FROM SOCIO s, SOCIO_REALIZA_ACTI sr, ACTIVIDADE a
WHERE sr.pagada='N' AND
 s.numero=sr.num_socio AND
 sr.id_actividade=a.identificador
GROUP BY s.numero, s.nif, s.ape1, s.ape2, s.nome
ORDER BY s.ape1, s.ape2, s.nome;



--� Proposta 2. BD EMPRESA. N�mero de pedido, descrici�n e prezo do produto, unidades
--vendidas e importe de todos os pedidos da BD ordenados de maior a menor importe. No
--caso de coincidir os importes deber� ordenarse alfabeticamente pola descrici�n do
--produto.
--� Proposta 3. BD EMPRESA. N�mero de pedido, descrici�n e prezo do produto, unidades
--vendidas e importe dos pedidos da BD con importe superior a 1000�, ordenados de maior
--a menor importe. No caso de coincidir os importes deber� ordenarse alfabeticamente pola
--descrici�n do produto.
--� Proposta 4. BD EMPRESA. N�mero de pedido, nome do cliente e data de pedido dos
--pedidos recibidos nos d�as en que se contrataron empregados. No resultado deben
--aparecer primeiro os pedidos m�is recentes.
--� Proposta 5. DB EMPRESA. Nome completo dos empregados co nome do empregado que
--te�en por xefe. Na primeira columna de nome empregado aparecer� o nome completo de
--cada empregado co formato ape1 ape2, nome, te�a ou non te�a xefe. Na segunda
--columna de nome xefe aparecer� o nome completo do xefe dese empregado co mesmo
--formato que o campo empregado. No caso de non ter xefe na segunda columna aparecer�
--a frase 'XEFE POR DETERMINAR'.
--Non se amosan os empregados que dirixen a sucursal onde traballa cada un deles,
--sen�n o xefe directo. (Ver campo EMPREGADO.num_empregado_xefe).
--� Proposta 6. DB SOCIEDADE_CULTURAL. Gasto en actividades por socio. Na primeira
--columna aparecer� o nif do socio e na segunda o gasto, pagado ou non, que leva feito en
--actividades. Os socios que non participaron en actividades non aparecer�n no resultado.
--� Proposta 7. DB SOCIEDADE_CULTURAL. Nome e apelidos, (en tres columnas de nomes
--apelido1, apelido2 e nome_propio) das persoas que forman parte da nosa sociedade
--cultural independentemente da s�a labor na sociedade. Nunha cuarta columna cargo se a
--persoa � empregado aparecer� a frase '� EMPREGADO' e noutro caso 'NON �
--EMPREGADO'. O resultado aparecer� ordenado alfabeticamente por apelidos e nome.
--� Proposta 8. BD EMPRESA. Empregando unha consulta composta amosa o identificador das
--sucursais que non te�en empregados traballando nelas.
--� Proposta 9. BD EMPRESA. Nunha columna nome_abreviado amosa os tres primeiros
--caracteres en min�sculas do primeiro apelido de cada empregado.
--� Proposta 10. DB SOCIEDADE_CULTURAL. Nome e apelidos, (en tres columnas de nomes
--apelido1, apelido2 e nome_propio) dos socios que cumpren anos no mes actual.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 9



--TAREFAS DE AUTOAVALIACI�N
--1. Tarefa de consultas simples
--? Consulta 1.1. BD EMPRESA. Consulta que devolva o c�digo e nome dos fabricantes cuxo
--nome non ten por segunda letra O.
--? Consulta 1.2. BD EMPRESA. N�mero identificador, nome completo e data de nacemento dos
--empregados que traballan na sucursal con identificador 12, e naceron no ano 1985. No
--resultado aparecer�n primeiro os empregados m�is novos.
--? Consulta 1.3. BD EMPRESA. N�mero de pedido daqueles nos que se pediron 6 ou 10
--unidades. Para resolver esta consulta non se poden utilizar operadores de comparaci�n (>, <,
-->=, <=, < >, !=).
--? Consulta 1.4. BD EMPRESA. N�mero e nome propio (nunha �nica columna separados por un
--gui�n, n�mero - nome_propio) dos empregados que non te�en segundo apelido. A columna
--do resultado deber� chamarse datos_empregados.
--2. Tarefa de consultas resumo
--? Consulta 2.1. BD EMPRESA. Cantidade total de empregados que hai por sucursal. Aparecer�
--o identificador da sucursal e nunha segunda columna a cantidade de empregados que
--traballan na mesma.
--? Consulta 2.2. BD EMPRESA. Prezo medio dos produtos por fabricante. Nunha primeira
--columna aparecer� o c�digo de tres caracteres do fabricante, e na segunda o prezo medio
--dos produtos dese fabricante. No resultado deber�n aparecer os fabricante te�an produtos
--con maior prezo medio.
--? Consulta 2.3. BD EMPRESA. Repite a consulta anterior, pero agora s� poden aparecer os
--fabricantes con n�mero de produtos a venda superior a 3.
--? Consulta 2.4. BD EMPRESA. Cantidade de empregados que son directores dalgunha sucursal.
--Ten en conta que distintas sucursais poden ter o mesmo director.
--3. Tarefa de consultas con combinaci�ns
--? Consulta 3.1. BD SOCIEDADE_CULTURAL. Nome das actividades co nome completo do
--profesor/a que as imparten, s� para as actividades que custan m�is de 70�. Na primeira
--columna Actividade aparecer� o nome da actividade e na segunda de nome Docente,
--aparecer� o nome completo do docente co formato apelido1 apelido2, nome. Deberanse
--propo�er d�as soluci�ns, unha primeira coa condici�n de combinaci�n na cl�usula FROM, e
--unha segunda coa condici�n de combinaci�n na cl�usula WHERE.
--? Consulta 3.2. BD EMPRESA. Listaxe dos produtos da BD ordenados alfabeticamente por
--descrici�n. No resultado aparecer�n d�as columnas, na primeira o nome do fabricante e na
--segunda a descrici�n do produto. As columnas chamaranse Fabricante e Produto. Deberanse
--propo�er d�as soluci�ns, unha primeira coa condici�n de combinaci�n na cl�usula FROM, e
--unha segunda coa condici�n de combinaci�n na cl�usula WHERE.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 10
--? Consulta 3.3. BD SOCIEDADE_CULTURAL. Des�xase saber quen paga cada cota, e tam�n se
--hai cotas que non est�n asignadas a ning�n socio ou socios que non te�en cota asignada. A
--consulta deber� devolver d�as columnas Socio/a e Cota. En Socio aparecer�n os n�meros de
--cada socio e en Cota os nomes de cada cota. Se un socio non tivese cota asignada, na
--columna Cota aparecer� a frase -SEN DESIGNAR-. Se unha cota non est� asociada a ning�n
--socio, na columna Socio/a aparecer� a frase -SEN SOCIO/A-. Para que a consulta te�a sentido
--d�bese supo�er que a columna cod_cota de SOCIO puidese admitir nulos.
--? Consulta 3.4. BD EMPRESA. Consulta que devolva cada empregado co cliente ou clientes que
--ten asignados. Se un empregado ten m�is dun cliente aparecer� en tantas filas como clientes
--te�a. Na primeira columna Empregado aparecer� o n�mero e o primeiro apelido do
--empregado separados por un gui�n. Na segunda columna Cliente aparecer� o nome do
--mesmo. Se un empregado non ten clientes especificarase -SEN CLIENTES- e se un cliente non
--ten empregado indicarase deixando en branco o empregado. Na soluci�n na cl�usula FROM
--a primeira t�boa que se debe po�er ser� a de EMPREGADO.
--? Consulta 3.5. BD SOCIEDADE_CULTURAL. Empregados coas actividades que imparten. No
--resultado aparecer� na primeira columna Empregado o n�mero da seguridade social (NSS)
--do empregado, e na segunda columna Actividades o nome da actividade. Se un empregado
--non imparte actividades aparecer� a frase -SEN ACTIVIDADES- e se imparte varias aparecer�
--en varias filas, cada unha cunha das actividades. Na soluci�n na cl�usula FROM a primeira
--t�boa que se debe po�er ser� a de ACTIVIDADE.
--? Consulta 3.6. BD SOCIEDADE_CULTURAL. Produto cartesiano entre a t�boa de aulas e a de
--actividades. Nunha primeira columna aparecer� o nome da aula e na segunda o nome da
--actividade. D�bense propo�er d�as soluci�ns, segundo as sintaxes estudadas para o produto
--cartesiano.
--? Consulta 3.7. BD SOCIEDADE_CULTURAL. Consulta que devolva o NIF de cada socio
--combinado con cada un dos nomes das cotas da BD. O resultado ter� unha columna co
--formato NIF socio - Nome cota. D�bense propo�er d�as soluci�ns, segundo c�mo se
--dispo�an as t�boas no FROM.



--4. Tarefa de consultas con subconsultas
--? Consulta 4.1. BD EMPRESA. N�mero e data dos pedidos realizados por empregados sen cota
--de vendas. Deberase resolver sen usar combinaci�ns de t�boas.
--? Consulta 4.2. BD SOCIEDADE_CULTURAL. Nome e prezo das actividades con prezo superior
--ao prezo medio das cotas. Deberase resolver sen usar combinaci�ns de t�boas.
--? Consulta 4.3. BD SOCIEDADE_CULTURAL. Listaxe do nif de todos os socios sempre que non
--exista ning�n vivindo na provincia de Madrid. Deberase resolver sen usar combinaci�ns de
--t�boas.
--? Consulta 4.4. BD SOCIEDADE_CULTURAL. Nome e prezo das actividades con prezo superior
--ao da cota m�is cara. Deberase resolver sen usar combinaci�ns de t�boas nin a funci�n
--colectiva max.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 11



--5. Tarefa de consultas con funci�ns integradas no
--xestor
--? Consulta 5.1. BD EMPRESA. Consulta que devolva informaci�n dos empregados nas
--seguintes columnas:
--� n�mero identificador e nome propio separados polo s�mbolo # (cancelo).
--� Tres primeiras letras do primeiro apelido.
--� Tres �ltimas letras do primeiro apelido.
--� Terceiro e cuarto caracteres do primeiro apelido.
--� Nome propio en min�sculas.
--� Nome propio en mai�sculas.
--� T�tulo elimin�ndolle os posibles espazos en branco � esquerda.
--� T�tulo elimin�ndolle os posibles espazos en branco � dereita.
--� T�tulo elimin�ndolle todos os espazos.
--� Nome propio substitu�ndo E por O.
--? Consulta 5.2. BD EMPRESA. Consulta que devolva informaci�n dos empregados nas
--seguintes columnas:
--� Nome completo dos empregados co formato apelido1 apelido2, nome.
--� Cota de vendas.
--� Cota de vendas aproximada por exceso.
--� Cota de vendas aproximada por defecto.
--� Cota de vendas elevada ao cadrado.
--� Cota de vendas elevada ao cubo.
--� Ra�z cadrada da cota de vendas.
--Todos os valores nulos do resultado deber�n aparecer substitu�dos polo valor 0.
--? Consulta 5.3. BD EMPRESA. Consulta que devolva informaci�n dos pedidos nas seguintes
--columnas:
--� N�mero do pedido.
--� Data actual con axuste de zona horaria.
--� Data do pedido co formato dd-mm-aaaa.
--� D�a no que se fixo o pedido.
--� Nome do mes no que se fixo o pedido.
--� Ano no que se fixo o pedido.
--� Meses que pasaron desde que se fixo o pedido.
--� Data de pedido adiantada 4 anos.
--� Data de pedido retrasada 1 mes.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 12
--? Consulta 5.4. BD SOCIEDADE_CULTURAL. Consulta que devolve unha columna
--Linguaxe_usada na que dependendo da linguaxe en uso na sesi�n, aparecer� unha frase ou
--outra:
--� se a linguaxe � Espa�ol deber� aparecer a frase SU IDIOMA ES ESPA�OL.
--� se a linguaxe � us_english deber� aparecer a frase YOUR LANGUAGE IS ENGLISH.
--� se a linguaxe � outra deber� aparecer a frase VOSTEDE NON EST� USANDO NIN
--ESPA�OL NIN INGL�S.



--6. Tarefa de consultas compostas
--? Consulta 6.1. BD SOCIEDADE_CULTURAL. Empregando unha consulta composta p�dese a
--listaxe dos identificadores das actividades con prezo superior a 15� ou que se impartan en
--aulas con superficie inferior a 100 metros cadrados. O resultado aparecer� ordenado de
--maior a menor identificador.
--? Consulta 6.2. BD SOCIEDADE_CULTURAL. Empregando unha consulta composta amosar o nif
--dos socios que asisten a actividades e que pagaron a cota anual.
--? Consulta 6.3. BD EMPRESA. Empregando unha consulta composta amosar o n�mero
--identificador dos clientes que a�nda non fixeron pedidos. Ordena o resultado polo n�mero de
--cliente en orde ascendente.



--7. Tarefa de consultas complexas optimizadas
--? Consulta 7.1. Consulta que devolve na primeira columna a descrici�n dos produtos, e nunha
--segunda columna o gasto total en pedidos dese produto. No resultado s� poder�n aparecer
--aqueles produtos cuxo gasto medio � menor de 1000�.
--A primeira columna chamarase Produto e a segunda Gasto total.
--Se de alg�n produto non se realizaron pedidos na columna do Gasto total deber� aparecer o
--n�mero cero.
--Deber�n aparecer primeiro no resultado os produtos con maior gasto total.
--? Consulta 7.2. Consulta que devolva a lista dos pedidos que hai m�is de 12 meses e menos de
--25 meses que se realizaron.
--Para facer a comprobaci�n dos anos que hai que se realizou o pedido non est� permitido
--usar nin o predicado IN, nin OR nin tampouco os operadores de comparaci�n >=, >, <=, !=, =
--<>.
--No resultado deber� aparecer o n�mero do pedido, nunha segunda columna FechaPed
--aparecer� a data do pedido con formato dd-mm-aaaa (separaci�n empregando gui�ns), e
--nunha terceira columna de nome Unidades aparecer� o seguinte en funci�n do n�mero de
--unidades solicitadas no pedido:
--� Se a cantidade de unidades do pedido � inferior a 15 aparecer� o texto POUCAS.
--� Se a cantidade de unidades do pedido � superior ou igual a 15 e menor que 20
--aparecer� o texto NORMAL.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 13
--� Se a cantidade de unidades do pedido � superior ou igual a 20 aparecer� o texto
--MOITAS.
--Deben aparecer os pedidos m�is recentes primeiro.
--? Consulta 7.3. Consulta que devolva a cidade en mai�sculas de cada unha das sucursais da
--BD, a s�a rexi�n en min�sculas e noutra terceira columna de nome pedido_minimo as
--unidades do pedido con menor n�mero de unidades da sucursal. Ten en conta que un pedido
--pertence a unha sucursal se foi realizado por un empregado que traballa nesa sucursal.
--Se existise algunha sucursal que non te�a vendido nada, non aparecer� no resultado.
--? Consulta 7.4. Nome completo nunha columna (co formato ape1 ape2, nome) e noutra a data
--de contrataci�n (co formato dd/mm/aaaa), dos empregados que foron contratados un d�a
--12, 19 ou 20 de calquera mes e de calquera ano. Importante: Non se pode usar o operador
--OR nin a funci�n day para resolver a consulta.
--? Consulta 7.5. Executa no servidor a seguinte instruci�n e comproba que foi agregado un
--produto novo coa descrici�n PROBA_AVALIACION.
--INSERT INTO PRODUTO
--(cod_fabricante, identificador, descricion, prezo, existencias)
--VALUES ('ASU', '41777', 'PROBA_AVALIACION', 300, 40);
--Unha vez comprobado que a nova fila est� na t�boa, realiza a consulta que devolve o n�mero
--total de produtos cuxa descrici�n cont�n alg�n dos seguintes tres caracteres: / (barra
--diagonal ou slash), _ (gui�n baixo), - (gui�n medio). Para facelo non est� permitido o uso dos
--corchetes ([ ]).
--/ (barra diagonal ou slash) _ (gui�n baixo) - (gui�n medio)
--Unha vez rematada a consulta � necesario eliminar o produto engadido coa seguinte
--instruci�n:
--DELETE FROM PRODUTO WHERE descricion='PROBA_AVALIACION';
--? Consulta 7.6. N�mero, data e cantidade, dos pedidos con maior n�mero de unidades. No
--resultado aparecer�n primeiro os pedidos m�is antigos.
--? Consulta 7.7. Consulta que devolva o 25% dos empregados cuxo primeiro apelido ten por
--segunda letra un A. A consulta amosar� en diferentes columnas o n�mero, nome propio, o
--primeiro apelido dos empregados, o n�mero de caracteres do primeiro apelido e o nome do
--mes en que foi contratado. Para resolver a busca da letra A na segunda posici�n do primeiro
--apelido, deberase empregar unha funci�n integrada no xestor.
--? Consulta 7.8. Descrici�n dos produtos dos que non se fixeron pedidos. Para obter o
--resultado non se pode empregar ningunha combinaci�n externa, nin a palabra reservada
--DISTINCT, nin subconsultas.
--? Consulta 7.9. Nunha consulta haber� que devolver a hora actual (s� a hora, sen minutos), as
--data e hora actuais con axuste de zona horaria (seguindo o est�ndar Europeo
--predeterminado+milisegundos), o nome da linguaxe do servidor e o n�mero m�ximo de
--conexi�ns permitidas no servidor.
--UD5. RECUPERAR INFORMACI�N DA BASE DE DATOS (DML) TAREFAS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
--p�xina 14
--? Consulta 7.10. Nome de cada cliente e ao lado do mesmo as unidades vendidas de media
--(columna cantidade) nos seus pedidos, s� para aqueles clientes cuxo representante de
--vendas (empregado que ten asociado) ten por t�tulo RP VENDAS. Se non mercaron nada
--deber� aparecer como media de unidades 0.
--A columna das unidades medias deber� ter 3 d�xitos como m�ximo na parte enteira e 2
--decimais.
--Deber�n aparecer primeiro no resultado os clientes con maior n�mero de unidades medias.
--? Consulta 7.11. Produto cartesiano de FABRICANTE e PRODUTO. No resultado aparecer�n
--d�as columnas, o nome do fabricante e a descrici�n do produto. Esta consulta deber�
--facerse sen empregar no FROM combinaci�ns internas.
--? Consulta 7.12. Produto cartesiano de FABRICANTE e PRODUTO. No resultado aparecer�n
--d�as columnas, o nome do fabricante e a descrici�n do produto. Esta consulta deber�
--facerse empregando no FROM s� combinaci�ns internas.
--? Consulta 7.13. Nome dos fabricantes dos que non hai produtos na BD.
--? Consulta 7.14. N�mero identificador e data dos pedidos que te�an 9,7,10 ou 8 unidades e
--que foron comprados polo cliente 1108 ou vendidos polo empregado 101.
--? Consulta 7.15. Nomes de t�dolos clientes e de t�dolos fabricantes da BD nunha �nica
--columna. A columna que se chamar� empresas, deber� aparecer ordenada alfabeticamente.

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
