extends Node

func _ready():
	# Test: MODE_TEXT | remove profiles
	#
	
	$Persistence.set_folder_name("Test7")
	$Persistence.set_mode($Persistence.Mode.TEXT)
	
	$Persistence.save_data("Juancio")
	$Persistence.save_data("Pipo")
	
	$Persistence.remove_profile("Juancio")
	$Persistence.remove_all_data()