extends Node2D

var intro = 0
var slotName1
var slotStage1
var slotName2
var slotStage2
var bodyDiscovered = false


func _ready():
	
	$Filter.visible = DataStorage.filter
	$Cursor.position = get_global_mouse_position()
	
	
	if DataStorage.stage >= 2:
		$Corpse.visible = false
		
		
		
	if DataStorage.slotsVisible == true:
		$Slot1.visible = true
		$Slot2.visible = true
		
	if DataStorage.stage == 5:
		$Slot1/slotButon.visible = false
		$Slot2/slotButon.visible = false
	dataLoad()
	
	
	if intro == 0:
		var file = File.new()
		assert(file.file_exists("res://Components/"+DataStorage.language+"Text.json"))
		file.open("res://Components/"+DataStorage.language+"Text.json", file.READ)
		UniversalFunctions.dialogueJson = parse_json(file.get_as_text())
		$SoundEffects.stream = load("res://Sounds/Tinnitus.wav")
		$SoundEffects.play()
		yield($Timer, "timeout")
		UniversalFunctions.play_dialogue_JSON("intro")
		yield($Dialogue, "done")
		$Radio.visible = true
		$BagIcon.visible = true
		UniversalFunctions.play_dialogue_JSON("intro2")
		yield($Dialogue, "done")
		$SoundEffects.stream = load("res://Sounds/Place.wav")
		$SoundEffects.play()
		yield($SoundEffects,"finished")
		$AnimationPlayer.play("load")
		yield($AnimationPlayer,"animation_finished")
		UniversalFunctions.play_dialogue_JSON("intro3")
		yield($Dialogue, "done")
		UniversalFunctions.cutscene = false
		intro = 1
		return
		
	else:
		$Radio.visible = true
		$BagIcon.visible = true
		
		
		
		
		
	if slotStage1 != null:
		$Slot1.visible = true
		if DataStorage.stage-slotStage1 == 0 or DataStorage.stage-slotStage1 == 1:
			get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).play(slotName1+str(DataStorage.stage-slotStage1))
			get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).visible = true
		else:
			slotStage1 = null
			slotName1 = null
		if slotStage1 != null:
			if DataStorage.stage-slotStage1 == 1:
				if slotName1 == "veinerWorm":
					$isopodRadiodont1.visible = true
					$Slot1/veinerWorm/veinerWorm.visible = false
				elif slotName1 == "driftWormBait":
					$isopodRadiodont1.visible = true
				elif slotName1 == "isopodRadiodontBait":
					$crackerEurypterid1.visible = true
					$Slot1/isopodRadiodontBait.frame = $crackerEurypterid1.frame
				elif slotName1 == "lacemouthBait":
					$wiggleTrilobite1.visible = true
				elif slotName1 == "bigBoyPikaiidBait":
					$Background/Arthrocaris.visible = true
					if DataStorage.observedSpecies.has("arthrocaris"):
						yield($AnimationPlayer,"animation_finished")
						UniversalFunctions.play_dialogue_JSON("arthrocarisDiscover0")
						yield($Dialogue, "done")
						UniversalFunctions.cutscene = true
						$Background/Arthrocaris.play("look")
						yield($Background/Arthrocaris,"animation_finished")
						$Background/Arthrocaris.play("default")
						UniversalFunctions.play_dialogue_JSON("arthrocarisDiscover1")
						yield($Dialogue, "done")
						if DataStorage.cavesDiscovered == true:
							DataStorage.observedSpecies["arthrocaris"] = 1
						else:
							DataStorage.observedSpecies["arthrocaris"] = 0
			
	if slotStage2 != null:
		if DataStorage.stage-slotStage2 == 0 or DataStorage.stage-slotStage2 == 1:
			get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).play(slotName2+str(DataStorage.stage-slotStage2))
			get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).visible = true
		else:
			slotStage2 = null
			slotName2 = null
		if slotStage2 != null:
			if DataStorage.stage-slotStage2 == 1:
				if slotName2 == "driftWormBait":
					$isopodRadiodont2.visible = true
				elif slotName2 == "isopodRadiodontBait":
					$crackerEurypterid2.visible = true
				elif slotName2 == "lacemouthBait":
					$wiggleTrilobite2.visible = true
				elif slotName2 == "bigBoyPikaiidBait":
					$Background/Arthrocaris.visible = true
					if DataStorage.observedSpecies.has("arthrocaris"):
						yield($AnimationPlayer,"animation_finished")
						UniversalFunctions.play_dialogue_JSON("arthrocarisDiscover0")
						yield($Dialogue, "done")
						UniversalFunctions.cutscene = true
						$Background/Arthrocaris.play("look")
						yield($Background/Arthrocaris,"animation_finished")
						$Background/Arthrocaris.play("default")
						UniversalFunctions.play_dialogue_JSON("arthrocarisDiscover1")
						yield($Dialogue, "done")
						if DataStorage.cavesDiscovered == true:
							DataStorage.observedSpecies["arthrocaris"] = 1
						else:
							DataStorage.observedSpecies["arthrocaris"] = 0
		
	yield($AnimationPlayer,"animation_finished")
	if bodyDiscovered == false and $Corpse.visible == false:
		UniversalFunctions.play_dialogue_JSON("bodyMissing")
		yield($Dialogue, "done")
		bodyDiscovered = true
	if slotName1 == "veinerWorm" and DataStorage.stage-slotStage1 == 1 and DataStorage.slotsVisible == false:
		UniversalFunctions.play_dialogue_JSON("speciesAttracted")
		DataStorage.slotsVisible = true
		$Slot1.visible = true
		$Slot2.visible = true
		yield($Dialogue, "done")

