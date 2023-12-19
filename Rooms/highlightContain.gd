extends Node2D
var key = { "crackerEurypterid2":"Slot2/isopodRadiodontBait",
			"crackerEurypterid1":"Slot1/isopodRadiodontBait"
}

func _on_item_mouse_entered():
	if UniversalFunctions.cutscene == false:
		if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
			return
		self.set_material(load("res://Source/Highlight.tres"))


func _on_item_mouse_exited():
	self.set_material(null)



func _process(_delta):
	if self.visible == true:
		get_tree().get_root().get_node_or_null("/root/world/"+key[name]).frame = self.frame
