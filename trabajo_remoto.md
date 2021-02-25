% Trabajo remoto en los equipos de los laboratorios L1.02 y L0.04
% Jesús Alastruey Benedé, Natalia Ayuso Escuer y José Antonio Gutiérrez Elipe  
  Departamento de Informática e Ingeniería de Sistemas  
  Escuela de Ingeniería y Arquitectura  
  Universidad de Zaragoza
% 27-octubre-2020


## Resumen

Instrucciones para trabajo remoto en los equipos de los laboratorios L1.02 y L0.04.
Incluye procedimiento y datos para encendido remoto de sistemas.

## 1. Identificación de equipos encendidos

El primer lugar hay que identificar los equipos que están encendidos.
Para el laboratorio L1.02, esta tarea puede realizarse ejecutando la siguiente orden en `central.cps.unizar.es`:

        $ lab102.sh

Para el laboratorio L0.04, esta tarea puede realizarse ejecutando la siguiente orden en `hendrix.cps.unizar.es`:

        $ lab004.sh

Cada uno de estos scripts genera una lista con las direcciones IP y SO de las máquinas que están arrancadas en el L1.02 y en el L0.04 respectivamente.
Cuidado, si se ejecuta en una máquina externa a la Universidad de Zaragoza,
el cortafuegos perimetral puede entender dicha actividad como maliciosa y
bloquear nuestra dirección IP durante algunas horas,
impidiendo el establecimiento de conexiones con cualquier máquina del dominio `unizar.es`. 
Por tanto, se desaconseja su uso desde equipos que no pertenecen a la red `unizar.es`.


## 2. Encendido remoto de sistemas

En caso de que no haya equipos disponibles, habrá que encender alguno.

Wake on LAN es un estándar que permite el encendido de equipos de forma remota [1][2].
Cuando la tarjeta de red, que está en un modo de escucha de bajo consumo, 
recibe un paquete especial, activa una señal para iniciar el encendido del sistema.
El envío de estos paquetes puede realizarse con programas como `wakeonlan` o `powerwake`.

### 2.1. Laboratorio L1.02

Los equipos del L1.02 pueden encenderse remotamente desde el servidor `central.cps.unizar.es`.
Para ello, una forma sencilla es conectarse por ssh a dicho servidor y ejecutar:

        $ /usr/local/etc/wake -y nombre

Por ejemplo, la orden:

        $ /usr/local/etc/wake -y lab102-210

enciende el equipo lab102-210.cps.unizar.es.

Los profesores pueden encender con una orden todos los equipos del laboratorio:

        $ /usr/local/etc/wake -y all

En el anexo A está el listado de los nombres y direcciones IP de los equipos del L1.02.

Una forma más elaborada permite realizar el encendido remoto mediante la ejecución de un comando en nuestro sistema.
Dicho comando realiza el encendido remoto mediante la ejecución remota de un script en `central`.
En `central` copiaremos el siguiente script que llamaremos `wake_lab1.02.sh`:

        #!/bin/bash
        if [ "$#" -eq 0 ]; then
            remote=lab102-200
        else
            remote=$1
        fi
        /usr/local/etc/wake -y $remote

Para ejecutar este script de forma remota desde nuestra máquina local:

        $ ssh aNIP@central.cps.unizar.es "./wake_lab1.02.sh lab102-xxx"

Esta orden se puede guardar a su vez en un script local.


### 2.2. Laboratorio L0.04

Los equipos del L0.04 pueden encenderse remotamente desde el servidor `hendrix.cps.unizar.es`
de forma equivalente a la descrita en la subsección anterior:

        $ /usr/local/etc/wake -y nombre

Por ejemplo, la orden:

        $ /usr/local/etc/wake -y lab004-090

enciende el equipo lab004-090.cps.unizar.es.

Los profesores pueden encender con una orden todos los equipos del laboratorio:

        $ /usr/local/etc/wake -y all

En el anexo B está el listado de los nombres y direcciones IP de los equipos del L0.04.

Puede realizarse el encendido remoto mediante la ejecución de un comando en nuestro sistema local.
Ver instrucciones en la subsección anterior.


## 3. Trabajo remoto

### 3.1. Inicio de sesión

Una vez encendida la máquina, podemos conectarnos a ella.
Si usamos un sistema Linux o macOS, ejecutar en un terminal:

        $ ssh -Y aNIP@lab102-xxx.cps.unizar.es
        
siendo: `NIP` nuestro identificador de usuario y `lab102-xxx` el nombre
de la máquina a la que nos queremos conectar. Por ejemplo:

        $ ssh -Y a123456@lab102-200.cps.unizar.es

