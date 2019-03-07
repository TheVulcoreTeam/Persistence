extends Node

func _ready():
	# Test: MODE_ENCRYPTED | default.save
	#
	
	$Persistence.set_mode($Persistence.Mode.ENCRYPTED)
	$Persistence.set_folder_name("PersistenceNode")
	print("get_mode(): ", $Persistence.get_mode())
	
	var data = $Persistence.get_data()
	print("get_data(): ", data)
	
	data["Diccionario"] = {
		Data1x = "Value1x",
		Data2x = "Value2x"
	}
	data["Nuevo2"] = "Nueva Datax2"
	
	$Persistence.save_data()
	print("save_data(): ", data)