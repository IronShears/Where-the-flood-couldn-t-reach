extends Node2D

func _ready():
	$Filter.visible = DataStorage.filter
	UniversalFunctions.update()
	$AnimationPlayer.play("load")
	yield($AnimationPlayer, "animation_finished")
	var textUpdate = UniversalFunctions.dialogueJson["credits"]
	var speciesNumber = DataStorage.observedSpecies.size()-6
	if DataStorage.observedSpecies.has("SlugPikaiid"):
		speciesNumber -= 1
	if DataStorage.observedSpecies.has("bigBoyPikaiid"):
		speciesNumber -= 1
	textUpdate = textUpdate.replace("{species}", speciesNumber)
	textUpdate = textUpdate.replace("{ending}", str(DataStorage.ending))
	textUpdate = textUpdate.replace("{endingTitle}", UniversalFunctions.dialogueJson["endingName"+str(DataStorage.ending)])
	$Text.set_bbcode(textUpdate)


func _on_Tablet_go():
	$speedup.visible = true
	$AnimationPlayer2.play("roll")
	yield($AnimationPlayer2, "animation_finished")
	DataStorage.save_game()
	get_tree().change_scene("res://Components/Title.tscn")


func _on_speedup_button_down():
	if $AnimationPlayer2.is_playing() == false:
		return
	$AnimationPlayer2.playback_speed = 4


func _on_speedup_button_up():
	if $AnimationPlayer2.is_playing() == false:
		return
	$AnimationPlayer2.playback_speed = 1
