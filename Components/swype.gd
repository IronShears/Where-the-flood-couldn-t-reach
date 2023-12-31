extends Control

onready var Scroller := self
var direction
var held = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			
			if event.scancode == KEY_DOWN :
				direction = "down"
			elif event.scancode == KEY_UP :
				direction = "up"
			else:
				return
			held = true
		else:
			held = false
			direction = null

func _process(_delta):
	if held == true:
		var SC = Scroller
		if direction == "up":
			SC.set_v_scroll ( SC.get_v_scroll() - 2 )
		elif direction == "down":
			SC.set_v_scroll ( SC.get_v_scroll() + 2 )
			
