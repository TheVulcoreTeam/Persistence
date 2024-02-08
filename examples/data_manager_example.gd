extends Control


func _ready():
	var character_data = $CharacterData.data as Dictionary
	
	character_data["character_name"] = "FuryCode"
	character_data["youtube"] = "https://www.youtube.com/@FuryCode"
	
	$CharacterData.save()
	
	var general_config_data = $GeneralConfigData.data as Dictionary
	
	general_config_data["screen_size"] = Vector2i(1280, 720)
	general_config_data["platform"] = "PC"
	
	$GeneralConfigData.save()
	
	
