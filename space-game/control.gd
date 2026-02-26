extends Control

# This script lives on the "MainMenu" node
# It waits for the buttons to send a "pressed" signal

func _on_neptune_button_pressed():
	get_tree().change_scene_to_file("res://levels/neptune.tscn")
	

#//func _on_uranus_button_pressed():
	#//get_tree().change_scene_to_file("res://levels/uranus.tscn")

#//func _on_astroid_button_pressed():
	#//get_tree().change_scene_to_file("res://levels/kuiper_belt.tscn")


func _on_button_pressed() -> void:
	pass # Replace with function body.
