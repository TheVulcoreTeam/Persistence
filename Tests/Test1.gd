extends Node

func _ready():
	# Test: MODE_TEXT | Default.txt
	#
	$Persistence.mode = Persistence.Mode.TEXT
	
	var data = $Persistence.get_data()
	print(data)

	data["Diccionario"] = {
		"Data1" : "Value1",
		"Data2" : "Value2"
	}
	data["Nuevo"] = "Nueva Data"

	$Persistence.save_data()