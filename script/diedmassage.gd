extends VBoxContainer


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()



