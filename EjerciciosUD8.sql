--UD8. PROCEDIMIENTOS ALMACENADOS PRÁCTICA
--BASES DE DATOS


--1. Partiendo del código del procedimiento almacenado spu_multiplicar del ejemplo de parámetros de
--salida de la teoría, crea un procedimiento almacenado de nombre spu_operaciones que además de mostrar
--el resultado de la multiplicación muestre el de la suma, usando parámetros de salida para ambas
--operaciones.
use EMPLEADOS;
GO

create proc dbo.spu_operaciones
@m1 smallint, @m2 smallint, @multiplicacion smallint output, @suma smallint output
as
SET @multiplicacion = @m1 * @m2
SET @suma = @m1 + @m2
GO

DECLARE @respuesta_multi smallint
DECLARE @respuesta_suma smallint

exec.dbo.spu_operaciones 2,3, @respuesta_multi output, @respuesta_suma output
select 'El resultado de la multiplicacion es: ', @respuesta_multi, 'El resultado de la suma es: ', @respuesta_suma


--2. Crea el procedimiento almacenado que permite agregar una nueva oficina.
--En este ejercicio crearás el procedimiento almacenado spu_agregar_oficina. Ten en cuenta los
--parámetros que debe recibir (ciudad, region, director, objetivo y ventas). El número de oficina debe
--calcularse en el procedimiento (será un número más del máximo existente). Para que la inserción sea
--correcta deberás controlar lo siguiente:
-- Que todos los parámetros obligatorios hayan sido pasados al procedimiento almacenado. Si alguno de
--los campos requeridos falta, muestra un mensaje usando print y termina el procedimiento.
-- Que el código del director sea correcto. Si no lo es muestra un mensaje de error usando raiserror de tal
--manera que si se produce quede registrado en el registro de aplicación de MS Windows®. Indica en el
--error nivel de gravedad 14 y estado 1.
--Ten en cuenta que debes meter la inserción en una transacción, de tal manera que si al insertar se
--produce un error (@@error<>0) se deberá deshacer la transacción y se termina el procedimiento. Si todo ha
--ido bien deberá hacerse commit para que los cambios se vean reflejados en la BD.
--PASOS:
--A) Declarar los parámetros necesarios.
--B) Controlar los valores obligatorios.
--C) Controlar que el código de director sea el de un empleado de la BD.
--D) Obtener el número de la nueva oficina.
--E)Insertar la nueva oficina en la tabla oficina mediante una transacción.
--EJECUCIÓN:
--A) Ejecuta el procedimiento almacenado que acabas de crear pasando la región como null.
--B) Ejecuta spu_agregar_oficina pasando un número incorrecto de director. Obtienes un error.
--C) Comprueba en el visor de sucesos de MS Windows que el error ha quedado registrado. (Inicio-
-->Equipo, botón derecho->Administrar->Visor de eventos->Registros de Windows ->Aplicación, o
--también ejecutando el comando eventvwr.msc).
--D) Comprueba también como ha quedado registrado en el servidor de BD. En el SSMS expande el
--servidor->carpeta Administración->Registros de SQL Server->Actual. Ordena el panel en orden
--descendente de fecha. En el panel de detalles verás la lista de las acciones registradas, entre ellas
--estará el error provocado por la ejecución del procedimiento spu_ agregar_oficina usando un
--número de director incorrecto.
--E) Ejecuta el procedimiento almacenado desde el Explorador de objetos
--(BD EMPLEADOS->Programación->Procedimientos almacenados->spu_agregar_oficina, botón
--derecho->Ejecutar procedimiento almacenado) para agregar la oficina de Santiago, región
--NOROESTE, director 102, objetivo 600000 y ventas 500000.
--F) Comprueba que se ha agregado la nueva oficina.
use EMPLEADOS;
GO

create proc dbo.spu_agregar_oficina @ciudad char(15), @region char(10), @director int, @objetivo numeric(18,0), @ventas numeric(18,0)
as
begin tran
	IF @ciudad is null or @region is null or @objetivo is null or @ventas is null
	begin
		print 'Alguno de los valores introducidos es nulo'
		rollback;
	end
	
	ELSE
	begin
		if not exists (select NUM_EMPL from REPVENTAS rep where NUM_EMPL = @director) and @director is not null
		begin
			raiserror('El número de empleado no es correcto',14,1) with log; --with log =MS Windows
			rollback;
		end
		else
		begin
			DECLARE @num_oficina int
			SET @num_oficina = (select max(oficina) + 1 from OFICINA ofi)

			insert into OFICINA (oficina, ciudad, region, dir, objetivo, ventas)
			values(@num_oficina, @ciudad, @region, @director, @objetivo, @ventas)

			if @@ERROR = 0
				commit;
			else rollback;
		end
	end
	--if @@TRANCOUNT!=
	--	rollback;

