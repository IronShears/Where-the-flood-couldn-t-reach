extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if DataStorage.filter != null:
		$Filter.visible = DataStorage.filter
	$wakeUp.set_text(">"+UniversalFunctions.dialogueJson["wakeUp"])
	$KeepOn.set_text(">"+UniversalFunctions.dialogueJson["keepOn"])
	$TurnOff.set_text(">"+UniversalFunctions.dialogueJson["turnOff"])
	$tumble.play()
	yield($tumble, "finished")
	if DataStorage.filter == null:
		$KeepOn.visible = true
		$TurnOff.visible = true
	else:
		finish()



func _on_KeepOn_pressed():
	DataStorage.filter = true
	finish()


func _on_TurnOff_pressed():
	DataStorage.filter = false
	$Filter.visible = false
	finish()

func finish():
	$KeepOn.visible = false
	$TurnOff.visible = false
	$wakeUp.visible = true


func _on_wakeUp_pressed():
	get_tree().change_scene("res://Rooms/MainRoom.tscn")
