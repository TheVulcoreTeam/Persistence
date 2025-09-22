extends GutTest


var persistence_node_var : Persistence
var persistence_node_text : Persistence

var data_var : Dictionary
var data_text : Dictionary


func before_all():
	persistence_node_var = Persistence.new()
	persistence_node_var.folder_name = "tests"
	persistence_node_var.file_name = "test"
	persistence_node_var.warnings = true
	persistence_node_var.name = "PersistenceNodeVar"
	persistence_node_var.mode = Persistence.Mode.ENV_PRODUCTION
	
	persistence_node_text = Persistence.new()
	persistence_node_text.folder_name = "tests"
	persistence_node_text.file_name = "test"
	persistence_node_text.warnings = true
	persistence_node_text.name = "PersistenceNodeText"
	persistence_node_text.mode = Persistence.Mode.ENV_DEVELOPMENT
	
	add_child(persistence_node_var)
	add_child(persistence_node_text)


func test_get_and_save_produccion():
	data_var = persistence_node_var.data
	data_var["save_something"] = "something_var"
	
	persistence_node_var.save()
	
	assert_eq(data_var["save_something"], "something_var")
	
	pass_test("get_and_save_development, passing")


func test_get_and_save_development():
	data_text = persistence_node_text.data
	data_text["save_something"] = "something_txt"
	
	persistence_node_text.save()
	
	assert_eq(data_text["save_something"], "something_txt")
	
	pass_test("get_and_save_development, passing")


func test_save_data_more_that_one_time_development():
	data_text = persistence_node_text.data
	
	data_text["hello"] = "bye"
	persistence_node_text.save()
	
	data_text["thats is true"] = true
	persistence_node_text.save()
	
	data_text["nested_dictionary"] = {
		"hello nested " : "dictionary xD",
		1 : true,
		3.14 : Vector2(1.2, 1.4)
	}
	persistence_node_text.save()
	
	assert_eq(data_text["hello"], "bye")
	assert_eq(data_text["thats is true"], true)
	assert_eq(data_text["nested_dictionary"], {
		"hello nested " : "dictionary xD",
		1 : true,
		3.14 : Vector2(1.2, 1.4)
	})
	
	pass_test("save_data_more_that_one_time_development, passing")


func test_save_data_more_that_one_time_production():
	data_var = persistence_node_var.data
	
	data_var["hello"] = "bye"
	persistence_node_var.save()
	
	data_var["thats is true"] = true
	persistence_node_var.save()
	
	data_var["nested_dictionary"] = {
		"hello nested " : "dictionary xD",
		1 : true,
		3.14 : Vector2(1.2, 1.4)
	}
	persistence_node_var.save()
	
	assert_eq(data_var["hello"], "bye")
	assert_eq(data_var["thats is true"], true)
	assert_eq(data_var["nested_dictionary"], {
		"hello nested " : "dictionary xD",
		1 : true,
		3.14 : Vector2(1.2, 1.4)
	})
	
	pass_test("save_data_more_that_one_time_production, passing")


#func test_error_to_change_data_explicitly_production():
	#var old_data = persistence_node_var.data.duplicate_deep(5)
	#
	## The data can't be changed explicitly
	#var new_data = {"something" : "something"}
	#persistence_node_var.data = new_data
	#
	#assert_true(persistence_node_var.data.recursive_equal(old_data, 5), "persistence_node_var.data == old_data [PASSING]")
	#assert_false(persistence_node_var.data.recursive_equal(new_data, 5), "persistence_node_var.data != new_data [PASSING]")
	#
	#pass_test("error_to_change_data_explicitly_production, passing")
#
#
#func test_error_to_change_data_explicitly_development():
	#var old_data = persistence_node_text.data.duplicate_deep(5)
	#
	## The data can't be changed explicitly
	#var new_data = {"something" : "something"}
	#persistence_node_text.data = new_data
	#
	#assert_true(persistence_node_text.data.recursive_equal(old_data, 5), "persistence_node_text.data == old_data [PASSING]")
	#assert_false(persistence_node_text.data.recursive_equal(new_data, 5), "persistence_node_text.data != new_data [PASSING]")
	#
	#pass_test("error_to_change_data_explicitly_development, passing")


func test_load_data_text():
	data_text = persistence_node_text.data
	
	if data_text.has("save_something"):
		assert_eq(data_text["save_something"], "something_txt")
		
		pass_test("load_data, passing")
	else:
		fail_test("load_data_text: save_something key, not exist, failed")


func test_delete_file_development():
	persistence_node_text.delete_file()
	
	assert_eq(persistence_node_text.data, {})


func test_delete_file_production():
	persistence_node_var.delete_file()
	
	assert_eq(persistence_node_var.data, {})