La opción `-Y` habilita la redirección X11, es decir, permitirá la conexión
de una aplicación remota con interfaz gráfica a un servidor X11 en nuestra máquina local.
Es decir, se podrá visualizar en nuestra máquina local el interfaz gráfico de una aplicación
que se está ejecutando en una máquina del L1.02.
En el caso de trabajar en un sistema macOS, hay que instalar un servidor X11.
Consultar el anexo C para más información.

En un sistema Windows, pueden usarse programas como por ejemplo putty.
La redirección X11 se habilita a través de una opción de configuración
(_Connection->SSH->X11_).

A menos que se realice la conexión a los sistemas de la Universidad de Zaragoza a través del servicio VPN [3],
el acceso a los equipos del laboratorio L0.04 tendrá que realizarse a través de una máquina intermedia,
como por ejemplo, `hendrix.cps.unizar.es`.
Por ejemplo:

        $ ssh -Y aNIP@hendrix.cps.unizar.es
        Terminal type? xterm
        $ ssh -X aNIP@lab004-072.cps.unizar.es


### 3.2. Edición de ficheros en una máquina remota

Generalmente, el trabajo suele requerir la edición remota de ficheros.
Se recomienda el uso de `vi`, por ser un editor de texto presente en la mayoría de sistemas.

        $ vi fichero

Si se dispone de una buena conexión, puede usarse algún editor con interfaz gráfico, por ejemplo:

        $ geany fichero
        $ gedit fichero

El Anexo C detalla cómo habilitar la redirección X11 a sistemas Linux, macOS y Windows.


### 3.3. Problemas frecuentes

- Si hemos excedido la cuota de disco, es decir, el espacio de almacenamiento que tenemos asignado,
pueden producirse diversos problemas. Por ejemplo, al lanzar una aplicación gráfica:

        $ xeyes
        X11 rejected because of wrong authentication
        (xeyes:pid): Gtk-WARNING **: current time: cannot open display:dir_IP:0.0

    El procedimiento a seguir para poder liberar espacio en disco está detallado en:
    
    <http://diis.unizar.es/WebEst/hendrix/#quota>
    
- En raras ocasiones hay problemas con la cuenta de usuario. Si los problemas relacionados con tu cuentan persisten, deberás contactar con el administrador del sistema:
    <spd@daphne.cps.unizar.es>


## 4. Apagado remoto de sistemas

Solamente los estudiantes y PDI pertenecientes al grupo ´vmu´
tienen permisos para apagar los equipos del L1.02.
Para ello, conectarse por ssh a `central.cps.unizar.es` y ejecutar:

        $ /usr/local/etc/shutdown.sh -y nombre

Por ejemplo, la orden:

        $ /usr/local/etc/shutdown.sh -y lab102-210

apaga el equipo lab102-210.cps.unizar.es.



## Anexo A. Listado de nombres y direcciones IP del L1.02

|   nombre   |   dirección IP  |
|:----------:|:---------------:|
| lab102-191 | 155.210.154.191 |
| lab102-192 | 155.210.154.192 |
| lab102-193 | 155.210.154.193 |
| lab102-194 | 155.210.154.194 |
| lab102-195 | 155.210.154.195 |
| lab102-196 | 155.210.154.196 | 
| lab102-197 | 155.210.154.197 |
| lab102-198 | 155.210.154.198 |
| lab102-199 | 155.210.154.199 | 
| lab102-200 | 155.210.154.200 |
| lab102-201 | 155.210.154.201 |
| lab102-202 | 155.210.154.202 |
| lab102-203 | 155.210.154.203 |
| lab102-204 | 155.210.154.204 |
| lab102-205 | 155.210.154.205 |
| lab102-206 | 155.210.154.206 |
| lab102-207 | 155.210.154.207 |
| lab102-208 | 155.210.154.208 |
| lab102-209 | 155.210.154.209 |
| lab102-210 | 155.210.154.210 |


## Anexo B. Listado de nombres y direcciones IP del L0.04

