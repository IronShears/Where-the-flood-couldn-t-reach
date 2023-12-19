extends Node2D

func _ready():
	UniversalFunctions.update()
	$Filter.visible = DataStorage.filter
	var textUpdate = UniversalFunctions.dialogueJson["credits"]
	textUpdate = textUpdate.replace("{species}", DataStorage.observedSpecies.size()-6)
	textUpdate = textUpdate.replace("{ending}", str(DataStorage.ending))
	textUpdate = textUpdate.replace("{endingTitle}", UniversalFunctions.dialogueJson["endingName"+str(DataStorage.ending)])
	$Text.set_bbcode(textUpdate)


func _on_Tablet_go():
	$speedup.visible = true
	$AnimationPlayer.play("roll")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Components/Title.tscn")


func _on_speedup_button_down():
	if $AnimationPlayer.is_playing() == false:
		return
	$AnimationPlayer.playback_speed = 4


func _on_speedup_button_up():
	if $AnimationPlayer.is_playing() == false:
		return
	$AnimationPlayer.playback_speed = 1
