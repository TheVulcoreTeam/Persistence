![Persistence](https://github.com/MatiasVME/Persistence/blob/master/hardisk_original.png)

# [English] (power by www.deepl.com/translator)

# PersistenceNode

Plugin to persistently store data in Godot Engine 3 through a node called Persistence

## Install
1) Download the plugin
2) Decompress
3) Create an addons folder in the root of your project (if it doesn't exist)
4) Copy the "PersistenceNode" folder (which is in the downloaded folder) into the addons folder created in step 3.
5) Activate the plugin at: Project>Project Settings>Plugins

#### Optional
1) Create a scene and add Persistence as root node
2) Add that scene to the autoload (Project>Project Settings>AutoLoad)

#### Through the editor
1) Just select the addons folder to download
2) Activate the plugin at: Project>Project Settings>Plugins

## Information

This plugin adds an additional node which can persistently store information on disk. Either in a.txt file in json format or in an encrypted file with a password with the.save extension.

The file generates an additional folder usually called PersistenceNode (you can rename it), which contains all the data of the different profiles you can create.

Since the plugin has two ways to store data on disk, you can change those ways. And the text mode, if you have the beautifier activated, you can see the json on the output.

Note that the json_beautifier code is of another authorship and is under the MPL 2 license.

Encrypted mode stores the information in a.save file and text mode stores the information in a.txt file. When you change the mode, the data of the files is not transferred to the other file, for example: The data of.txt is not transferred to.save.

Also if you prefer you can add the Persistence node as an autoload, to be able to access faster and at any time to store or load data from disk.

The normal workflow with this plugin is to first add the node to a scene (it can be a root node) and then add the scene to the autoload. You can then use the node as follows (if you have called the scene Persistence):

```GDScript
# Loads the default data and returns it
var data = Persistence.get_data() 

# Data can be edited and then saved
data["NuevosDato"] = "Guardo Este String"
# Dictionaries can be saved
data["GuardoUnDiccionario"] = {
    Dato1 = "1",
    Dato2 = 2
}

# Don't forget to save to disk
Persistence.save_data()
```

In the case of using profiles it would be very similar:

```GDScript
# Loads the default data and returns it
var data = Persistence.get_data("MiProfile") 

# Data can be edited and then saved
data["NuevosDato"] = "Guardo Este String"
# Dictionaries can be saved
data["GuardoUnDiccionario"] = {
    Dato1 = "1",
    Dato2 = 2
}

# Don't forget to save to disk
Persistence.save_data("MiProfile")
```

## Public methods

```GDScript
# Save the game with the profile specified in the profile_name parameter. 
# If there is no profile create a default profile called default.
func save_data(profile_name = null):

# Removes the profile indicated as the argument. Note that to remove the 
# encryption or text, you must first set the mode with set_mode().
func remove_profile(profile_name):

# Remove all data inside the folder "folder_name" regardless of whether 
# it is encrypted or not.
func remove_all_data():

# Setters/Getters
#

# MODE_TEXT : Saves the data in text in json format
# MODE_ENCRYPTED : Encrypted data storage
func set_mode(_mode):

func get_mode():

# The data is obtained, this data can be modified and then saved with save_data(). 
# If you are using profiles, do not forget to indicate the profile.
func get_data(profile_name = null):

# Returns the existing profiles, by default it returns them without extension.
func get_profiles(with_extension = false):

# Returns the not valid names.
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

## Considerations

* Do not use the plugin's private methods, the plugin may not work properly when using them.
* If you use profiles to store data with Persistence.save_data(my_profile), to get that data, you must use Persistence.get_data(my_profile).
* If you do not use profile, a file called "default" is generated. In encrypted mode it is default.save and in text mode it is default.txt.

## Tips

* If you create a Persistence scene and add the Persistence node as root, and then save it in the autoload. You can access the Persistence scene from anywhere in the project.
* It is not necessary to create a data saving and loading system, it is already created with this plugin. You should only save the data as in the first examples above.

## Video in Spanish

[Curso Godot 3 - Cap 15 - Usar un plugin de persistencia para almacenar datos](https://youtu.be/d9wCyEo3R4A)


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

### Por medio del editor
1) Solo seleccione la carpeta addons para descargar
2) Activar el plugin en: Proyecto>Ajustes del proyecto>Plugins

## Información

Este plugin añade un nodo adicional el cuál puede almacenar información de forma persistente en disco. Ya sea en un archivo .txt en formato json o también en un archivo encriptado con un password con la extención .save.

El archivo genera una carpeta adicional normalmente llamada PersistenceNode (se puede cambiar el nombre), la cual contiene todos los datos de los distintos profiles que se pueden crear.

Como el plugin tine dos modos de almacenar en disco los datos, usted puede cambiar esos modos. Y el modo texto, si tiene activado el beautifier, puede ver el json en la salida.

> Tome en cuenta que el código del json_beautifier es de otra autoría y esta bajo la licencia MPL 2.

El modo encriptado almacena la información en un archivo .save y el modo texto almacena la información en un archivo .txt. Al cambiar de modo la data de los archivos no se traspasa al otro fichero, por ejemplo: De los datos de .txt no se traspasan a .save.

También si usted lo prefiere puede añadir el nodo Persistence como autoload, para poder acceder de forma más rápida y en cualquier momento para almacenar o cargar datos del disco.

El flujo normal de trabajo con este plugin es primero añadir, el nodo a una escena (puede ser nodo raíz) y luego añadir la escena al autoload. Depués puede utilizar el nodo de la siguiente forma (En el caso que le haya llamado Persistence a la escena):

```GDScript
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

# Retorna los perfiles existentes, por defecto los devuelve sin
# extension.
func get_profiles(with_extension = false):

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

## Consideraciones

* No use los métodos privados del plugin, puede que el plugin no funcione correctamente al utilizarlos.
* Si usa profiles para almacenar la data con Persistence.save_data(my_profile), para obtener esa data, debe de hacerlo con Persistence.get_data(my_profile).
* Si no utiliza profile se genera un archivo llamado default. En modo encriptado es default.save y en modo texto es default.txt.

## Tips

* Si crea una escena Persistence y le añade el nodo Persistence como raiz, y luego lo guarda en el autoload. Podrá acceder a la escena Persistence desde cualquier parte del proyecto.
* No es necesario crear un sistema de guardado y carga de data, ya esta creado con este plugin. Solo debe guardar la data como en los primeros ejemplos de arriba.

## Video en español

[Curso Godot 3 - Cap 15 - Usar un plugin de persistencia para almacenar datos](https://youtu.be/d9wCyEo3R4A)
