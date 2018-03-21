extends Node

func _ready():
#	$Persistence.set_mode($Persistence.MODE_ENCRYPTED)
#	$Persistence.remove_all_data()
#	$Persistence.load_data("1234")
	
#	var data = $Persistence.get_data("123456789112345")
#	data["nuevo"] = File.new()
#	print(data)

#	var data = $Persistence.get_data("1234")
#	data["algo_nuevo4"] = "nuevo4"
#
#	data["algo"] = {
#		Datos = "123",
#		Datox = 123
#	}
#
#	print(data)
#
#	$Persistence.save_data("1234")
#	$Persistence.save_data("123456789112345")
#
#	print($Persistence.get_data("123456789112345"))

	$Persistence.load_data()
	var data = $Persistence.get_data()
	
	data["Hola"] = 1
	data["Hola2"] = {
		Data1 = 2,
		"Data2" : true
	}
	
	$Persistence.save_data()