extends ScrollContainer


var swype = false
var swypePoint = null
var swypeDX = 0

func inputEvent( ev ):
	if (ev is InputEventMouseButton)and(ev.pressed == true):
		swype = true
		swypePoint = ev.position.x
		swypeDX = 0
	if (ev is InputEventMouseButton)and(ev.pressed == false):
		swype = false
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_method(get_node("ScrollContainer"), "set_h_scroll", get_node("ScrollContainer").get_h_scroll(), get_node("ScrollContainer").get_h_scroll()-2*swypeDX, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_callback(tween, 0.5, "queue_free")
		tween.start()
		swypePoint = null
	if swype and (ev is InputEventMouseMotion):
		get_node("ScrollContainer").set_h_scroll(get_node("ScrollContainer").get_h_scroll() - ev.position.x + swypePoint)
		swypeDX = ev.position.x - swypePoint
