extends Node

func _ready():
	# Test: MODE_TEXT | delete profiles
	#
	$Persistence.set_folder_name("Test6")
	$Persistence.set_mode($Persistence.Mode.TEXT)
	
	$Persistence.save_data("1")
	$Persistence.save_data("123")
	$Persistence.save_data("123456789101112131415") # Mas de 15
	$Persistence.save_data("123456789012345")
	$Persistence.save_data("default")
	$Persistence.set_folder_name("Test6")
	$Persistence.set_mode($Persistence.Mode.TEXT)
	