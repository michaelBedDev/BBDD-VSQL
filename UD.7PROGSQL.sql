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
use EMPLEADOS;
GO

begin tran
select * into #CLIENTE2
from CLIENTE

select * from #CLIENTE2

while (select count(num_clie) from #CLIENTE2) > 0
BEGIN
	DELETE FROM #CLIENTE2 
	where NUM_CLIE = (select max(NUM_CLIE) from #CLIENTE2)
END
select * from #CLIENTE2
rollback;

--IMPORTANTE: Recuerda que los borrados debes hacerlos en la tabla temporal no en CLIENTE.
--1.8. Realiza un script que nos muestre inicialmente el mensaje Ejemplo de USO de CASE. A
--continuación en el script deberemos comprobar la información de los representantes de ventas de
--tal manera que con una consulta mostraremos de todos los empleados el número de empleado, el
--nombre, la cuota y en una última columna de nombre DESCRIPCION_CUOTA deberá verse la
--siguiente información:
--- Si no tiene cuota se muestra la frase Sin cuota.
--- Si es mayor de 300000 se muestra la frase Cuota alta.
--- Si es igual a 300000 se muestra la frase Cuota perfecta.
--- En otro caso se mostrará la frase Cuota baja.
--Para mostrar la información de la columna DESCRIPCION_CUOTA utiliza la instrucción de control
--de flujo CASE.print('Ejemplo de uso de case')select rep.NUM_EMPL, rep.NOMBRE, rep.CUOTA,(CASE
WHEN rep.CUOTA is null THEN 'Sin cuota' -- = 0
WHEN rep.CUOTA > 300000 THEN 'Cuota alta'
WHEN rep.CUOTA = 300000 THEN 'Cuota perfecta'
ELSE 'Cuota baja'
END) as DESCRIPCION_CUOTA 

from REPVENTAS rep

--1.9. Realiza un script que mediante un bucle imprima las decenas del 1 al 100. Deberá aparecer lo
--siguiente: 10-20-30-40-50-60-70-80-90-100
--Las decenas deberán ir separadas por guiones

DECLARE @incremento int;
SET @incremento = 0
DECLARE @toPrint varchar(30)
SET @toPrint = ''


while(@incremento) <100
BEGIN
	SET @incremento = @incremento + 10
	SET @toPrint = @toPrint + CAST(@incremento as varchar) + '-'
END
	print @toPrint
--1.10. Crea un script que dado un número de pedido (decláralo int) muestre en un mensaje de aviso
--(usando print) las existencias que habría si se devolviese la mercancía. El mensaje tendrá el formato
--siguiente:
--Si devolvemos el pedido nº X quedarán N existencias del producto con descripción S.
--Si el número de pedido dado no existe daremos un mensaje de error (usando raiserror) de
--gravedad 12, estado 1 y con el siguiente texto:
--El pedido de nº X no existe en la base de datos.
--NOTA: En nuestros scripts para los mensajes de aviso usaremos print y para los de error raiserror--1.11. Escribe la/s instrucciones SQL necesarias para crear un mensaje de error personalizado
--teniendo en cuenta los siguientes datos que se te proporcionan:
--@msgnum= 50004
--@severity= 14
--@msgtext= nuevo mensaje
--@lang= español
--NOTA: Si el mensaje fuese en ingles, el texto sería new message y el lenguaje us_english.
--@with_log= tendrá el valor necesario para que en caso de que el error se produzca se escriba en el
--registro de aplicación de MS Windows®.

--1.12. Observa el siguiente código en T-SQL:
--DECLARE @divisor int,
-- @dividendo int ,
-- @resultado int;
--SET @dividendo = 100;
--SET @divisor = 0;
--SET @resultado = @dividendo/@divisor
--Ejecútalo y observa el error que genera. Como habrás comprobado genera un mensaje de
--error por división por 0.
--Modifica el código anterior y utilizando la variable del sistema @@error después de la
--división, deberás comprobar si ha habido un error y si es así mostrarás el mensaje de aviso Error en
--la división y si no se produce error se mostrará el mensaje de aviso División correcta.
--Para probar el código cambia el valor del divisor para que la división sea correcta.

--1.13. Modifica el código del ejercicio anterior para que se controle el error en la división pero sin
--usar @@error y utilizando un bloque TRY…CATCH.

--1.14. Modifica el código del ejercicio anterior para que ahora en lugar de un mensaje de aviso, en el
--caso de producirse un error se muestre el mensaje de error siguiente:
--Dividir A entre B genera un error
--A será el dividendo y B el divisor. La gravedad del error será 12 y el estado 1.

--1.15. Escribe la/s instrucciones SQL necesarias para crear un mensaje de error personalizado
--teniendo en cuenta los siguientes datos que se te proporcionan:
--@msgnum= 50025
--@severity= 12
--@msgtext= Dividir A entre B genera un error
--@lang= español
--NOTA: Si el mensaje fuese en ingles, el texto sería Division error A/B y el lenguaje us_english.

--1.16. Modifica el código del ejercicio 1.14 de tal modo que uses el mensaje 50025 que acabas de
--crear para lanzar el error.

--1.17. Realiza un script que agregue un nuevo pedido. Ten en cuenta que añadir un pedido implica:
--- controlar que el usuario ha proporcionado los datos obligatorios (si no lo ha hecho hay que
--enviar un mensaje de aviso),
--- comprobar que hay suficientes existencias del producto. Si no las hay deberá enviarse un
--aviso al usuario.
--Si hay existencias suficientes y además el usuario ha proporcionado todos los datos
--obligatorios, se insertará el pedido.
--Si ha habido algún error en la inserción del pedido deberá notificarse el siguiente mensaje de
--error Error en la inserción del nuevo pedido. Este mensaje deberá poder ser visto en el visor de
--sucesos de MS Windows®.
--Si la inserción no ha dado problemas, deberán actualizarse las ventas del vendedor, así como
--las existencias del producto.
--Si la inserción del pedido se realiza correctamente el procedimiento deberá mostrar el
--siguiente mensaje de aviso Inserción del pedido número: X. Ten en cuenta que la X hace referencia al
--número del pedido agregado.
--Recuerda utilizar una transacción para que se bloqueen las tablas que vas a usar.

--1.18. Usando un cursor deberás mostrar información de todos los empleados de la base de datos y
--para cada uno de ellos la información deberá aparecer con la siguiente estructura:
----------------------------- INFORME DE EMPLEADOS ----------------------------------
--Empleado Nº: 10
--Nombre: Antonio Pérez
--Oficina: CHICAGO
----------------------------------------------------------------------------------------------------
--Empleado Nº: 12
--Nombre: Carmen González
--Oficina: ATLANTA
----------------------------------------------------------------------------------------------------
--.
--.
--.
----------------------------------------------------------------------------------------------------
--El listado deberá aparecer ordenado alfabéticamente por el nombre del empleado.

--1.19. Modifica el código anterior para que usando @@CURSOR_ROWS al final del informe aparezca
--la frase El número total de empleados es X.

--1.20. Modifica el código del ejercicio 1.18 para que ahora la ordenación sea por número de
--empleado y además los empleados que se muestren serán sólo los indicados a continuación y en
--ese orden:
--- El empleado de la última fila del cursor
--- El empleado de la penúltima fila del cursor
--- El empleado de la primera fila del cursor
--- El empleado que está tres filas después de la fila actual del cursor
--- El empleado de la fila quinta del cursor
--- El empleado que está dos filas antes de la fila actual del cursor


--TAREA 2: Ejemplos de bucles
--Para resolver los siguientes apartados deberás usar la instrucción WHILE.
--2.1. Realiza el código T-SQL que muestre la suma de los números enteros del 1 al 535. EL script
--deberá mostrar un mensaje del siguiente tipo La suma de los números del 1 al 535 es X.

DECLARE @contador int;
SET @contador = 1

DECLARE @acumulador int
SET @acumulador = 0

while @contador <= 535

BEGIN 
SET @acumulador += @contador
SET @contador += 1
END

print('La suma de los números del 1 al ' + cast(@contador-1 as varchar) + ' es ' + cast(@acumulador as varchar))

--2.2. Realiza un script que muestre la tabla de multiplicar del 5.
DECLARE @contador5 int
SET @contador5 = 0

while @contador5 <=10
BEGIN
print('5x' + cast(@contador5 as varchar) + '=' + cast((5*@contador5)as varchar))
SET @contador5 += 1
END

--2.3. Implementa el código necesario para mostrar los múltiplos de 7 entre 1 y 100. Un número es
--múltiplo de 7 si al dividirlo entre 7 el resto es 0.
DECLARE @contador7 int
SET @contador7 = 0

while @contador7 <= 100
BEGIN
SET @contador7 +=1
if @contador7%7 = 0
	print @contador7
END

--2.4. Escribe un script que calcule la suma de cada tercer entero comenzando por el 2 para todos
--los valores menores de 100 (2+5+8+11…). Al final imprimirá un mensaje como este La suma es X.

--2.5. Script que muestre el resultado de multiplicar los 10 primeros números enteros. Al final
--imprimirá un mensaje como este El producto del 1 al 10 es X.DECLARE @contadormultiplicar int
SET @contadormultiplicar = 1DECLARE @acumuladormultiplicar intSET @acumuladormultiplicar = 1while @contadormultiplicar <= 10BEGINSET @acumuladormultiplicar *= @contadormultiplicarSET @contadormultiplicar +=1ENDprint @acumuladormultiplicar --revisar