|   nombre   |  dirección IP |
|:----------:|:-------------:|
| lab004-071 |  10.3.17.71   |
| lab004-072 |  10.3.17.72   |
| lab004-073 |  10.3.17.73   |
| lab004-074 |  10.3.17.74   |
| lab004-075 |  10.3.17.75   |
| lab004-076 |  10.3.17.76   |
| lab004-077 |  10.3.17.77   |
| lab004-078 |  10.3.17.78   |
| lab004-079 |  10.3.17.79   |
| lab004-080 |  10.3.17.80   |
| lab004-081 |  10.3.17.81   |
| lab004-082 |  10.3.17.82   |
| lab004-083 |  10.3.17.83   |
| lab004-084 |  10.3.17.84   |
| lab004-085 |  10.3.17.85   |
| lab004-086 |  10.3.17.86   |
| lab004-087 |  10.3.17.87   |
| lab004-088 |  10.3.17.88   |
| lab004-089 |  10.3.17.89   |
| lab004-090 |  10.3.17.90   |
| lab004-091 |  10.3.17.91   |
| lab004-092 |  10.3.17.92   |
| lab004-093 |  10.3.17.93   |
| lab004-094 |  10.3.17.94   |
| lab004-095 |  10.3.17.95   |
| lab004-096 |  10.3.17.96   |
| lab004-097 |  10.3.17.97   |
| lab004-098 |  10.3.17.98   |
| lab004-099 |  10.3.17.99   |
| lab004-100 |  10.3.17.100  |


## Anexo C. Redirección de X11

Es necesario que se ejecute un servidor X11 en nuestra máquina local para visualizar
la interfaz gráfica de una aplicación que hemos lanzado en una máquina del L1.02.

Si la redirección X11 no está habilitada, la máquina remota así nos lo indicará tras el saludo inicial:
        
        Warning using ssh w/o X11 fwd
        
Y si se lanza una aplicación con interfaz gráfica, nos enviará un mensaje de error indicando que no se puede conectar a un servidor X11.
Por ejemplo, para un sistema Linux:

        $ xeyes
        Error: can't open display:dir_IP:0.0
        
- Y para sistemas macOS/Windows:

        $ xeyes
        (xeyes:pid): Gtk-WARNING **: current time: cannot open display:dir_IP:0.0


En el caso de Linux, este servidor suele venir instalado para las distribuciones más habituales
(CentOS, Ubuntu, Debian ...), por lo que no hay que instalar nada.
En el caso de conexión mediante ssh, basta con especificar la opción `-Y` para habilitar la redirección X11.
        
Para macOS y Windows hay que instalar un servidor X11, por ejemplo, XQuartz [4] para macOS y XMing [5] para Windows.

### Redirección de X11 a un sistema Windows

1.  Configurar X-ming

    Una vez instalado Xming, lanzar la aplicación `XLaunch` y verificar que se han seleccionado las siguientes opciones de configuración:

    - Display Settings: multiple windows
    - Session type: start no client
    - Additional parameters: Clip board

    Guardar la configuración y cerrar XLaunch.

2.  Configurar PuTTy

    Para la sesión con la máquina remota deseada,
    la redirección X11 se habilita a través de la siguiente opción de configuración:

    Connection->SSH->X11->Enable X11 Forwarding


## Anexo D. Acerca de este documento

Para la edición de este documento se ha utilizado Markdown [6].
El fuente puede encontrarse en el siguiente enlace:

<http://webdiis.unizar.es/~chus/docencia/trabajo_remoto/trabajo_remoto.md>

Las conversiones a formato pdf y HTML se han realizado con Pandoc [7].
La orden usada para generar el fichero pdf es:

        $ pandoc  -f markdown  -V papersize=A4  \
        -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" \
        trabajo_remoto.md --latex-engine=pdflatex -o trabajo_remoto.pdf

Y para generar salida en formato HTML:
    
        $ pandoc  -f markdown  -s trabajo_remoto.md -o trabajo_remoto.html

Si se quiere utilizar una hoja de estilo:

        $ pandoc  -f markdown  -s --css=css_template  trabajo_remoto.md -o trabajo_remoto.html 



## Referencias

[1] WakeOnLan in Debian systems. Fecha de consulta: 8-octubre-2020. Disponible en <https://wiki.debian.org/WakeOnLan>

[2] WakeOnLan in Ubuntu systems. Fecha de consulta: 8-octubre-2020. Disponible en <https://help.ubuntu.com/community/WakeOnLan>

[3] Conexion VPN. Fecha de consulta: 25-octubre-2020. Disponible en <https://sicuz.unizar.es/comunicaciones/vpn/conexi%C3%B3n-vpn-inicio>

[4] XQuartz project. Fecha de consulta: 8-octubre-2020. Disponible en <https://www.xquartz.org/>

[5] Xming X Server for Windows. Fecha de consulta: 8-octubre-2020. Disponible en <https://sourceforge.net/projects/xming/>

[6] Daring Fireball. Markdown syntax. Fecha de consulta: 8-octubre-2020. Disponible en <https://daringfireball.net/projects/markdown/>

[7] Pandoc: a universal document converter. Fecha de consulta: 8-octubre-2020. Disponible en <http://pandoc.org/>
