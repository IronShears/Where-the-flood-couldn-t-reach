extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if DataStorage.filter != null:
		$ViewportContainer.visible = true
		$Filter.visible = DataStorage.filter
		$ViewportContainer/ToggleFilter.set_text(">"+UniversalFunctions.dialogueJson["filterToggle" + str(DataStorage.filter)])
		$ViewportContainer/ViewTablet.set_text(">"+UniversalFunctions.dialogueJson["viewTablet"])
		$ViewportContainer/NewGame.set_text(">"+UniversalFunctions.dialogueJson["newGame"])
		$ViewportContainer/Title.set_bbcode(UniversalFunctions.dialogueJson["gameTitle"])
		if DataStorage.ending == 4:
			$ViewportContainer/candle2.visible = true
		elif DataStorage.ending == 3:
			$ViewportContainer/goodEnd.visible = true
		$AnimationPlayer.play("load")
		return
	new_game()

func new_game():
	DataStorage.reset()
	$wakeUp.set_text(">"+UniversalFunctions.dialogueJson["wakeUp"])
	$KeepOn.set_text(">"+UniversalFunctions.dialogueJson["keepOn"])
	$TurnOff.set_text(">"+UniversalFunctions.dialogueJson["turnOff"])
	$tumble.play()
	yield($tumble, "finished")
	$KeepOn.visible = true
	$TurnOff.visible = true



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


func _on_ViewTablet_pressed():
	$Tablet.visible = true


func _on_ToggleFilter_pressed():
	if DataStorage.filter == true:
		DataStorage.filter = false
	else:
		DataStorage.filter = true
	$ViewportContainer/ToggleFilter.set_text(">"+UniversalFunctions.dialogueJson["filterToggle" + str(DataStorage.filter)])
	$Filter.visible = DataStorage.filter


func _on_NewGame_pressed():
	$AnimationPlayer.play_backwards("load")
	yield($AnimationPlayer, "animation_finished")
	$ViewportContainer.visible = false
	new_game()
	
