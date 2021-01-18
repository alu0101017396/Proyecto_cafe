# Proyecto_cafe

La cadena de restaurantes de nombre “C.A.F.E”, la cual debido a su crecimiento empieza a necesitar hacer uso de una base de datos para organizar sus activos así como llevar el control de sus diferentes establecimientos, de su personal, diferentes menús, stock en tiendas, clientes y pedidos. 

Cada establecimiento será registrado dentro de la base de datos, con su dirección, el gerente que está a cargo, el estado del stock actual y el inventario propio perteneciente a cada uno de estos.

Estos disponen de tres tipos de personal: camareros, cocineros y gerentes. Este último se encargará de llevar al día el inventario e ir registrando dentro de la base de datos el nuevo stock según vaya llegando. Además, se requiere el uso de cada empleado registre la hora de entrada y de salida a través de una tarjeta electrónica que debe ticar.

Por otro lado, a medida que el cliente consuma en el establecimiento se generará un pedido dentro de la base de datos de un menú que previamente estará registrado en la misma. También se debe guardar en el registro si el pedido se ha ordenado a domicilio, y en dicho caso, se interesa guardar tanto el número de teléfono del cliente como la dirección de su vivienda.

Se debe también contemplar que los clientes pueden ser afiliados o no, y en caso de estos serlos hacerles un seguimiento con un sistema de puntos para posibles descuentos.

Se quiere almacenar los diferentes tipos de menú, así como sus costos, sus ingredientes alergénicos y sus platos.

También se quiere tener constancia de las reclamaciones y las valoraciones que tienen los clientes. Se pretende almacenar fecha y hora una de estas, el establecimiento en la que fue añadida y la persona que atendió a dicho cliente. En caso de que se dejará una reclamación, se pretende guardar también el motivo de esta.

## Documentos del proyecto

### ERE - Modelo Entidad Relacion Extendido

En este documento se establece el modelo entidad relacion del proyecto. Dentro de el se encuentra el esquema E/R, asi mismo una descripcion de una explicacion de cada entidad y de cada relacion (con cardinalidad) y los atributos que dispone cada uno si es que los tiene. 

### Grafo Relacional

En este documento nos encontraremos el Modelo Relacional de la base de datos, dentro del cual podremos ver las diferentes tablas que perteneceran a la base de datos, asi como los atributos y la informacion que guardara.


### CSI8

En este documento figuran las diferentes pruebas que asugaran el correcto funcionamiento de la base de datos asi como sus componenetes.

### ScriptCreacion

En este documento se ve reflejado los diferentes scripts o sentencias que generaran de forma automatica el esquema de la base de datos de C.A.F.E

## Scripts de la Base de Datos

### [Crear_tablas](https://github.com/alu0101017396/Proyecto_cafe/tree/main/Crear_Tablas)

Scripts SQL que genraran las diferentes tablas de la base de datos

### [Datos_Insertados](https://github.com/alu0101017396/Proyecto_cafe/tree/main/Datos_insertados)

Scripts para insertar informacion dentro de la base de datos.

### [Triggers](https://github.com/alu0101017396/Proyecto_cafe/tree/main/Trigger)

Scripts de los disparadores (triggers) de la base de datos.
