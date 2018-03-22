
# [Spanish]

# PersistenceNode

Plugin para almacenar datos de forma persistente en Godot Engine 3 por medio de un nodo llamado Persistence

## Instalar
1) Descargar el plugin
2) Descomprimir
3) Crear una carpeta addons en la raíz de tu proyecto (si es que esta no existe)
4) Copiar la carpeta "PersistenceNode" (que esta en la carpeta descargada) a dentro de la carpeta addons creada en el paso 3.
5) Activar el plugin en: Proyecto>Ajustes del proyecto>Plugins

### Opcional
1) Crear una escena y añadir como nodo raíz Persistence
2) Agregar esa escena al autoload (Proyecto>Ajustes del proyecto>AutoLoad)

## Información

Este plugin añade un nodo adicional el cuál puede almacenar información de forma persistente en disco. Ya sea en un archivo .txt en formato json o también en un archivo encriptado con un password con la extención .save.

El archivo genera una carpeta adicional normalmente llamada PersistenceNode (se puede cambiar el nombre), la cual contiene todos los datos de los distintos profiles que se pueden crear.

Como el plugin tine dos modos de almacenar en disco los datos, usted puede cambiar esos modos. Y el modo texto, si tiene activado el beautifier, puede ver el json en la salida.

> Tome en cuenta que el código del json_beautifier es de otra autoría y esta bajo la licencia MPL 2.

También si usted lo prefiere puede añadir este plugin como autoload, para poder acceder de forma más rápida y en cualquier momento para almacenar o cargar datos del disco.

El flujo normal de trabajo con este plugin es primero añadir, el nodo a una escena (puede ser nodo raíz) y luego añadir la escena al autoload. Depués puede utilizar el nodo de la siguiente forma (En el caso que le haya llamado Persistence a la escena):

```GDScript
# Carga la data por defecto si es que existe data
Persistence.load_data()
# Carga la data por defecto y la devuelve
var data = Persistence.get_data() 

# Se puede editar los datos para luego guardarlos
data["NuevosDato"] = "Guardo Este String"
# Se pueden guardar diccionarios
data["GuardoUnDiccionario"] = {
    Dato1 = "1",
    Dato2 = 2
}

# No te olvides de guardar en disco
Persistence.save_data()
```

En el caso de usar profiles sería muy similar:

```GDScript
# Carga la data por defecto si es que existe data
Persistence.load_data("MiProfile")
# Carga la data por defecto y la devuelve
var data = Persistence.get_data("MiProfile") 

# Se puede editar los datos para luego guardarlos
data["NuevosDato"] = "Guardo Este String"
# Se pueden guardar diccionarios
data["GuardoUnDiccionario"] = {
    Dato1 = "1",
    Dato2 = 2
}

# No te olvides de guardar en disco
Persistence.save_data("MiProfile")
```

## Métodos públicos

```GDScript
# Salva el juego con el profile indicado en el parámetro profile_name. 
# Si no hay profile crea un profile por defecto llamado default. 
func save_data(profile_name = null):

# Carga la data, si no se le pasa ningún argumento entonces carga la data
# por defecto, si se le pasa argumento entonces carga la data indicada en el.
# Devuelve true si se carga exitosamente y false si no lo hace.
func load_data(profile_name = null):

# Remueve el profile indicado como argumento. Tome en cuenta que para
# eliminar el encriptado o el texto, debe establecer primero el modo
# con set_mode().
func remove_profile(profile_name):

# Remueve toda la data dentro de la carpeta "folder_name" sin importar
# si esta encriptada o no.
func remove_all_data():

# Setters/Getters
#

# MODE_TEXT : Guarda la data en texto en formato json
# MODE_ENCRYPTED : Guarda la data de forma encriptada
func set_mode(_mode):

func get_mode():

# Se obtiene la data, esta data puede ser modificada para luego ser guardada
# con save_data(). Si esta usando profiles, no olvide indicarle el profile.
func get_data(profile_name = null):

# Retorna los perfiles existentes
func get_profiles():

# Retorna los nombres no validos
func get_no_valid_names():

func set_password(_password):

func get_password():

func set_folder_name(_folder_name):
	
func get_folder_name():

func set_debug(_debug):
	
func get_debug():

func set_beautifier_active(_beautifier_active):
	
func get_beautifier_active():
	
func set_profile_name_min_size(_profile_name_min_size):
	
func get_profile_name_min_size():
	
func set_profile_name_max_size(_profile_name_max_size):
	
func get_profile_name_max_size():
```

## Video

[Curso Godot 3 - Cap 15 - Usar un plugin de persistencia para almacenar datos](https://youtu.be/d9wCyEo3R4A)