func dataLoad():
	UniversalFunctions.update()
	if DataStorage.gameData.has("Main"):
		var data = DataStorage.gameData["Main"]
		intro = data["intro"]
		slotName1 = data["slotName1"]
		slotStage1 = data["slotStage1"]
		slotName2 = data["slotName2"]
		slotStage2 = data["slotStage2"]
		$TopRockLayer/TeaLily2.visible = data["teaLily2"]
		$TopRockLayer/TeaLily3.visible = data["teaLily3"]
		bodyDiscovered = data["bodyDiscovered"]
	if intro != 0:
		$AnimationPlayer.play("load")
	
	
func dataSave():
	DataStorage.gameData["Main"] = {
		"intro" : intro,
		"slotName1" : slotName1,
		"slotStage1" : slotStage1,
		"slotName2" : slotName2,
		"slotStage2" : slotStage2,
		"teaLily2" : $TopRockLayer/TeaLily2.visible,
		"teaLily3" : $TopRockLayer/TeaLily3.visible,
		"bodyDiscovered" : bodyDiscovered
	}


func _on_Slot1_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	UniversalFunctions.actions(Vector2(201,148),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
	yield($Actions,"pressed")
	if $Actions.selected == "Look":
		if slotName1 != null:
			UniversalFunctions.play_dialogue_JSON(slotName1+str(DataStorage.stage-slotStage1))
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("placeable")
			yield($Dialogue, "done")
	elif $Actions.selected == "Use":
		UniversalFunctions.use(["driftWormBait","isopodRadiodontBait","lacemouthBait","bigBoyPikaiidBait"])
		yield(UniversalFunctions,"ran")
		if $Bag.currentItem != null:
			if $Bag.currentItem == "cancel":
				UniversalFunctions.play_dialogue_JSON("takeCancel")
				yield($Dialogue, "done")
				return
			if slotName1 != null:
				get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).visible = false
				if $crackerEurypterid1.visible == true:
					$crackerEurypterid1.visible = false
					UniversalFunctions.play_dialogue_JSON("crackerEurypteridLeaves")
					yield($Dialogue, "done")
				elif $wiggleTrilobite1.visible == true:
					$wiggleTrilobite1.visible = false
					UniversalFunctions.play_dialogue_JSON("wiggleTrilobiteLeaves")
					yield($Dialogue, "done")
			slotStage1 = DataStorage.stage
			slotName1 = $Bag.currentItem
			UniversalFunctions.place([get_tree().get_root().get_node_or_null("/root/world/Slot1/"+$Bag.currentItem)], $Bag.currentItem)
			UniversalFunctions.play_dialogue_JSON($Bag.currentItem+"Place")
			yield($Dialogue, "done")
			$Bag.currentItem = null
		else:
			UniversalFunctions.play_dialogue_JSON("badBait")
			yield($Dialogue, "done")


