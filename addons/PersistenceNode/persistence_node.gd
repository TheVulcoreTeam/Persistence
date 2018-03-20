tool
extends Node

enum Mode {MODE_ENCRYPTED, MODE_TEXT}
export (Mode) var mode = MODE_ENCRYPTED setget set_mode, get_mode
export (String) var password = ""
export (String) var folder_name = "PersistenceNode"
export (Array) var no_valid_names = ["default", "example"] setget , get_no_valid_names
export (bool) var debug = false

# Data del profile actual, esta data se puede modificar y luego usar
# save_data()
var data = {"test":{"test2":"test3"}} setget , get_data
var current_profile setget set_current_profile, get_current_profile

# Source: https://github.com/YeldhamDev/json-beautifier-for-godot
var beautifier
export (bool) var beautifier_active = false

func _init():
	if beautifier_active:
		beautifier = load("./json_beautifier.gd").new()

func _ready():
	var dir = Directory.new()
	
	if not dir.dir_exists(str("user://" + folder_name)):
		dir.make_dir(str("user://" + folder_name))
		if debug: print("[PersistenceNode] Se a creado la carpeta ", folder_name)

# Métodos públicos
#

# Salva el juego con el profile por defecto. Si no hay profile o no se logra
# guardar la data devuelve false; si se logra guardar la data devuelve true.
func save_data(profile = null):
	if profile == null:
		# Crea el profile por defecto, en el caso de que no se quiera
		# utilizar profiles.
		create_profile_default()

# Crea un perfil nuevo, si el perfil existe devuelve false; si el perfil
# se crea exitosamente devuelve true.
func create_profile(profile_name):
	var file = File.new()
	
	if validate_profile(profile_name):
		match mode:
			MODE_ENCRYPTED:
				create_profile_encripted(profile_name)
			MODE_TEXT:
				create_profile_text(profile_name)
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

# Retorna los nombres no validos
func get_no_valid_names():
	return no_valid_names

func set_current_profile(_current_profile):
	current_profile = _current_profile
	
func get_current_profile():
	return current_profile

# Métodos "privados"
#

# TODO: Valida:
# 1) El nombre no puede estar repetido
# 2) No puede tener nombres no validos según no_valid_names[]
func validate_profile(profile_name):
	return true # TODO ...
	pass
	
func create_default_profile():
	match mode:
		MODE_ENCRYPTED:
			create_profile_encripted("default")
		MODE_TEXT:
			create_profile_text("default")
		
func create_profile_encripted(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".bin")
	
	var file = File.new()
	var err = file.open_encrypted_with_pass(file_path, File.WRITE, password)
	
	if err == OK:
		file.store_var(data)
	else:
		if debug: print("[PersistenceNode] Error al crear el archivo: ", err)
	
func create_profile_text(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".txt")
	
	var file = File.new()
	var err = file.open(file_path, File.WRITE_READ)
	
	if err == OK:
		file.store_string(to_json(data))
		
		if beautifier_active:
			print_json(data)
	else:
		if debug: print("[PersistenceNode] Error al crear el archivo: ", err)
	
func print_json(json):
	if beautifier != null:
		beautifier.beautify_json(to_json(json))
	
	
	
	
	
	
	
	
	
	
	