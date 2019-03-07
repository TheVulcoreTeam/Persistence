extends Node

enum Some {ONE, TWO, TREE}

func _ready():
	# Test: MODE_TEXT | Alguien.txt | Other Folder
	#

	$Persistence.set_mode($Persistence.Mode.TEXT)
	
	$Persistence.set_folder_name("NuevaCarpeta")
	
	var data = $Persistence.get_data("Alguien")
	
	data["Diccionario"] = {
		Data1x = "Value1x",
		Data2x = "Value2x"
	}
	data["Nuevo"] = "Nueva Datax"

	$Persistence.save_data("Alguien")
