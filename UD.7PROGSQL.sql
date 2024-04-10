--Dada la BD EMPLEADOS resuelve los siguientes apartados:

--Realiza el código T-SQL en el que realices los siguientes pasos:
--- declara una variable con el tipo de dato adecuado para guardar tu nombre de pila.
--- Asígnale tu nombre de pila fuera de la declaración (no utilices el comando SELECT).
--- Muestra por pantalla un mensaje del tipo Mi nombre es X. (Siendo X el valor que has asignado
--a la variable que guarda tu nombre de pila).declare @nombre varchar(20);set @nombre = 'miguel caamano'print 'mi nombre es ' + @nombre--Realiza un script SQL que imprima el nombre de la oficina con mayor objetivo de ventas. Ese
--nombre deberá guardarse en una variable y el mensaje que muestre el script deberá ser del tipo La
--oficina con mayor objetivo de ventas es la de X. La X deberá ser substituida por el valor guardado en
--la variable.
--¿Qué crees que ocurre si hay más de una oficina con el mismo objetivo de ventas y además es
--el mayor?use EMPLEADOS;declare @oficina varchar(20)select @oficina =  ofi.CIUDAD from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)print 'La oficina con mayor objetivo de ventas es la de '+ @oficina--1.3. Modifica el script del apartado anterior para que ahora además de mostrar el nombre de la
--oficina, muestre el objetivo de ventas, que previamente se habrá almacenado en una variable. En
--este caso el mensaje a mostrar será del siguiente tipo Con objetivo de Y€ la oficina con mayor
--objetivo de ventas es la de X. La X será substituida por el nombre de la oficina y la Y por el importe
--del objetivo de ventas.declare @objVentas varchar(20)declare @oficina2 varchar(20)select @oficina2 =  ofi.CIUDAD from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)select @objVentas = ofi.OBJETIVO from OFICINA ofi where ofi.OBJETIVO = (select max(objetivo) from OFICINA)print 'Con objetivo de ' + @objVentas + ' la oficina con mayor objetivo de ventas es la de ' + @oficina2--1.4. @@LANGUAGE es una variable del sistema que nos indica el idioma que se está utilizando
--actualmente en el servidor. Realiza el script que guarde el valor de esa variable en una nueva que
--debes crear con el nombre idioma. El script tendrá que consultar el valor de la variable idioma y si
--es inglés (us_english) deberá mostrar el mensaje Hello y si es español Hola.

declare @idioma varchar(10)
set @idioma = @@LANGUAGE
if @idioma = 'us_english'
	print 'Hello'
else if @idioma = 'español'
	print 'Hola'


--1.5. Modifica el script anterior suprimiendo la variable @idioma.
if @@LANGUAGE = 'us_english'
	print 'Hello'
else if @@LANGUAGE = 'español'
	print 'Hola'

--1.6. Realiza un script que dado el número de un empleado (que debes almacenar en una variable),
--devuelva su nombre completo y la fecha de contrato. Si el empleado no existe deberá dar un
--mensaje del siguiente tipo El empleado con número X no está presente en la BD.
use EMPLEADOS

declare @numEmpleado int
set @numEmpleado = 101

if (@numEmpleado not in (select rep.NUM_EMPL from REPVENTAS rep))
	print 'el empleado no está en la base de datos'
else 
	select rep.NOMBRE, rep.CONTRATO from REPVENTAS rep where rep.NUM_EMPL = @numEmpleado








--UD7. INTRODUCCIÓN A LA PROGRAMACIÓN DE LAS BBDD PRÁCTICA
--DE BASES DE DATOS
--Docente: Mónica García Constenla
--IES San Clemente
-- página 2
--1.7. Realiza un script que cree una tabla temporal local de nombre CLIENTE2 con la misma
--estructura y contenido de la tabla CLIENTE. Partiendo del cliente con número de cliente (clave
--primaria) mayor, el script deberá eliminar de la tabla temporal cada uno de los clientes existentes de
--uno en uno y hasta que sólo quede uno.
--Por ejemplo, si en la tabla temporal tenemos 4 clientes con números 4001, 4002, 4003 y 4004,
--el script debe empezar borrando el más alto (máximo) y después a ese valor le irá restando 1 para
--poder borrar el cliente anterior, y así hasta que sólo quede 1, en este caso el 4001 porque es el
--menor.
--Usa un bucle WHILE para solucionarlo. Dentro del WHILE harás el borrado y piensa que la
--condición del WHILE es la que determina cuando debemos parar de borrar, ya que MIENTRAS se
--cumpla la condición seguirá borrando clientes.
--En el script deberás visualizar el contenido de la tabla temporal justo después de crearla y al
--final para comprobar que sólo queda un cliente.