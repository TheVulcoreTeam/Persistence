extends Node

func _ready():
	# Test: MODE_ENCRYPTED and MODE_TEXT | get_profiles
	#
	
	Persistence.set_folder_name("PersistenceNode")
	
	Persistence.set_mode(Persistence.MODE_ENCRYPTED)
	print("get_mode(): ", Persistence.get_mode())
	
	Persistence.save_data("x1")
	Persistence.save_data("x2")
	Persistence.save_data("x3")
	
	Persistence.set_mode(Persistence.MODE_TEXT)
	print("get_mode(): ", Persistence.get_mode())
	
	Persistence.save_data("y1")
	Persistence.save_data("y2")
	Persistence.save_data("y3")
	
	print("Profiles: ", Persistence.get_profiles())