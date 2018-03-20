extends Node

func _ready():
	$Persistence.set_mode($Persistence.MODE_TEXT)
	$Persistence.save_data("ssHolaxx")
