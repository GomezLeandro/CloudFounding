# cloudfunding
Parcial hecho totalmente en xtend, usando paradigma de objetos e implementando distintos patrones de diseño, como por ejemplo strategy, compousite, command pattern, template method, observers y adaptador... también se realizo un ABM con una clase generica.
## Descripcion
Tenemos inversores que no saben qué hacer con tanta plata, entonces nos pidieron que les digamos en qué proyectos les conviene invertir, para lo cual realizan el siguiente proceso periódico.

Inicio del proceso
El usuario inicia el proceso pidiendo que el sistema le muestre las sugerencias para este período. El sistema ejecuta la fase de 1. selección de proyectos y 2. distribución de dinero posible.

Para elegirlos tenemos diferentes ideas:
●	tomar los 3 proyectos con más impacto social
●	elegir el proyecto que más plata necesita y el que menos
●	elegir únicamente proyectos nacionales
●	una combinatoria de las anteriores (OR)

El proceso necesita que haya al menos dos proyectos elegibles, en caso contrario el proceso no puede continuar. 

A su vez la forma de distribuir el dinero también puede variar:
●	partes iguales para cada proyecto
●	distribuir el 50% en el primer proyecto, y en partes iguales el resto
●	invertir 500 mangos en un proyecto al azar, y el resto en otro proyecto al azar (recordemos que el mínimo que requiere el proceso son 1.000 mangos pero no necesariamente 1.000)

La interfaz de usuario está fuera del alcance del examen, pero sí sabemos que el sistema le muestra
●	los proyectos seleccionados en cada propuesta
●	las variantes de distribución
de las cuales la persona inversora seleccionará una sola propuesta y una variante de distribución. También debe ingresar la cantidad de dinero a invertir: el mínimo son 1.000 mangos  y confirmar la operación.

Queremos que sea fácil incorporar nuevas ideas a futuro, tanto para elegir los proyectos como para distribuir el dinero.

Sobre los proyectos
Cada proyecto define un nombre, una breve descripción en lo que consiste, la cantidad de plata que necesita para llevarse a cabo, los datos bancarios de la cuenta, las personas responsables del proyecto (nombres y direcciones de correo) y el origen (Nacional o Extranjero). Existen distintos tipos de proyectos:
●	sociales: tienen una fecha de inicio
●	cooperativas: dirigida por un conjunto de socios del cual conocemos sus apellidos.
●	ecológicos: se circunscriben a un área determinada (medida en metros cuadrados)

El impacto social se mide en puntos de la siguiente manera:
●	para todos los proyectos es un 10% de la cantidad de plata que necesita para llevarse a cabo, a lo que se suma
●	en el caso de los proyectos sociales, 100 puntos por cada año desde su inicio. Por ejemplo, un proyecto que inició el 14/12/2017 tiene actualmente 3 años, serían 300 puntos a junio del 2021 (no se cuenta el año que está transcurriendo).
●	en el caso de las cooperativas, son 45 puntos por cada socio que tiene doble apellido ó 30 en caso contrario.
●	en el caso de los proyectos ecológicos, son los metros cuadrados * 10.

Los proyectos son de un único tipo a lo largo de todo su ciclo de vida.

Confirmación de la inversión
Cuando el inversor elige una de las alternativas para elegir y para distribuir el dinero, debemos llamar a un sistema bancario para realizar la transferencia, uno por cada proyecto. Este sistema externo tiene la siguiente interfaz:

String transferir(String cuentaOrigenId, String cuentaDestinoId, int montoEntero, int montoDecimales, boolean depositoInmediato, boolean deposito24hs)

●	la transferencia devuelve un String vacío si todo funcionó ok o un mensaje de error en caso contrario
●	en caso de transferir 3855,50 pesos debemos indicar montoEntero = 3855 y montoDecimales = 50
●	siempre va depositoInmediato y nunca inInmediato 24 hs.

Si la transferencia falla, el proceso no puede continuar. Por cada transferencia exitosamente acreditada el inversor debe restar el dinero que tiene en la cuenta y registrar cada transferencia nueva al proyecto en cuestión. Además:
●	si el monto transferido es mayor a 2.500 mangos, se debe enviar un whatsapp al inversor, avisando el monto invertido y el proyecto involucrado
●	debe enviarse un mail a todas las personas responsables del proyecto (tenemos sus mails) para que tomen nota de la transferencia
●	si el proyecto sumó su tercera donación, automáticamente debe pasar a estar inactivo por precaución (no debe poder ser elegido la próxima vez que ejecute el proceso)

