extends Node

func _ready():
	# Test: MODE_TEXT | validacion
	#
	
	Persistence.set_folder_name("PersistenceNode")
	Persistence.set_mode(Persistence.MODE_TEXT)
	
	Persistence.save_data("Juancio")
	Persistence.save_data("Pipo")
	
	Persistence.remove_profile("Juancio")
	Persistence.remove_all_data()