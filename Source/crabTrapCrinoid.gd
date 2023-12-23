extends Sprite




func _on_item_mouse_entered():
	if UniversalFunctions.cutscene == false:
		if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
			return
		self.set_material(load("res://Source/algae1Highlight.tres"))

func _on_item_mouse_exited():
	self.set_material(load("res://Source/crinoidLowLight.tres"))
