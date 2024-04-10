--Dada la BD EMPLEADOS resuelve los siguientes apartados:

--Realiza el c�digo T-SQL en el que realices los siguientes pasos:
--- declara una variable con el tipo de dato adecuado para guardar tu nombre de pila.
--- As�gnale tu nombre de pila fuera de la declaraci�n (no utilices el comando SELECT).
--- Muestra por pantalla un mensaje del tipo Mi nombre es X. (Siendo X el valor que has asignado
--a la variable que guarda tu nombre de pila).declare @nombre varchar(20);set @nombre = 'miguel caamano'print 'mi nombre es ' + @nombre--Realiza un script SQL que imprima el nombre de la oficina con mayor objetivo de ventas. Ese
--nombre deber� guardarse en una variable y el mensaje que muestre el script deber� ser del tipo La
--oficina con mayor objetivo de ventas es la de X. La X deber� ser substituida por el valor guardado en
--la variable.
--�Qu� crees que ocurre si hay m�s de una oficina con el mismo objetivo de ventas y adem�s es
--el mayor?use EMPLEADOS;declare @oficina varchar(20)select @oficina =  ofi.CIUDAD from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)print 'La oficina con mayor objetivo de ventas es la de '+ @oficina--1.3. Modifica el script del apartado anterior para que ahora adem�s de mostrar el nombre de la
--oficina, muestre el objetivo de ventas, que previamente se habr� almacenado en una variable. En
--este caso el mensaje a mostrar ser� del siguiente tipo Con objetivo de Y� la oficina con mayor
--objetivo de ventas es la de X. La X ser� substituida por el nombre de la oficina y la Y por el importe
--del objetivo de ventas.declare @objVentas varchar(20)declare @oficina2 varchar(20)select @oficina2 =  ofi.CIUDAD from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)select @objVentas = ofi.OBJETIVO from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)print 'Con objetivo de ' + @objVentas + ' la oficina con mayor objetivo de ventas es la de ' + @oficina2--1.4. @@LANGUAGE es una variable del sistema que nos indica el idioma que se est� utilizando
--actualmente en el servidor. Realiza el script que guarde el valor de esa variable en una nueva que
--debes crear con el nombre idioma. El script tendr� que consultar el valor de la variable idioma y si
--es ingl�s (us_english) deber� mostrar el mensaje Hello y si es espa�ol Hola.

declare @idioma varchar(10)
set @idioma = @@LANGUAGE
if @idioma = 'us_english'
	print 'Hello'
else if @idioma = 'espa�ol'
	print 'Hola'


--1.5. Modifica el script anterior suprimiendo la variable @idioma.
if @@LANGUAGE = 'us_english'
	print 'Hello'
else if @@LANGUAGE = 'espa�ol'
	print 'Hola'

--1.6. Realiza un script que dado el n�mero de un empleado (que debes almacenar en una variable),
--devuelva su nombre completo y la fecha de contrato. Si el empleado no existe deber� dar un
--mensaje del siguiente tipo El empleado con n�mero X no est� presente en la BD.
use EMPLEADOS

declare @numEmpleado int
set @numEmpleado = 101

if (@numEmpleado not in (select rep.NUM_EMPL from REPVENTAS rep))
	print 'el empleado no est� en la base de datos'
else 
	select rep.NOMBRE, rep.CONTRATO from REPVENTAS rep where rep.NUM_EMPL = @numEmpleado








--UD7. INTRODUCCI�N A LA PROGRAMACI�N DE LAS BBDD PR�CTICA
--DE BASES DE DATOS
--Docente: M�nica Garc�a Constenla
--IES San Clemente
-- p�gina 2
--1.7. Realiza un script que cree una tabla temporal local de nombre CLIENTE2 con la misma
--estructura y contenido de la tabla CLIENTE. Partiendo del cliente con n�mero de cliente (clave
--primaria) mayor, el script deber� eliminar de la tabla temporal cada uno de los clientes existentes de
--uno en uno y hasta que s�lo quede uno.
--Por ejemplo, si en la tabla temporal tenemos 4 clientes con n�meros 4001, 4002, 4003 y 4004,
--el script debe empezar borrando el m�s alto (m�ximo) y despu�s a ese valor le ir� restando 1 para
--poder borrar el cliente anterior, y as� hasta que s�lo quede 1, en este caso el 4001 porque es el
--menor.
--Usa un bucle WHILE para solucionarlo. Dentro del WHILE har�s el borrado y piensa que la
--condici�n del WHILE es la que determina cuando debemos parar de borrar, ya que MIENTRAS se
--cumpla la condici�n seguir� borrando clientes.
--En el script deber�s visualizar el contenido de la tabla temporal justo despu�s de crearla y al
--final para comprobar que s�lo queda un cliente.