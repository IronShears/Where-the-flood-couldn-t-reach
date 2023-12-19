extends KinematicBody2D

var coord1 = {"knifePikaiid":Vector2(70,137),"knifePikaiid2":Vector2(261,92)}
var coord2 = {"knifePikaiid":Vector2(17,95),"knifePikaiid2":Vector2(209,92)}
var coords
var speed = 20
var jumpstart = true
var rng = RandomNumberGenerator.new()
signal pressed_data

func _physics_process(delta):
	if jumpstart == true or is_on_wall() == true or is_on_floor() == true or is_on_ceiling() == true:
		speed = 20
		jumpstart = false
		rng.randomize()
		var decision = rng.randf_range(0,3)
		if decision > 1:
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
		else:
			rng.randomize()
			var whichCoord = rng.randf_range(0,2)
			if whichCoord > 1:
				coords = coord2[self.name]
			else:
				coords = coord1[self.name]
	
	if coords.x >= position.x:
		$AnimatedSprite.flip_h = true
	elif coords.x < position.x:
		$AnimatedSprite.flip_h = false
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_h = $AnimatedSprite.flip_h
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_h = $AnimatedSprite.flip_h
	var velocity = (coords - position).normalized() * speed
	if (coords - position).length() > 1:
		velocity = move_and_slide(velocity)
	else:
		if coords == coord2[self.name] or coords == coord1[self.name]:
			position = coords
			$AnimatedSprite.play("scrape")
			$Timer.start()
			$scrapings.emitting = true
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").play("scrape")
			get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").play("scrape")
			if coords == coord1[self.name]:
				$AnimatedSprite.flip_h = false
				$scrapings.position = Vector2(-1,6)
			else:
				$AnimatedSprite.flip_h = true
				$scrapings.position = Vector2(34,6)
		else: 
			jumpstart = true
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").position = $AnimatedSprite.global_position
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").frame = $AnimatedSprite.frame
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").flip_h = $AnimatedSprite.flip_h
	get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").flip_h = $AnimatedSprite.flip_h



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "scrape":
		if coords == coord1[self.name]:
			coords = coord2[self.name]
		else:
			coords = coord1[self.name]
		jumpstart = true
		$AnimatedSprite.play("default")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Midlight").play("default")
		get_tree().get_root().get_node_or_null("/root/world/"+self.name+"Highlight").play("default")


func _on_Timer_timeout():
	$scrapings.emitting = false


func _on_item_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer").is_playing() == true:
		return
	emit_signal("pressed_data", self)
