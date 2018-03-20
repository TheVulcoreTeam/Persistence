# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends Node

enum Mode {MODE_ENCRYPTED, MODE_TEXT}
export (Mode) var mode = MODE_ENCRYPTED setget set_mode, get_mode
export (String) var password = ""
export (String) var folder_name = "PersistenceNode"
export (Array) var no_valid_names = ["default", "example"] setget , get_no_valid_names
export (bool) var debug = false

# Source: https://github.com/YeldhamDev/json-beautifier-for-godot
var beautifier
export (bool) var beautifier_active = true

export (int) var profile_name_min_size = 3
export (int) var profile_name_max_size = 15

# Data del profile actual, esta data se puede modificar y luego usar
# save_data()
var data = {"test":{"test2":"test3"}} setget , get_data
var current_profile setget set_current_profile, get_current_profile

signal saved
signal loaded

func _init():
	if beautifier_active:
		beautifier = load("res://addons/PersistenceNode/json_beautifier.gd").new()
	
func _ready():
	var dir = Directory.new()
	
	if not dir.dir_exists(str("user://" + folder_name)):
		dir.make_dir(str("user://" + folder_name))
		if debug: print("[PersistenceNode] Se a creado la carpeta ", folder_name)

# Métodos públicos
#

# Salva el juego con el profile indicado en el parámetro profile_name. 
# Si no hay profile crea un profile por defecto llamado default. 
func save_data(profile_name = null):
	var result
	
	if profile_name == null:
		# Crea el profile por defecto, en el caso de que no se quiera
		# utilizar profiles.
		save_profile_default()
		return true # TODO: save_profile_default debe de dar el resultado
	
	if validate_profile(profile_name):
		match mode:
			MODE_ENCRYPTED:
				result = save_profile_encripted(profile_name)
			MODE_TEXT:
				result = save_profile_text(profile_name)
	else:
		if debug: print("[PersistenceNode] No ha pasado la validación")
		result = false
	
	if result:
		emit_signal("saved")
	
	return result

# Carga la data, si no se le pasa ningún argumento entonces carga la data
# por defecto, si se le pasa argumento entonces carga la data indicada en el.
# Devuelve true si se carga exitosamente y false si no lo hace.
func load_data(profile_name = null):
	var result
	
	if profile_name == null:
		load_profile_default()
		return true
	
	if validate_profile(profile_name):
		match mode:
			MODE_ENCRYPTED:
				result = load_profile_encripted(profile_name)
			MODE_TEXT:
				result = load_profile_text(profile_name)
	else:
		if debug: print("[PersistenceNode] No ha pasado la validación")
		result = false
	
	if result:
		emit_signal("loaded")
	
	return result

# Remueve el profile indicado como argumento. Tome en cuenta que para
# eliminar el encriptado o el texto, debe establecer primero el modo
# con set_mode().
func remove_profile(profile_name):
	var dir = Directory.new()
	var path
	
	match mode:
		MODE_ENCRYPTED:
			path = "user://" + folder_name + "/" + profile_name + ".bin"
		MODE_TEXT:
			path = "user://" + folder_name + "/" + profile_name + ".txt"
	
	var err = dir.remove(path)
	
	if err != OK:
		if debug: print("[PersistenceNode] Error al remover el profile: ", err)

# Remueve toda la data dentro de la carpeta "folder_name" sin importar
# si esta encriptada o no.
func remove_all_data():
	var dir = Directory.new()
	var profiles = get_profiles()
	
	if profiles != null:
		var path = "user://" + folder_name + "/"
		
		for i in range(profiles.size()):
			dir.remove(str(path + profiles[i]))
	else:
		if debug: print("[PersistenceNode] No se a removido ningún archivo.")
	

# Setters/Getters
#

# MODE_TEXT : Guarda la data en texto en formato json
# MODE_ENCRYPTED : Guarda la data de forma encriptada
func set_mode(_mode):
	mode = _mode

func get_mode():
	return mode
	
func get_data(profile_name = null):
	if profile_name == null:
		load_data()
		return data
	else:
		load_data(profile_name)
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

# Métodos "privados" (No usar)
#

# Valida:
# 1) No puede tener nombres no validos según no_valid_names[]
# 2) El nombre no puede ser "default"
# 3) El nombre debe estar dentro del rango del tamaño de nombre mínimo o
# máximo.
func validate_profile(profile_name):
	var profiles = get_profiles()
	
	# 1)
	if no_valid_names != null and no_valid_names.has(profile_name):
		return false
	
	# 2)
	if profile_name == "default":
		return false
	
	# 3)
	if profile_name.length() > profile_name_min_size and profile_name.length() + 1 < profile_name_max_size:
		return false
	
	return true
	
func save_profile_default():
	match mode:
		MODE_ENCRYPTED:
			save_profile_encripted("default")
		MODE_TEXT:
			save_profile_text("default")

func load_profile_default():
	match mode:
		MODE_ENCRYPTED:
			load_profile_encripted("default")
		MODE_TEXT:
			load_profile_text("default")
			
func save_profile_encripted(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".bin")
	
	var file = File.new()
	var err = file.open_encrypted_with_pass(file_path, File.WRITE_READ, password)
	
	if err == OK:
		file.get_var()
		file.store_var(data)
		return true
	else:
		if debug: print("[PersistenceNode] Error al crear el archivo: ", err)
		return false
	
func save_profile_text(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".txt")
	
	var file = File.new()
	var err = file.open(file_path, File.WRITE_READ)
	
	if err == OK:
		file.get_line() # Borrar la data anterior
		file.store_string(to_json(data))
		
		if beautifier_active:
			if debug: print("[PersistenceNode] save_profile_text()")
			print_json(to_json(data))
		
		return true
	else:
		if debug: print("[PersistenceNode] Error al crear/leer el archivo: ", err)
		return false

func load_profile_encripted(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".bin")
	
	if not file.file_exists(file_path):
		if debug: print("[PersistenceNode] El archivo no existe: " + file_path)
		return false
	
	var file = File.new()
	var err = file.open_encrypted_with_pass(file_path, File.READ, password)
	
	if err == OK:
		data = file.get_var()
		# Se guarda la data después de cargarla ya que, al cargar la data
		# se borran los datos en disco.
		save_profile_encripted(profile_name)
		
		return true
	else:
		if debug: print("[PersistenceNode] Error al leer el archivo: ", err)
		return false
	
func load_profile_text(profile_name):
	var file_path
	file_path = str("user://" + folder_name + "/" + profile_name + ".txt")
	
	var file = File.new()
	
	if not file.file_exists(file_path):
		if debug: print("[PersistenceNode] El archivo no existe: " + file_path)
		return false
	
	var err = file.open(file_path, File.READ)
	
	if err == OK:
		data = parse_json(file.get_line())
		# Se guarda la data después de cargarla ya que, al cargar la data
		# se borran los datos en disco.
		save_profile_text(profile_name)
		
		if beautifier_active:
			if debug: print("[PersistenceNode] load_profile_text()")
			print_json(to_json(data))
		
		return true
	else:
		if debug: print("[PersistenceNode] Error al crear/leer el archivo: ", err)
		return false

func print_json(json):
	if beautifier != null:
		print("__________- JSON -__________")
		print(beautifier.beautify_json(json))
		print("____________________________")
	