exec dbo.spu_agregar_oficina @ciudad='vigo', @region=null, @director=105, @objetivo=50, @ventas=50
exec dbo.spu_agregar_oficina @ciudad='vigo', @region='oeste', @director=700, @objetivo=50, @ventas=50

--3. Crea el procedimiento almacenado que permite agregar un pedido nuevo.
--El procedimiento almacenado se llamará spu_agregar_pedido y tendrá su código encriptado. Ten en
--cuenta que agregar un nuevo pedido implica además de controlar las correctas entradas de los datos,
--modificar las ventas del vendedor y la oficina correspondientes, así como las existencias del producto.
use EMPLEADOS;
GO

create proc dbo.agregar_pedido_nuevo @cliente int, @rep int, @fab char(3), @producto char(5), @cant int, @importe numeric(18,0)
as 
begin tran
	if @cliente is null or @rep is null or @fab is null or @producto is null or @cant is null or @importe is null
	begin
		print('Alguno de los datos introducidos es nulo')
		rollback;
	end

	else
	begin
		if @cliente is not null and not exists (select num_clie from CLIENTE where NUM_CLIE = @cliente)
			begin
				raiserror('El número del cliente no es correcto',14,1)
				rollback;
			end
		else if @rep is not null and not exists (select rep.NUM_EMPL from REPVENTAS rep where rep.NUM_EMPL = @rep)
			begin
				raiserror('El número del repventas no es correcto',14,1)
				rollback;
			end
		else if @fab is not null and not exists (select from )
				


