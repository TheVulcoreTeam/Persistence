extends Node

func _ready():
	$Persistence.set_mode($Persistence.MODE_ENCRYPTED)
#	$Persistence.remove_all_data()
	$Persistence.load_data("123")
	
#	var data = $Persistence.get_data("123456789112345")
#	data["nuevo"] = File.new()
#	print(data)

	var data = $Persistence.get_data("123")
	data["algo_nuevo2"] = "nuevo2"
	print(data)
	
	$Persistence.save_data("123")
#	$Persistence.save_data("123456789112345")
#
#	print($Persistence.get_data("123456789112345"))