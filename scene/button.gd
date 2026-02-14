extends VBoxContainer

@onready var start = $Start
@onready var option = $Option
@onready var exit = $Exit


func _on_start_pressed():
	print("Start")
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_option_pressed():
	print("Option")
	

func _on_exit_pressed():
	print("Exit")
	get_tree().quit()