func _on_Slot2_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	
	UniversalFunctions.actions(Vector2(133,161),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
	yield($Actions,"pressed")
	if $Actions.selected == "Look":
		if slotName2 != null:
			UniversalFunctions.play_dialogue_JSON(slotName2+str(DataStorage.stage-slotStage2))
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("placeable")
			yield($Dialogue, "done")
	elif $Actions.selected == "Use":
		UniversalFunctions.use(["driftWormBait","isopodRadiodontBait","lacemouthBait","bigBoyPikaiidBait"])
		yield(UniversalFunctions,"ran")
		if $Bag.currentItem != null:
			if $Bag.currentItem == "cancel":
				UniversalFunctions.play_dialogue_JSON("takeCancel")
				yield($Dialogue, "done")
				return
			if slotName2 != null:
				get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).visible = false
				if $crackerEurypterid2.visible == true:
					$crackerEurypterid2.visible = false
					UniversalFunctions.play_dialogue_JSON("crackerEurypteridLeaves")
					yield($Dialogue, "done")
				elif $wiggleTrilobite2.visible == true:
					$wiggleTrilobite2.visible = false
					UniversalFunctions.play_dialogue_JSON("wiggleTrilobiteLeaves")
					yield($Dialogue, "done")
			slotStage2 = DataStorage.stage
			slotName2 = $Bag.currentItem
			UniversalFunctions.place([get_tree().get_root().get_node_or_null("/root/world/Slot2/"+$Bag.currentItem)], $Bag.currentItem)
			UniversalFunctions.play_dialogue_JSON($Bag.currentItem+"Place")
			yield($Dialogue, "done")
			$Bag.currentItem = null
		else:
			UniversalFunctions.play_dialogue_JSON("badBait")
			yield($Dialogue, "done")


func _on_Bag_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.cutscene = true
	$Bag.update()
	$Bag/Tablet.set_text()
	$BagIcon.set_material(null)
	$Bag.visible = true
	$BagIcon.visible = false
	$Radio.visible = false

func _on_Corpse_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("body")


