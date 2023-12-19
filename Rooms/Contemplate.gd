extends Sprite

signal pressed
var selected 

func _on_Yes_pressed():
	selected = true
	emit_signal("pressed")


func _on_No_pressed():
	selected = false
	emit_signal("pressed")
