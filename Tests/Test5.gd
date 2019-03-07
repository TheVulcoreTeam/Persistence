extends Node

func _ready():
	# Test: MODE_ENCRYPTED and MODE_TEXT | get_profiles
	#
	
	$Persistence.set_folder_name("PersistenceNode")
	
	$Persistence.mode = $Persistence.Mode.ENCRYPTED
	print("get_mode(): ", $Persistence.get_mode())
	
	var xx1 = $Persistence.get_data("xx1")
	$Persistence.save_data("xx1")
	var xx2 = $Persistence.get_data("xx2")
	$Persistence.save_data("xx2")
	var xx3 = $Persistence.get_data("xx3")
	$Persistence.save_data("xx3")
	
	$Persistence.mode = $Persistence.Mode.TEXT
	print("get_mode(): ", $Persistence.get_mode())
	
	$Persistence.save_data("yy1")
	$Persistence.save_data("yy2")
	$Persistence.save_data("yy3")
	
	print("Profiles: ", $Persistence.get_profiles())