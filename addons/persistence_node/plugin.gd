@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type(
		"Persistence", 
		"Node", 
		preload("res://addons/persistence_node/persistence_node.gd"), 
		preload("res://addons/persistence_node/icon.png")
	)


func _exit_tree():
	remove_custom_type("Persistence")