func _on_TeaLily_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.stage == 0:
		UniversalFunctions.play_dialogue_JSON("teaLilyLook")
		yield($Dialogue, "done")
	else: 
		if DataStorage.observedSpecies["teaLily"] == 1:
			if $TopRockLayer/TeaLily3.visible == true and $TopRockLayer/TeaLily2.visible == true:
				UniversalFunctions.actions(Vector2(43,75),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
				yield($Actions,"pressed")
				if $Actions.selected == "Look":
					UniversalFunctions.play_dialogue_JSON("teaLilyLook1")
					yield($Dialogue, "done")
				elif $Actions.selected == "Take":
					UniversalFunctions.pick_up([$TopRockLayer/TeaLily2], "teaLilyCup")
					UniversalFunctions.play_dialogue_JSON("teaLilyCupTake")
					yield($Dialogue, "done")
					slotName1 = "veinerWorm"
					slotStage1 = DataStorage.stage
					$Slot1.visible = true
					$Slot1/slotButon.visible = false
					$Slot1/veinerWorm.visible = true
			else:
				UniversalFunctions.play_dialogue_JSON("teaLilyLook1")
				yield($Dialogue, "done")
				
		else:
				UniversalFunctions.play_dialogue_JSON("teaLilyLook0")
				yield($Dialogue, "done")
				DataStorage.observedSpecies["teaLily"] = 1
				DataStorage.observedSpecies["veinerWorm"] = 1
				DataStorage.observedSpecies["teaCupPikaiid"] = 1
		


func _on_TeaLily1_pressed():
	
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.stage == 0:
		UniversalFunctions.play_dialogue_JSON("teaLilyLook")
		yield($Dialogue, "done")
	else: 
		if DataStorage.observedSpecies["teaLily"] == 1:
			if $TopRockLayer/TeaLily3.visible == true and $TopRockLayer/TeaLily2.visible == true:
				UniversalFunctions.actions(Vector2(174,75),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
				yield($Actions,"pressed")
				if $Actions.selected == "Look":
					UniversalFunctions.play_dialogue_JSON("teaLilyLook1")
					yield($Dialogue, "done")
				elif $Actions.selected == "Take":
					UniversalFunctions.pick_up([$TopRockLayer/TeaLily3], "teaLilyCup")
					UniversalFunctions.play_dialogue_JSON("teaLilyCupTake")
					yield($Dialogue, "done")
					$Slot1.visible = true
					$Slot1/slotButon.visible = false
					slotName1 = "veinerWorm"
					slotStage1 = DataStorage.stage
					$Slot1/veinerWorm.visible = true
			else:
				UniversalFunctions.play_dialogue_JSON("teaLilyLook1")
				yield($Dialogue, "done")
		else:
				UniversalFunctions.play_dialogue_JSON("teaLilyLook0")
				yield($Dialogue, "done")
				DataStorage.observedSpecies["teaLily"] = 1
				DataStorage.observedSpecies["veinerWorm"] = 1
				DataStorage.observedSpecies["teaCupPikaiid"] = 1


func _on_parasite_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("veinerWormLook"+ str(DataStorage.observedSpecies["veinerWorm"]))


func _on_pikaia_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("teaCupPikaiidLook"+ str(DataStorage.observedSpecies["teaCupPikaiid"]))


func _on_droppedWorm_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("veinerWorm"+str(DataStorage.stage - slotStage1))
	yield($Dialogue, "done")
	if DataStorage.observedSpecies["veinerWorm"] == 1 and DataStorage.stage - slotStage1 == 0:
		UniversalFunctions.play_dialogue_JSON("veinerWormDropped0Add")
		DataStorage.observedSpecies["veinerWorm"] = 2




func _on_pond_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	dataSave()
	if $Background/Arthrocaris.visible == true:
		UniversalFunctions.play_dialogue_JSON("arthrocarisSqueezePast")
		yield($Dialogue, "done")
	UniversalFunctions.move("res://Rooms/Pond.tscn")


func _on_door_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	dataSave()
	UniversalFunctions.move("res://Rooms/RestingRoom.tscn")


func _on_isopodRadiodont_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	if DataStorage.observedSpecies.has("isopodRadiodont") == false:
		UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["isopodRadiodont"] = 0
	else: 
		var counter = 0
		for i in DataStorage.inventory:
			if i == "isopodRadiodontBait":
				counter += 1
		if counter < 2:
				UniversalFunctions.actions(Vector2(201,148),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
				yield($Actions,"pressed")
				if $Actions.selected == "Look":
					UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook1")
					yield($Dialogue, "done")
				elif $Actions.selected == "Take":
					if $isopodRadiodont1/isopodRadiodont.visible == true:
						UniversalFunctions.pick_up([$isopodRadiodont1/isopodRadiodont], "isopodRadiodontBait")
					else:
						UniversalFunctions.pick_up([$isopodRadiodont1/isopodRadiodont1], "isopodRadiodontBait")
					UniversalFunctions.play_dialogue_JSON("isopodRadiodontTake")
					yield($Dialogue, "done")
					if DataStorage.observedSpecies["isopodRadiodont"] == 0:
						DataStorage.observedSpecies["isopodRadiodont"] = 1
						UniversalFunctions.play_dialogue_JSON("newData")
						yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook1")
			yield($Dialogue, "done")


func _on_isopodRadiodont2_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	if DataStorage.observedSpecies.has("isopodRadiodont") == false:
		UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["isopodRadiodont"] = 0
	else: 
		var counter = 0
		for i in DataStorage.inventory:
			if i == "isopodRadiodontBait":
				counter += 1
		if counter < 2:
				UniversalFunctions.actions(Vector2(129,162),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
				yield($Actions,"pressed")
				if $Actions.selected == "Look":
					UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook1")
					yield($Dialogue, "done")
				elif $Actions.selected == "Take":
					if $isopodRadiodont2/isopodRadiodont.visible == true:
						UniversalFunctions.pick_up([$isopodRadiodont2/isopodRadiodont], "isopodRadiodontBait")
					else:
						UniversalFunctions.pick_up([$isopodRadiodont2], "isopodRadiodontBait")
					UniversalFunctions.play_dialogue_JSON("isopodRadiodontTake")
					yield($Dialogue, "done")
					if DataStorage.observedSpecies["isopodRadiodont"] == 0:
						DataStorage.observedSpecies["isopodRadiodont"] = 1
						UniversalFunctions.play_dialogue_JSON("newData")
						yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("isopodRadiodontLook1")
			yield($Dialogue, "done")



func _on_crackerEurypterid2_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	if DataStorage.observedSpecies.has("crackerEurypterid") == false:
		UniversalFunctions.play_dialogue_JSON("crackerEurypteridLook0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["crackerEurypterid"] = 1
		return
	UniversalFunctions.play_dialogue_JSON("crackerEurypteridLook1")
	yield($Dialogue, "done")
		


func _on_crackerEurypterid_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
		
	if DataStorage.observedSpecies.has("crackerEurypterid") == false:
		UniversalFunctions.play_dialogue_JSON("crackerEurypteridLook0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["crackerEurypterid"] = 0
		return
	else:
		UniversalFunctions.play_dialogue_JSON("crackerEurypteridLook1")
		yield($Dialogue, "done")



func _on_arthrocaris_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	UniversalFunctions.play_dialogue_JSON("arthrocarisLook")
	yield($Dialogue, "done")


func _on_wiggleTrilobite_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
		
	if DataStorage.observedSpecies.has("wiggleTrilobite") == false:
		UniversalFunctions.play_dialogue_JSON("wiggleTrilobiteLook0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["wiggleTrilobite"] = 0
	else:
		UniversalFunctions.play_dialogue_JSON("wiggleTrilobiteLook1")
		yield($Dialogue, "done")

