/*************************************************************/
/**** UD05. Recuperar informaci�n da base de datos (DML). ****/
/****          ACTIVIDADE 01. Consultas simples           ****/
/***********        CONSULTAS PROPOSTAS          *************/
/*************************************************************/
	
	--Seleccionamos a BD SOCIEDADE_CULTURAL
	USE SOCIEDADE_CULTURAL;

	/*** CONSULTA PROPOSTA 1 ***/
	--Nome e apelidos (cada un nunha columna) 
	--de todos os empregados
	SELECT nome, ape1, ape2
	FROM EMPREGADO;

	/*** CONSULTA PROPOSTA 2 ***/
	--N�mero, nome e apelidos (cada un nunha columna) 
	--de todos os empregados
	SELECT numero, nome, ape1, ape2
	FROM EMPREGADO;

	/*** CONSULTA PROPOSTA 3 ***/
	--N�mero, nome e apelidos (cada un nunha columna) 
	--de todos os empregados por orde alfab�tica de 
	--apelidos e nome
	SELECT numero, nome, ape1, ape2
	FROM EMPREGADO
	ORDER BY ape1, ape2, nome;

	/*** CONSULTA PROPOSTA 4 ***/
	--N�mero, nome e apelidos (cada un nunha columna) 
	--de todos os empregados por orde alfab�tica de 
	--apelidos e nome. Os nomes das columnas no resultado ser�n:
	--num_socio, nome_socio, apelido1, apelido2
	SELECT numero as num_socio, nome as nome_socio, 
	       ape1 as apelido1, ape2 as apelido2
	FROM EMPREGADO
	ORDER BY ape1, ape2, nome;

	/*** CONSULTA PROPOSTA 5 ***/
	--N�mero, nome completo (os 4 campos nunha �nica columna, 
	--de nome socio, co formato numero - ape1 ape2, nome) 
	--e salario de todos os empregados. 
	--No resultado deber�n aparecer primeiro os que m�is cobran.
	SELECT cast(numero as varchar(7))+' - '+ape1+' '+ape2+', '+ nome 
	       as socio, 
		   salario_mes
	FROM EMPREGADO
	ORDER BY salario_mes desc;

	/*** CONSULTA PROPOSTA 6 ***/
	--N�mero, nome completo (os 4 campos nunha �nica columna,
	--de nome socio, co formato numero - ape1 ape2, nome) 
	--e salario de todo o profesorado. 
	--No resultado deber�n aparecer primeiro os 
	--que m�is cobran. O campo cargo cont�n PRF para 
	--o profesorado, e ADM se � un ou unha administrativo.
	SELECT cast(numero as varchar(7))+' - '+ape1+' '+ape2+', '+ nome 
	       as socio, 
		   salario_mes
	FROM EMPREGADO
	WHERE cargo='PRF'
	ORDER BY salario_mes desc;

	/*** CONSULTA PROPOSTA 7 ***/
	--N�mero identificador do profesorado que imparte clases. 
	--Como � l�xico, se un profesor imparte m�is dunha 
	--actividade, o seu n�mero s� pode aparecer unha vez.
	SELECT DISTINCT num_profesorado_imparte
	FROM ACTIVIDADE;
	
	/*** CONSULTA PROPOSTA 8 ***/
	--N�mero identificador das actividades �s 
	--que asiste profesorado, � dicir, 
	--cursadas por profesorado. 
	SELECT DISTINCT id_actividade
	FROM PROFE_CURSA_ACTI;
	
	/*** CONSULTA PROPOSTA 9 ***/
	--Nome, prezo, e prezo rebaixado un 20%, 
	--da actividade de nome XADREZ.
	--Soluci�n1
	SELECT nome, prezo, prezo-(prezo*0.20) as prezo_rebaixado
	FROM ACTIVIDADE
	WHERE nome='XADREZ';
	--Soluci�n2
	SELECT nome, prezo, prezo*0.80 as prezo_rebaixado
	FROM ACTIVIDADE
	WHERE nome='XADREZ';

	/*** CONSULTA PROPOSTA 10 ***/
	--NIF, nome e apelidos dos socios
	--dos que non temos tel�fono gardado.
	SELECT NIF, nome, ape1, ape2
	FROM SOCIO
	WHERE telefono1 IS NULL AND
	      telefono2 IS NULL;

	/*** CONSULTA PROPOSTA 11 ***/
	--NIF, nome e apelidos e data de nacemento dos socios
	--nados entre 1980 e 1990 (ambos inclu�dos).
	SELECT NIF, nome, ape1, ape2, data_nac
	FROM SOCIO
	WHERE data_nac BETWEEN '1/1/1980' AND '31/12/1990';

	/*** CONSULTA PROPOSTA 12 ***/
	--Todos os datos das actividades cuxo nome cont�n a letra T.
	SELECT *
	FROM ACTIVIDADE
	WHERE nome LIKE '%T%';

	/*** CONSULTA PROPOSTA 13 ***/
	--Nome e importe das cotas cun custo de 30 ou 100 euros.
	--Soluci�n1
	SELECT nome, importe
	FROM COTA
	WHERE importe IN (30,100);
	--Soluci�n2
	SELECT nome, importe
	FROM COTA
	WHERE importe=30 OR
		  importe=100;

	/*** CONSULTA PROPOSTA 14 ***/
	--Nome e n�mero de prazas das actividades 
	--que non te�en nin 15 nin 20 prazas.
	--Soluci�n1
	SELECT nome, num_prazas
	FROM ACTIVIDADE
	WHERE num_prazas NOT IN (15,20);
	--Soluci�n2
	SELECT nome, num_prazas
	FROM ACTIVIDADE
	WHERE num_prazas!=15 AND
	      num_prazas!=20;
		
	--Seleccionamos a BD EMPRESA
	USE EMPRESA;


	/*** CONSULTA PROPOSTA 15 ***/
	--Nome de todos os clientes por orde alfab�tica. 
	--F�xate como se chama o campo que garda o nome do cliente.
	SELECT nome
	FROM CLIENTE
	ORDER BY nome;

	/*** CONSULTA PROPOSTA 16 ***/	
	--Nome das rexi�ns nas que ten sucursais a empresa.
	SELECT DISTINCT rexion
	FROM SUCURSAL;
	
	/*** CONSULTA PROPOSTA 17 ***/
	--Identificador dos produtos que nos pediron 
	--nalg�n momento. No resultado debe aparecer 
	--nunha soa columna o c�digo do fabricante e o 
	--identificador do produto separados por un gui�n.
	SELECT DISTINCT cod_fabricante+'-'+id_produto as produtos
	FROM PEDIDO;	

	/*** CONSULTA PROPOSTA 18 ***/
	--Informaci�n completa das sucursais non 
	--dirixidas polo empregado n�mero 108.
	--Soluci�n1
	SELECT identificador, cidade, rexion, 
	       num_empregado_director, obxectivo
	FROM SUCURSAL
	WHERE num_empregado_director!=108;
	--Soluci�n2
	SELECT *
	FROM SUCURSAL
	WHERE num_empregado_director!=108;
	
	/*** CONSULTA PROPOSTA 19 ***/
	--Nome e l�mite de cr�dito do cliente n�mero 1107.
	SELECT nome, limite_de_credito
	FROM CLIENTE
	WHERE numero=1107;

	/*** CONSULTA PROPOSTA 20 ***/
	--N�mero e data dos pedidos feitos entre o 1 de agosto
	--e o 31 de decembro de 2014. S� debe aparecer a data 
	--de cada pedido, sen a hora, co formato dd-mm-aaaa.
	--Deben aparecer primeiro no resultado os pedidos m�is recentes. 
	--Para resolver esta consulta non se poden utilizar 
	--operadores de comparaci�n (>, <, >=, <=, < >, !=).
	SELECT numero, convert(char(10), data_pedido, 105) 
	       as data_do_pedido
	FROM PEDIDO
	WHERE data_pedido BETWEEN '1-08-2014' AND '31-12-2014'
	ORDER BY data_pedido DESC;

	/*** CONSULTA PROPOSTA 21 ***/
	--C�digo e nome dos fabricantes cuxo nome 
	--ten por segunda letra O.
	SELECT codigo, nome
	FROM FABRICANTE
	WHERE nome LIKE '_O%';

	/*** CONSULTA PROPOSTA 22 ***/
	--Descrici�n e prezo dos produtos dos 
	--que non temos existencias.
	SELECT descricion, prezo
	FROM PRODUTO
	WHERE existencias=0;

	/*** CONSULTA PROPOSTA 23 ***/
	--N�mero identificador e nome completo dos 
	--empregados que non te�en xefe.
	SELECT numero, nome, ape1, ape2
	FROM EMPREGADO
	WHERE num_empregado_xefe IS NULL;

	/*** CONSULTA PROPOSTA 24 ***/
	--Descrici�n e unidades existentes, dos produtos 
	--con existencias maiores 
	--de 10 unidades e menores de 100. Para resolver esta 
	--consulta non se poden utilizar operadores 
	--de comparaci�n (>, <, >=, <=, < >, !=).
	SELECT descricion, existencias
	FROM PRODUTO
	WHERE existencias BETWEEN 11 AND 99;


