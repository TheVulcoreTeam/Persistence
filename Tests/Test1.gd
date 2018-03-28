extends Node

func _ready():
	# Test: MODE_TEXT | Default.txt
	#
	Persistence.set_mode(Persistence.MODE_TEXT)
	
	var data = Persistence.get_data()
	
	data["Diccionario"] = {
		Data1 = "Value1",
		Data2 = "Value2"
	}
	data["Nuevo"] = "Nueva Data"
	
	Persistence.save_data()