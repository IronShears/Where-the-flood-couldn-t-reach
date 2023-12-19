extends KinematicBody2D

var coords
var speed = 5
var jumpstart = true
var rng = RandomNumberGenerator.new()
signal pressed_data


func _physics_process(delta):
	if jumpstart == true or is_on_wall() == true or is_on_floor() == true or is_on_ceiling() == true: 
		var tempxRange1
		var tempxRange2
		var tempyRange1
		var tempyRange2
			
		rng.randomize()
		var randomX = rng.randf_range(0, 300)
		rng.randomize()
		var randomY = rng.randf_range(0, 200)
		coords = Vector2(int(randomX),int(randomY))
		jumpstart = false
	
	var velocity = (coords - position).normalized() * speed
	if (coords - position).length() > 1:
		velocity = move_and_slide(Vector2(int(velocity.x),int(velocity.y)))
	else:
		jumpstart = true
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").frame = $AnimatedSprite.frame


func _on_item_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
		return
	emit_signal("pressed_data", self)
