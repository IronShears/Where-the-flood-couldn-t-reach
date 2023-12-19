extends AnimatedSprite



var rng = RandomNumberGenerator.new()


func _process(_delta):
	if animation == "default":
		rng.randomize()
		var my_random_number = rng.randf_range(0, 250.0)
		if my_random_number <= 1:
			play("playing")
			yield(self,"animation_finished")
			play("default")
		

func _on_item_mouse_entered():
	if UniversalFunctions.cutscene == false:
		self.set_material(load("res://Source/Highlight.tres"))


func _on_item_mouse_exited():
	self.set_material(null)
