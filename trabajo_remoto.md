% Trabajo remoto en los equipos del laboratorio L1.02 
% Jesús Alastruey Benedé  
  Área Arquitectura y Tecnología de Computadores  
  Departamento de Informática e Ingeniería de Sistemas  
  Escuela de Ingeniería y Arquitectura  
  Universidad de Zaragoza
% 12-marzo-2019


## Resumen

Instrucciones para trabajo remoto en los equipos del laboratorio L1.02.
Incluye procedimiento y datos para encendido remoto de sistemas.

## 1. Identificación de equipos encendidos

El primer lugar hay que identificar los equipos que están encendidos.
Para el laboratorio 1.02 puede realizarse ejecutando la siguiente orden en `hendrix`:

        $ rcmds -f lab102 -s -- uptime

Puede cambiarse el nombre de laboratorio cuyos equipos se quieren inspeccionar.

En la web de la asignatura se proporciona otro script (`lab102.sh`) que genera una lista
de las direcciones IP y SO de las máquinas que están arrancadas en el L1.02.
Sin embargo, si se ejecuta en una máquina externa a la Universidad, el cortafuegos
perimetral puede entender dicha actividad como maliciosa y bloquear nuestra dirección IP
durante algunas horas, impidiendo el establecimiento de conexiones con cualquier máquina del dominio `unizar.es`. 
Por tanto, se desaconseja su uso desde equipos que no pertenecen a la red `unizar.es`.


## 2. Encendido remoto de sistemas

En caso de que no haya equipos disponibles, habrá que encender alguno.

Wake on LAN es un estándar que permite el encendido de equipos de forma remota.
Cuando la tarjeta de red, que está en un modo de escucha de bajo consumo, 
recibe un paquete especial, activa una señal para iniciar el encendido del sistema.
El envío de estos paquetes puede realizarse con programas como `wakeonlan` o `powerwake`.

Los equipos del laboratorio 1.02 pueden encenderse remotamente desde el servidor `central.cps.unizar.es`.
Para ello, una forma sencilla es conectarse por ssh a dicho servidor y ejecutar:

        $ wakeonlan @MAC

En el anexo A puedes encontrar el listado de direcciones MAC de los equipos del laboratorio 1.02.

Una forma más elaborada permite realizar el encendido remoto mediante la ejecución de un comando en nuestro sistema.
Dicho comando realiza el encendido remoto mediante la ejecución remota de un script en `central`.
En `central` copiaremos el siguiente script que llamaremos `wake_lab1.02.sh`:

        #!/bin/bash
        if [ "$#" -eq 0 ]; then
            remote=00:10:18:80:70:46
            # mac de la ip 155.210.154.200
        else
            remote=$1
        fi
        /usr/local/etc/wakeonlan $remote

Para ejecutar este script de forma remota desde nuestra máquina local:

        $ ssh nip@central.cps.unizar.es "./wake_lab1.02.sh"

Esta orden se puede guardar en un script.


## 3. Apagado remoto de sistemas

Una vez terminado el uso del sistema, se procederá a su apagado:

        $ sudo shutdown

Antes de la ejecución de esta orden hay que verificar que no hay otros usuarios con sesión establecida en el sistema.

        $ who
    
Fuera de horas lectivas, el último usuario activo es el responsable del apagado de la máquina.


## Referencias

<https://wiki.debian.org/WakeOnLan>
<https://help.ubuntu.com/community/WakeOnLan>


## Anexo A: listado de direcciones MAC

| dirección IP    |   dirección MAC   |
|:---------------:|:-----------------:|
| 155.210.154.191 | 00:10:18:80:6B:36 |
| 155.210.154.192 | 00:10:18:80:6E:27 |
| 155.210.154.193 | 00:10:18:80:6E:1F |
| 155.210.154.194 | 00:10:18:80:67:F3 |
| 155.210.154.195 | 00:10:18:80:73:46 |
| 155.210.154.196 | 00:10:18:80:6C:72 | 
| 155.210.154.197 | 00:10:18:80:6E:33 |
| 155.210.154.198 | 00:10:18:80:67:F0 |
| 155.210.154.199 | 00:10:18:80:72:ED | 
| 155.210.154.200 | 00:10:18:80:70:46 |
| 155.210.154.201 | 00:10:18:80:6B:B3 |
| 155.210.154.202 | 00:10:18:80:67:80 |
| 155.210.154.203 | 00:10:18:80:67:83 |
| 155.210.154.204 | 00:10:18:80:6C:6E |
| 155.210.154.205 | 00:10:18:80:67:94 |
| 155.210.154.206 | 00:10:18:80:67:F4 |
| 155.210.154.207 | 00:10:18:80:73:38 |
| 155.210.154.208 | 00:10:18:80:67:84 |



