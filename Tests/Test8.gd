extends Node

func _ready():
	# Test: MODE_TEXT | change profile
	#
	
	$Persistence.set_folder_name("Test8")
	
	$Persistence.set_mode($Persistence.Mode.TEXT)
	
	var xx1 = $Persistence.get_data("xx1")
	xx1["xx1data"] = "algo1"
	print("xx1: ", xx1)
	$Persistence.save_data("xx1")
	
	var xx2 = $Persistence.get_data("xx2")
	xx2["xx2data"] = "algo2"
	print("xx2: ", xx2)
	$Persistence.save_data("xx2")
	
	xx1 = $Persistence.get_data("xx1")
	xx1["xx1data-new"] = "algo1-new"
	print("xx1: ", xx1)
	$Persistence.save_data("xx1")
	
	$Persistence.set_mode($Persistence.Mode.ENCRYPTED)
	
	xx1 = $Persistence.get_data("xx1")
	xx1["xx1data"] = "algo1"
	print("xx1: ", xx1)
	$Persistence.save_data("xx1")
	
	xx2 = $Persistence.get_data("xx2")
	xx2["xx2data"] = "algo2"
	print("xx2: ", xx2)
	$Persistence.save_data("xx2")
	
	xx1 = $Persistence.get_data("xx1")
	xx1["xx1data-new"] = "algo1-new"
	print("xx1: ", xx1)
	$Persistence.save_data("xx1")
	