extends Node2D

var intro = 0
var lily = 0
var baitTaken = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Filter.visible = DataStorage.filter
	$Rest.set_text(">"+UniversalFunctions.dialogueJson["rest"])
	$Exit.set_text(">"+UniversalFunctions.dialogueJson["exit"])
	$Cursor.position = get_global_mouse_position()
	dataLoad()
	yield($AnimationPlayer, "animation_finished")
	if intro == 0:
		UniversalFunctions.play_dialogue_JSON("intro4")
		yield($Dialogue, "done")
		$AnimationPlayer.play_backwards("load")
		yield($AnimationPlayer, "animation_finished")
		UniversalFunctions.place([$RestingRoomLighting],["lamp","baitBox"])
		$AnimationPlayer.play("load")
		yield($AnimationPlayer, "animation_finished")
		UniversalFunctions.play_dialogue_JSON("intro5")
		yield($Dialogue, "done")
		intro = 1
		UniversalFunctions.play_dialogue_JSON("restOutro"+str(DataStorage.stage))
		yield($Dialogue, "done")
		$AnimationPlayer.play_backwards("load")
		yield($AnimationPlayer, "animation_finished")
		DataStorage.stage += 1
		$ColorRect/timeCard.run()
		yield($ColorRect/timeCard, "finished")
		$AnimationPlayer.play("load")
		yield($AnimationPlayer, "animation_finished")
		UniversalFunctions.play_dialogue_JSON("restIntro"+str(DataStorage.stage))
		yield($Dialogue, "done")
		UniversalFunctions.swap("waterBottleFull","waterBottleHalf")
		$Rest.visible = true
		$Exit.visible = true



func dataLoad():
	UniversalFunctions.update()
	$AnimationPlayer.play("load")
	if DataStorage.gameData.has("Rest"):
		var data = DataStorage.gameData["Rest"]
		intro = data["intro"]
		lily = data["lily"]
		$RestingRoomLighting.visible = data["camp"]
		$Exit.visible = data["buttons"]
		$Rest.visible = data["buttons"]
	
	
func dataSave():
	DataStorage.gameData["Rest"] = {
		"intro" : intro,
		"lily" : lily,
		"camp" : $RestingRoomLighting.visible,
		"buttons" : $Exit.visible
	}


func _on_Exit_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	dataSave()
	UniversalFunctions.move("res://Rooms/MainRoom.tscn")


func _on_Rest_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.stage >= 2:
		if DataStorage.gameData["Main"]["bodyDiscovered"] == true:
			if DataStorage.observedSpecies.has("arthrocaris"):
				UniversalFunctions.play_dialogue_JSON("restOutro"+str(DataStorage.stage))
			else:
				UniversalFunctions.play_dialogue_JSON("restOutro"+str(DataStorage.stage)+"BodyDiscovered")
		else:
			UniversalFunctions.play_dialogue_JSON("restOutro"+str(DataStorage.stage))
	else:
		UniversalFunctions.play_dialogue_JSON("restOutro"+str(DataStorage.stage))
	yield($Dialogue, "done")
	$AnimationPlayer.play_backwards("load")
	yield($AnimationPlayer, "animation_finished")
	if DataStorage.stage == 3:
		if DataStorage.inventory.has("waterBottleEmpty"):
			DataStorage.ending = 1
			UniversalFunctions.play_dialogue_JSON("thirstEnding")
			yield($Dialogue, "done")
			get_tree().change_scene("res://Components/Credits.tscn")
			return
	elif DataStorage.stage == 5:
		UniversalFunctions.play_dialogue_JSON("Ending0")
		yield($Dialogue, "done")
		$SoundEffects.stream = load("res://Sounds/cavein.wav")
		$SoundEffects.play()
		yield($SoundEffects,"finished")
		if DataStorage.gameData["Main"]["bodyDiscovered"] == false:
			DataStorage.ending = 2
			UniversalFunctions.play_dialogue_JSON("mediocreEnding")
			yield($Dialogue, "done")
		else:
			if DataStorage.observedSpecies.size() == 6:
				DataStorage.ending = 2
			else:
				DataStorage.ending = 3
			UniversalFunctions.play_dialogue_JSON("goodEnding0")
			yield($Dialogue, "done")
			if DataStorage.observedSpecies.has("arthrocaris"):
				UniversalFunctions.play_dialogue_JSON("goodEndingAdd")
				yield($Dialogue, "done")
			UniversalFunctions.play_dialogue_JSON("goodEnding1")
			yield($Dialogue, "done")
		$Timer.start()
		yield($Timer,"timeout")
		get_tree().change_scene("res://Components/Credits.tscn")
		return
	DataStorage.stage += 1
	$ColorRect/timeCard.run()
	yield($ColorRect/timeCard, "finished")
	$AnimationPlayer.play("load")
	yield($AnimationPlayer, "animation_finished")
	if DataStorage.stage >= 3:
		if DataStorage.gameData["Main"]["bodyDiscovered"] == true:
			UniversalFunctions.play_dialogue_JSON("restIntro"+str(DataStorage.stage)+"BodyDiscovered")
		else:
			UniversalFunctions.play_dialogue_JSON("restIntro"+str(DataStorage.stage))
	else:
		UniversalFunctions.play_dialogue_JSON("restIntro"+str(DataStorage.stage))
	yield($Dialogue, "done")
	if DataStorage.inventory.has("waterBottleHalf"):
		UniversalFunctions.swap("waterBottleHalf","waterBottleEmpty")
		UniversalFunctions.play_dialogue_JSON("thirsty"+str(DataStorage.stage))
		yield($Dialogue, "done")
	elif DataStorage.inventory.has("waterBottleEmpty"):
		UniversalFunctions.play_dialogue_JSON("thirsty"+str(DataStorage.stage))
		yield($Dialogue, "done")
		if DataStorage.stage == 3:
			return
	

func _on_Bag_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	$Bag.update()
	$Bag/Tablet.set_text()
	UniversalFunctions.cutscene = true
	$BagIcon.set_material(null)
	$Bag.visible = true
	$BagIcon.visible = false
	$Radio.visible = false


func _on_Lamp_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("lampLook")


func _on_box_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("baitBoxLook")
