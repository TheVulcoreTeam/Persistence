tool
extends Node

export (bool) var debug = false
export (String) var sufix = "persistence_"

enum Mode {MODE_ENCRYPTED, MODE_TEXT}
export (Mode) var mode = MODE_ENCRYPTED

func _ready():
	
	pass

func _enter_tree():
	if debug : print("PersistenceNode: _enter_tree()")
 
# Métodos públicos
# 

# Salva el juego con el profile por defecto. Si no hay profile o no se logra
# guardar la data devuelve false; si se logra guardar la data devuelve true.
func save_game(profile = ""):
	pass
	
func create_profile(profile_name):
	pass
	
func remove_profile(profile_name):
	pass

# MODE_TEXT : Guarda la data en texto en formato json
func mode(mode):
	pass