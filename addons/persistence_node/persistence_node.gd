# MIT License
#
# Persistence Node
#
# Copyright (c) 2018-2024 Matías Muñoz Espinoza
# Copyright (c) 2019 Ren Project
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

extends Node

class_name Persistence

signal saved
signal loaded

const PERSISTENCE_PREFIX = "[PersistenceNode]"

const ERROR_KEY = 'ERROR'
const CANT_DIRECTORY_ACCESS = "Can't access to directory"
const CANT_DIRECTORY_CREATE = "Can't create directory"
const NO_EXPLICIT_DATA = 'You cannot assign data explicitly, add data using a keys like data["key"] = "something to add".'
const DO_NOT_CHARGE_MORE_THAT_ONCE = 'Do not charge more that once time due to performance issues'

@export_category("Save Files and Folders")
@export var folder_name := "saves"
@export var file_name := "data"
@export var extention_env_production := ".binary"
@export var extention_env_development := ".json"
@export var password_env_production:= ""

@export_category("Enviroment")

enum Mode {ENV_PRODUCTION, ENV_DEVELOPMENT}
@export var mode : Mode :
	set(value):
		mode = value
	get:
		return mode

@export var store_objects := false

@export_category("Debug Plugin (PersistenceNode)")
@export var warnings := false

# Only can have one recharge
var _more_that_one_charge := true
var _file_path := ""
var _error : Error
# Is used to store the data and bypass the warning
var _can_save_without_warning := false

# Memory data
var data := {} :
	get:
		# The data only can be charge one time
		if not _more_that_one_charge:
			_more_that_one_charge = true
			
			var dir_exists = DirAccess.open("user://" + folder_name)
			var file
			
			if dir_exists:
				match mode:
					Mode.ENV_PRODUCTION:
						_file_path = str("user://" + folder_name + "/" + file_name + extention_env_production)
						file = FileAccess.open_encrypted_with_pass(
							_file_path,
							FileAccess.READ,
							password_env_production
						)
						_error = FileAccess.get_open_error()
						
						#if _error == Error.ERR_FILE_NOT_FOUND:
							#file = FileAccess.open_encrypted_with_pass(
								#_file_path, 
								#FileAccess.WRITE_READ,
								#password_env_production
							#)
							#_error = FileAccess.get_open_error()
						
						var content : Dictionary = file.get_var(store_objects)
						file.close()
						
						_can_save_without_warning = true
						
						if not content:
							data = {}
						else:
							data = content
					
					Mode.ENV_DEVELOPMENT:
						_file_path = str("user://" + folder_name + "/" + file_name + extention_env_development)
						
						file = FileAccess.open(_file_path, FileAccess.READ)
						_error = FileAccess.get_open_error()
						
						if _error == FileAccess.WRITE_READ:
							file = FileAccess.open(_file_path, FileAccess.WRITE_READ)
							_error = FileAccess.get_open_error()
						
						var content : String = file.get_as_text()
						file.close()
						
						_can_save_without_warning = true
						
						if content.is_empty():
							data = {}
						else:
							data = JSON.parse_string(content)
			else:
				_debug_persistence_node(CANT_DIRECTORY_ACCESS)
		
		return data
	
	set(value):
		if _can_save_without_warning:
			_can_save_without_warning = false
			data = value
		else:
			_debug_persistence_node(
				NO_EXPLICIT_DATA + " : " +
				str(value)
			)
			
			# data is not change


func save() -> void:
	if not DirAccess.dir_exists_absolute("user://" + folder_name):
		var err = DirAccess.make_dir_recursive_absolute("user://" + folder_name)
		if err != Error.OK:
			_debug_persistence_node(CANT_DIRECTORY_CREATE)
	
	var dir_exists = DirAccess.open("user://" + folder_name)
	var file
	
	if dir_exists:
		match mode:
			Mode.ENV_PRODUCTION:
				_file_path = "user://" + folder_name + "/" + file_name + extention_env_production
				
				file = FileAccess.open_encrypted_with_pass(
					_file_path, 
					FileAccess.WRITE,
					password_env_production
				)
				file.store_var(data, store_objects)
				file.close()
			Mode.ENV_DEVELOPMENT:
				_file_path = "user://" + folder_name + "/" + file_name + extention_env_development
				
				file = FileAccess.open(
					_file_path,
					FileAccess.WRITE
				)
				file.store_string(JSON.stringify(data, "\t"))
				file.close()
	else:
		_debug_persistence_node(CANT_DIRECTORY_ACCESS)


func _debug_persistence_node(message : String) -> void:
	if warnings:
		var format = str(PERSISTENCE_PREFIX, " ", message)
		push_warning(format)

