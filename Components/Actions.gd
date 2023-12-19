extends Node2D

var selected
signal pressed


func arrange(options):
	selected = null
	$ActionRing/Use.visible = false
	$ActionRing/Look.visible = false
	$ActionRing/Take.visible = false
	if options.size() == 2:
		options[0].position = Vector2(0,-34)
		options[1].position = Vector2(0,34)
		options[0].visible = true
		options[1].visible = true
		
	else:
		options[0].position = Vector2(0,-34)
		options[1].position = Vector2(31,14)
		options[2].position = Vector2(-31,14)
		options[0].visible = true
		options[1].visible = true
		options[2].visible = true

func _on_Use_pressed():
	selected = "Use"
	emit_signal("pressed")


func _on_Take_pressed():
	selected = "Take"
	emit_signal("pressed")


func _on_Look_pressed():
	selected = "Look"
	emit_signal("pressed")


func _on_cancel_pressed():
	selected = "cancel"
	emit_signal("pressed")
