extends Node2D

signal pressed_data


func _on_item_mouse_entered():
	if UniversalFunctions.cutscene == false:
		if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
			return
		self.set_material(load("res://Source/Highlight.tres"))


func _on_item_mouse_exited():
		self.set_material(null)


func _on_item_pressed():
	emit_signal("pressed_data", self)
