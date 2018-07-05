# Ambiente de desarrollo
Este proyecto consta de una serie de scripts para levantar un servidor virtual con una configuracion no monolitica, la idea es que los desarrolladores empiecen a pensar en que sus desarrollos no van a ir enfocados a un solo nodo, si no a multiples, especialmente en empresas grandes donde su infraestructura es mas robusta.

## Requerimientos

Para usar este proyecto es necesario tener instalado lo siguiente:

* virtualbox
* vagrant
* putty (en caso de estar usando windows)
* Git Command Line

Para hacer accesibles las paginas publicadas por el servidor virtual, necesitamos poner 
las siguientes lineas en el archivo hosts (/etc/hosts en linux y mac, 
C:\windows\system32\drivers\etc\hosts para windows )

    192.168.100.10 odoo.local.com

## Modo de uso
Una vez que tenemos la configuración correcta podemos manipular el servidor virtual desde la linea de comandos
con los siguientes comandos

### Iniciar el servidor:
    
    vagrant  up
    
La primera vez que se usa este comando, vagrant genera y configura el servidor virtual,
por lo que es probable que se tarde varios minutos.   

### Detener el servidor:

    vagrant halt 

### Ingresar al servidor:

    vagrant ssh

### Aplicar cambios en los archivos de configuración

    vagrant reload --provision
    
Esto se hará cada vez que hagamos una corrección en los scripts de este proyecto para
que los servidores de cada uno tome los cambios, obvio habrá que hacer un "git pull"  previamente. 
  
### Destruir la maquina

    vagrant destroy
    
Esta instrucción destruye el servidor virtual y debe ser usada con cuidado, 
es útil en el caso de que se desee liberar espacio en disco, cuando ya no se ocupe más
el servidor, o en caso de querer iniciar con un servidor limpio.
    
Los datos en las carpetas de los proyectos no se ven afectados.
    
Si después de ejecutar este comando ejecutamos una vez mas vagrant up, 
la maquina se volverá a generar desde cero.

## Conectar carpetas.
Para poder uso de las bondades deberás de configurar los puntos de montaje en el Vagrantfile,
Por favor contacta conmigo si necesitas que esto pase


# Cualquier otra duda o problema, pueden contactarme para revisarlo y corregirlo.
@author Ricardo Ruiz Cruz <ricardo.ruiz@benandfrank.com>