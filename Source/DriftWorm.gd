extends KinematicBody2D

var jumpstart = true
var speed = 5
var rng = RandomNumberGenerator.new()
var coords
var previousPos = Vector2(0,0)
var xRange1 = 26
var xRange2 = 300
var yRange1 = 12
var yRange2 = 200
signal pressed_data


func _physics_process(delta):
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").frame = $AnimatedSprite.frame
	if speed > 5:
		speed -= 0.05
	else:
		if speed != 5:
			speed = 5
			
	if jumpstart == true or is_on_wall() == true or is_on_floor() == true or is_on_ceiling() == true: 
		var tempxRange1
		var tempxRange2
		var tempyRange1
		var tempyRange2
		if $AnimatedSprite.flip_h == true:
			tempxRange1 = 47
			tempxRange2 = int(position.x)
		else:
			tempxRange1 = int(position.x)
			tempxRange2 = 258
		if $AnimatedSprite.flip_v == true:
			tempyRange1 = 80
			tempyRange2 = int(position.y)
		else:
			tempyRange1 = int(position.y)
			tempyRange2 = 200
			
			
		rng.randomize()
		var randomX = rng.randf_range(0, 300)
		rng.randomize()
		var randomY = rng.randf_range(0, 200)
		coords = Vector2(int(randomX),int(randomY))
		$AnimatedSprite.play("jet")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").play("jet")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").play("jet")
		speed = 20
		jumpstart = false
		if coords.x >= position.x:
			$AnimatedSprite.flip_h = true
		elif coords.x < position.x:
			$AnimatedSprite.flip_h = false
		if coords.y >= position.y:
			$AnimatedSprite.flip_v = true
		elif coords.y < position.y:
			$AnimatedSprite.flip_v = false
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_h = $AnimatedSprite.flip_h
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_h = $AnimatedSprite.flip_h
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_v = $AnimatedSprite.flip_v
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_v = $AnimatedSprite.flip_v
	
	var velocity = (coords - position).normalized() * speed
	if (coords - position).length() > 1:
		velocity = move_and_slide(Vector2(int(velocity.x),int(velocity.y)))
	else:
		jumpstart = true

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jet":
		$AnimatedSprite.play("default")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").play("default")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").play("default")


func _on_item_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
		return
	emit_signal("pressed_data", self)
