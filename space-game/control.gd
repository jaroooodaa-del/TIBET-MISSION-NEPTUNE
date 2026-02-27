extends Control

# This script lives on the "MainMenu" node
# It waits for the buttons to send a "pressed" signal

func _on_neptune_button_pressed():
	print("clicked")
	get_tree().change_scene_to_file("res://Maks/neptune2.tscn")
	

#func _on_uranus_button_pressed():
	#//get_tree().change_scene_to_file("res://levels/uranus.tscn")

#func _on_astroid_button_pressed():
	#//get_tree().change_scene_to_file("res://levels/kuiper_belt.tscn")


func _on_uranus_button_pressed() -> void:
	print("clicked")
	get_tree().change_scene_to_file("res://Patrick/uranus.tscn")	
	


func _on_astroid_button_pressed() -> void:
	print("clicked")
	get_tree().change_scene_to_file("res://Patrick/level_3.tscn")	
