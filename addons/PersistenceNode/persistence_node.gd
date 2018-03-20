tool
extends Node

#export (bool) var autostart = false
export (bool) var debug = false
export (String) var folder_name = "PersistenceNode"

enum Mode {MODE_ENCRYPTED, MODE_TEXT}
export (Mode) var mode = MODE_ENCRYPTED setget set_mode, get_mode

# Data del profile actual, esta data se puede modificar y luego usar
# save_data()
var data = {} setget , get_data

func _ready():
	var dir = Directory.new()
	
	if not dir.dir_exists(str("user://" + folder_name)):
		dir.make_dir(str("user://" + folder_name))
		if debug: print("[PersistenceNode] Se a creado la carpeta ", folder_name)

# Métodos públicos
#

# Salva el juego con el profile por defecto. Si no hay profile o no se logra
# guardar la data devuelve false; si se logra guardar la data devuelve true.
func save_data(profile = ""):
	pass

func create_profile(profile_name):
	pass

func remove_profile(profile_name):
	pass

func load_profile(profile_name):
	pass

func remove_all_data():
	pass

# Setters/Getters
#

# MODE_TEXT : Guarda la data en texto en formato json
# MODE_ENCRYPTED : Guarda la data de forma encriptada
func set_mode(_mode):
#	if Mode.has(_Mode):
#		mode = _Mode
#	else:
#		if debug: print("[PersistenceNode] No existe el modo:", _Mode)
	mode = _mode

func get_mode():
	return mode
	
func get_data():
	return data

# Retorna los perfiles existentes
func get_profiles():
	var dir = Directory.new()
	var profiles = []
	
	if dir.open("user://PersistenceNode/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while (file_name != ""):
			if file_name != "." and file_name != "..":
				profiles.append(file_name)
		
			file_name = dir.get_next()
	else:
		if debug: print("[PersistenceNode] Un error ha ocurrido al intentar entrar al path.")

	return profiles