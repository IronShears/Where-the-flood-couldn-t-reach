extends TextureButton




func _on_mouse_entered():
	if UniversalFunctions.cutscene == false:
		if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
			return
		$highlight.visible = true


func _on_mouse_exited():
	$highlight.visible = false
