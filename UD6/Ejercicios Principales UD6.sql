-- Consultas propostas na BD SOCIEDADE CULTURAL
--Proposta 1. Aumentar o número de prazas das actividades nun 15%.
use SOCIEDADE_CULTURAL
GO

select * from ACTIVIDADE

begin tran
UPDATE ACTIVIDADE
SET num_prazas = num_prazas*1.15

select * from ACTIVIDADE
rollback
--– Proposta 2. Cambiar o estado da aula de nome AULA SUR a regular (R).

use SOCIEDADE_CULTURAL
GO

select * from AULA

begin tran
UPDATE AULA
set estado = 'R'
WHERE descricion = 'AULA SUR'

select * from AULA
rollback
--– Proposta 3. Engadir unha aula nova de número 9, nome AULA NOVA e con
--superficie e estado os mesmos que os da aula COCIÑA.
use SOCIEDADE_CULTURAL
GO

select * from AULA

begin tran
INSERT INTO AULA (numero,descricion,superficie,estado)
select 9,'AULA NOVA', superficie, estado
from  AULA
where descricion='COCIÑA'

select * from AULA
rollback


--– Proposta 4. Engadir dúas novas cotas, unha cos datos 21, COTA1, 75 e outra cos
--datos 22, COTA2 e 74.3.
use SOCIEDADE_CULTURAL
GO

select * from COTA

begin tran
INSERT INTO COTA (codigo,nome,importe)
values(21,'COTA1',75),(22,'COTA2',74.3)

select * from COTA
rollback
--– Proposta 5. Crear unha táboa temporal global PROFE_ASISTENTE_ACTI co nif, nome
--e primeiro apelido do profesorado que asiste a actividades.
use SOCIEDADE_CULTURAL
GO

select * FROM EMPREGADO
select * from PROFE_CURSA_ACTI

begin tran
SELECT nif, nome, ape1
INTO ##PROFE_ASISTENTE_ACTI
FROM EMPREGADO e join PROFE_CURSA_ACTI pca on e.numero = pca.num_profesorado 

select * from ##PROFE_ASISTENTE_ACTI
rollback

--– Proposta 6. Crear unha táboa permanente de nome AULA_MALA coas aulas en mal
--estado (Estado=M) e coas mesmas columnas da táboa AULA. Os nomes dos campos
--de AULA_MALA serán codigo, nome, m2 e estado.
use SOCIEDADE_CULTURAL
GO

select *
from AULA

begin tran
select numero as codigo, descricion as nome, superficie as m2, estado
into AULA_MALA
from AULA
where estado='M'

select *
from AULA_MALA
rollback


--– Proposta 7. Crear unha táboa temporal local que sexa unha copia en canto a contido
--e columnas da táboa ACTIVIDADE e que se chame ACTI2. Antes de pechar a
--transacción, farase unha consulta que elimine todas as actividades da táboa nova
--que non teñan observacións.
use SOCIEDADE_CULTURAL
GO

begin tran
select *
into ACTI2
from ACTIVIDADE


select *
from acti2

delete from ACTI2
where observacions is null


select * from acti2
rollback



--– Proposta 8. Crear unha táboa temporal local de nome SOCIO2 copia de SOCIO. A
--continuación faremos a consulta que elimine de SOCIO2 aqueles socios que non
--teñen teléfono algún.
use SOCIEDADE_CULTURAL
GO

begin tran
select *
into #SOCIO2
from SOCIO

select * from #SOCIO2

delete from #SOCIO2
where telefono1 is null and telefono2 is null

select * from #SOCIO2
rollback


--– Proposta 9. Substituír os espazos en branco das observacións das actividades, as que
--asisten docentes, por guións baixos(_).
use SOCIEDADE_CULTURAL

select observacions
from ACTIVIDADE
where identificador in (select id_actividade from PROFE_CURSA_ACTI)

begin tran

UPDATE ACTIVIDADE
SET observacions = REPLACE(observacions,' ','_')
where identificador in (select id_actividade from PROFE_CURSA_ACTI)

select observacions
from ACTIVIDADE
where identificador in (select id_actividade from PROFE_CURSA_ACTI)

rollback

--– Proposta 10. Retrasar nun día a data de inicio de tódalas actividades que aínda non
--comezaron a día de hoxe.
use SOCIEDADE_CULTURAL
GO

begin tran
select * from ACTIVIDADE

UPDATE ACTIVIDADE
SET data_ini = data_ini+1
where data_ini > GETDATE()

select * from ACTIVIDADE
rollback

-- Consultas propostas na BD EMPRESA.
--– Proposta 11. Eliminar os fabricantes dos que non hai produtos na BD.
use EMPRESA
GO

select *
from FABRICANTE

begin tran
DELETE from FABRICANTE
where codigo not in (select cod_fabricante from PRODUTO)

select * from FABRICANTE
select * from PRODUTO

rollback

--– Proposta 12. Incrementar o obxectivo das sucursais da rexión OESTE nun 6% e
--modificar o nome da rexión por WEST.
use EMPRESA
GO

select * from SUCURSAL

begin tran
UPDATE SUCURSAL
SET obxectivo = obxectivo*1.06,
	rexion = 'WEST'
where rexion ='OESTE'

select * from SUCURSAL

rollback
--– Proposta 13. Crear unha táboa de nome FABRICANTE2 que sexa unha copia de
--FABRICANTE en número e nome de columnas e en contido. Elimina todas as filas da
--nova táboa do xeito máis rápido e menos custoso posible.
USE EMPRESA
GO

begin tran

select *
into FABRICANTE2
from FABRICANTE

TRUNCATE TABLE FABRICANTE2


select * from FABRICANTE2
rollback


--– Proposta 14. Transferir todos os empregados que traballan na sucursal de
--BARCELONA á sucursal de VIGO, e cambiar a súa cota de vendas pola media das
--cotas de vendas de tódolos empregados.
use EMPRESA
GO

select *
from EMPREGADO

select * from SUCURSAL

begin tran
UPDATE EMPREGADO
SET id_sucursal_traballa = (select identificador 
							from SUCURSAL where cidade= 'VIGO'),
cota_de_vendas = (select avg(cota_de_vendas) from EMPREGADO)
where id_sucursal_traballa = (select identificador from SUCURSAL
							  where cidade = 'BARCELONA')
							  
select * from EMPREGADO

rollback


--– Proposta 15. Elimina os pedidos de empregados contratados antes do ano 2001.