--4. En la BD SOCIOS crea un procedimiento almacenado de usuario de nombre spu_aumentar_salario que
--incremente el salario de todos los profesores de la SOCIEDAD en un 5%. Habrá que comprobar si la
--actualización supone que el total de gasto en salarios de profesores supere los 15000 euros, porque si esto es
--así deberá deshacerse la actualización. Además el procedimiento almacenado deberá devolver el gasto
--salarial (suma de todos los salarios) en un parámetro, tanto si se han superado los 15000 euros como sino. El
--código de este procedimiento no podrá ser visto por ningún usuario.
--Escribe la instrucción o instrucciones necesarias para ejecutar el procedimiento, teniendo en cuenta
--que deberás mostrar un mensaje del tipo El gasto salarial es X, siendo X el valor devuelto por el
--procedimiento almacenado.
--Además comprueba con una consulta si se ha realizado correctamente el incremento salarial.
--5. Crea un procedimiento almacenado de nombre spu_actualizar_salario_empleado de la SOCIEDAD
--cuyo código no pueda ser consultado por los usuarios.
--Este procedimiento disminuirá el salario de un empleado dado en una cantidad dada. Es decir, el
--usuario deberá indicar el código del empleado cuyo salario desea reducir y la cantidad que desea disminuir al
--sueldo de ese empleado indicado. El usuario deberá dar los 2 datos obligatoriamente y si no lo hace se le
--dará un aviso.
--Una vez reducido el salario en la cantidad dada, si el salario de todos los empleados (salario total) es
--inferior a 10.000 €, se borrará de la bd el empleado que el usuario había indicado. Si el salario no es inferior a
--10.000 € habrá que deshacer el decremento salarial del principio.
--Haz el procedimiento de tal manera que se pueda recuperar el estado de la base de datos hasta justo
--antes del borrado del empleado, es decir, que se pudiese deshacer el borrado sin deshacer el decremento
--salarial.
--Supere o no supere los 10.000€ el procedimiento almacenado deberá mostrar el salario total.
--6. Realiza un procedimiento almacenado de nombre spu_insertar_cliente que permita insertar un nuevo
--cliente en la BD EMPLEADOS, de tal manera que si ya existe otro con el mismo nombre, es decir, si ya
--tenemos datos de la empresa a insertar almacenados, demos un error. Ten en cuenta que al usuario habrá
--que solicitarle aquellos datos que sean obligatorios en la tabla de clientes.
--Además si todo ha ido bien darás un mensaje (no de error) del tipo Cliente nombre_cliente insertado
--correctamente.
--El código de este procedimiento no podrá ser visto por ningún usuario.
--Utilizando el procedimiento almacenado que acabas de crear inserta el EMPRESA_DAW, asignado a la
--vendedora Mary Jones y con límite de crédito 35000. Hazlo de tal manera que obligues a recompilar el
--procedimiento almacenado en esa ejecución.
--UD8. PROCEDIMIENTOS ALMACENADOS PRÁCTICA
--BASES DE DATOS
--Docente: Mónica García Constenla
--IES San Clemente
-- página 3
--7. En la BD EMPLEADOS crea un procedimiento almacenado de nombre spu_supera_importe_medio,
--que a partir del número de un representante de ventas que se le proporciona muestre dentro del
--procedimiento uno de los 2 mensajes siguientes, según sea el caso:
-- El importe total cantidad_importe_total de los pedidos del vendedor nombre_del_vendedor
--supera el importe medio cantidad_importe_medio de los pedidos de la BD.
--Este mensaje se dará como un aviso.
-- El importe total de los pedidos del vendedor nombre_del_vendedor NO supera el importe
--medio de los pedidos de la BD.
--Este mensaje se dará como un error que debe poder visualizarse en el visor de
--eventos de Windows.
--Substituyendo en el mensaje:
--- cantidad_importe_total: el importe total de los pedidos, del vendedor proporcionado por el
--usuario.
--- nombre_del_vendedor: el nombre completo del vendedor.
--- cantidad_importe_medio: el importe medio de los pedidos de la BD.
--Realiza los controles de entrada de datos oportunos, dando los correspondientes avisos, no errores.
--Realiza la ejecución del procedimiento para el empleado 101 de tal manera que el procedimiento se
--vuelva a compilar SÓLO en esta ejecución.
--Ejecuta también el procedimiento para los empleados 103, 104 y 978.
--7.1. A partir del código del procedimiento spu_supera_importe_medio crea otro de nombre
--spu_supera_importe_medio_v2 para que ahora el mensaje informativo (El importe total…) se muestre fuera
--del procedimiento almacenado.
--Crea el procedimiento de tal manera que se vuelva a compilar cada vez que se ejecute.
--Ejecuta el procedimiento para los empleados 101 y 103.
--7.2. Realiza la instrucción que marca el procedimiento spu_supera_importe_medio para que se compile la
--siguiente vez que se ejecute.
--7.3. Ejecuta la instrucción que muestra el código fuente del procedimiento almacenado
--spu_supera_importe_medio.
--7.4. Realiza la instrucción o instrucciones necesarias para que el código del procedimiento
--spu_supera_importe_medio que ya has creado no pueda ser visto por los usuarios.
--7.5. Usando cursores y la/s llamada/s al procedimiento almacenado ya creado
--spu_supera_importe_medio_v2, realiza el código que nos muestre de cada empleado de la BD EMPLEADOS
--el mensaje que le corresponda según sus pedidos superen o no el importe medio de los pedidos de la BD. La
--información de los empleados aparecerá por orden alfabético de su nombre.
--UD8. PROCEDIMIENTOS ALMACENADOS PRÁCTICA
--BASES DE DATOS
--Docente: Mónica García Constenla
--IES San Clemente
-- página 4
--8. En la BD SOCIOS crea un procedimiento almacenado de nombre spu_socio_moroso, que a partir del
--número de un socio que se le proporciona muestre dentro del procedimiento uno de los 2 mensajes
--siguientes, según sea el caso:
-- El socio nombre_completo debe N actividades.
--Este mensaje se dará como un aviso.
-- El socio nombre_completo NO debe actividades.
--Este mensaje se dará como un error que debe poder visualizarse en el visor de
--eventos de Windows.
--Substituyendo en el mensaje:
--- nombre_completo: Nombre Apellido1 Apellido2 del socio (Ejemplo: Ana García Pin).
--- N: número de actividades no pagadas por el socio indicado.
--Realiza los controles de entrada de datos oportunos, dando los correspondientes avisos, no errores.
--Realiza la ejecución del procedimiento para el socio 1000 de tal manera que el procedimiento se
--vuelva a compilar SÓLO en esta ejecución.
--Ejecuta también el procedimiento para los socios 1001 y 3388.
--8.1. A partir del código del procedimiento spu_socio_moroso crea otro de nombre spu_socio_moroso_v2
--para que ahora el mensaje informativo (El socio…) se muestre fuera del procedimiento almacenado.
--Crea el procedimiento de tal manera que se vuelva a compilar cada vez que se ejecute.
--Ejecuta el procedimiento para los socios 1000 y 1001.
--8.2. Realiza la instrucción que marca el procedimiento spu_socio_moroso para que se compile la siguiente
--vez que se ejecute.
--8.3. Ejecuta la instrucción que me muestra el código fuente del procedimiento almacenado
--spu_socio_moroso.
--8.4. Realiza la instrucción o instrucciones necesarias para que el código del procedimiento
--spu_socio_moroso que ya has creado no pueda ser visto por los usuarios.
--8.5. Usando cursores y la/s llamada/s al procedimiento almacenado ya creado spu_socio_moroso_v2,
--realiza el código que nos muestre de cada socio de la BD SOCIOS el mensaje que le corresponda según deba
--o no actividades.
--La información de los socios aparecerá por orden alfabético de sus apellidos y nombre.