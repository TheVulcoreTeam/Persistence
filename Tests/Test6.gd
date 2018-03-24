extends Node

func _ready():
	# Test: MODE_TEXT | validacion
	#
	
	Persistence.set_folder_name("PersistenceNode")
	Persistence.set_mode(Persistence.MODE_TEXT)
	
	Persistence.save_data("1")
	Persistence.save_data("123")
	Persistence.save_data("123456789101112131415") # Mas de 15
	Persistence.save_data("123456789012345")
	Persistence.save_data("default")