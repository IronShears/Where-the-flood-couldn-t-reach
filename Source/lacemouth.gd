extends KinematicBody2D

var coords
var speed = 30
var jumpstart = true
var rng = RandomNumberGenerator.new()
signal pressed_data
signal enter_trap
var entered = false


func _physics_process(delta):
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_h = $AnimatedSprite.flip_h
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_h = $AnimatedSprite.flip_h
	if get_tree().get_root().get_node_or_null("/root/world/Midlight/Viewport/YSort/crabTrapCrinoid/DriftWormCageBait").visible == true and get_tree().get_root().get_node_or_null("/root/world/lacemouth").visible == true:
		if self.name == "lacemouth":
			UniversalFunctions.cutscene = true
			jumpstart = false
			coords = Vector2(112,98)
			
			
			var velocity = (coords - position).normalized() * speed
			if (coords - position).length() > 1:
				velocity = move_and_slide(Vector2(int(velocity.x),int(velocity.y)))
			else:
				emit_signal("enter_trap")
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").position = $AnimatedSprite.global_position
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").position = $AnimatedSprite.global_position
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").frame = $AnimatedSprite.frame
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").frame = $AnimatedSprite.frame
			if coords.x >= position.x:
				$AnimatedSprite.flip_h = true
			elif coords.x < position.x:
				$AnimatedSprite.flip_h = false
			return
		
	if jumpstart == true or is_on_wall() == true or is_on_floor() == true or is_on_ceiling() == true: 
		speed = 30
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
			
			
		rng.randomize()
		var randomX = rng.randf_range(0, 300)
		rng.randomize()
		var randomY = rng.randf_range(0, 200)
		coords = Vector2(int(randomX),int(randomY))
		$AnimatedSprite.play("swim")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").play("swim")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").play("swim")
		jumpstart = false
		if coords.x >= position.x:
			$AnimatedSprite.flip_h = true
		elif coords.x < position.x:
			$AnimatedSprite.flip_h = false
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_h = $AnimatedSprite.flip_h
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_h = $AnimatedSprite.flip_h
	
	if coords.x >= position.x:
		$AnimatedSprite.flip_h = true
	elif coords.x < position.x:
		$AnimatedSprite.flip_h = false
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
