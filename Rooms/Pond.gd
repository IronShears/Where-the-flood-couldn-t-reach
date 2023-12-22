extends Node2D

var intro = 0
var slotName1
var slotStage1
var slotName2
var slotStage2
var slotName3
var slotStage3
var guyTaken


# Called when the node enters the scene tree for the first time.
func _ready():
	$Filter.visible = DataStorage.filter
	$Exit.set_text(">"+UniversalFunctions.dialogueJson["exit"])
	$Contemplate/Yes.set_text(">"+UniversalFunctions.dialogueJson["yes"])
	$Contemplate/No.set_text(">"+UniversalFunctions.dialogueJson["no"])
	$Contemplate/text.set_bbcode(UniversalFunctions.dialogueJson["enterCave"])
	$Cursor.position = get_global_mouse_position()
	dataLoad()
	
	
	if DataStorage.slotsVisible == true:
		$Slot1.visible = true
		$Slot2.visible = true
		$Slot3.visible = true
		
	
	if DataStorage.stage == 5:
		$Slot1/slotButon.visible = false
		$Slot2/slotButon.visible = false
		$Slot3/slotButon.visible = false
	
	if slotStage1 != null:
		if DataStorage.stage-slotStage1 ==0 or DataStorage.stage-slotStage1== 1:
			get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).play(slotName1+str(DataStorage.stage-slotStage1))
			get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).visible = true
		else:
			slotStage1 = null
			slotName1 = null
		if slotStage1 != null:
			if DataStorage.stage-slotStage1 == 1:
				if slotName1 == "driftWormBait":
					if DataStorage.inventory.has("lacemouthBait") == false:
						$lacemouth.visible = true
						$lacemouthHighlight.visible = true
						$lacemouthMidlight.visible = true
					$lacemouth2.visible = true
					$lacemouth2Highlight.visible = true
					$lacemouth2Midlight.visible = true
				elif slotName1 == "isopodRadiodontBait":
					$slugPikaiid.visible = true
					$slugPikaiidMidlight.visible = true
					$slugPikaiidHighlight.visible = true
					$graptolite.visible = true
					$graptoliteHighlight.visible = true
					$graptoliteMidlight.visible = true
				elif slotName1 == "lacemouthBait":
					if guyTaken != true:
						$bigBoyPikaiid.visible = true
						$bigBoyPikaiidMidlight.visible = true
						$bigBoyPikaiidHighlight.visible = true


	if slotStage2 != null:
		if DataStorage.stage-slotStage2 ==0 or DataStorage.stage-slotStage2 ==1:
			get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).play(slotName2+str(DataStorage.stage-slotStage2))
			get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).visible = true
		else:
			slotStage2 = null
			slotName2 = null
		if slotStage2 != null:
			if DataStorage.stage-slotStage2 == 1:
				if slotName2 == "driftWormBait":
					if DataStorage.inventory.has("lacemouthBait") == false:
						$lacemouth.visible = true
						$lacemouthHighlight.visible = true
						$lacemouthMidlight.visible = true
					$lacemouth2.visible = true
					$lacemouth2Highlight.visible = true
					$lacemouth2Midlight.visible = true
				elif slotName2 == "isopodRadiodontBait":
					$slugPikaiid2.visible = true
					$slugPikaiid2Midlight.visible = true
					$slugPikaiid2Highlight.visible = true
					$graptolite.visible = true
					$graptoliteHighlight.visible = true
					$graptoliteMidlight.visible = true
				elif slotName2 == "lacemouthBait":
					if slotName1 != "lacemouthBait":
						if guyTaken != true:
							$bigBoyPikaiid2.visible = true
							$bigBoyPikaiid2Midlight.visible = true
							$bigBoyPikaiid2Highlight.visible = true


	if slotStage3 != null:
		if DataStorage.stage-slotStage3 ==0 or DataStorage.stage-slotStage3 ==1:
			get_tree().get_root().get_node_or_null("/root/world/Slot3/"+slotName3).play(slotName3+str(DataStorage.stage-slotStage3))
			get_tree().get_root().get_node_or_null("/root/world/Slot3/"+slotName3).visible = true
		else:
			slotStage3 = null
			slotName3 = null
		if slotStage3 != null:
			if DataStorage.stage-slotStage3 == 1:
				if slotName3 == "driftWormBait":
					if DataStorage.inventory.has("lacemouthBait") == false:
						$lacemouth.visible = true
						$lacemouthHighlight.visible = true
						$lacemouthMidlight.visible = true
					$lacemouth2.visible = true
					$lacemouth2Highlight.visible = true
					$lacemouth2Midlight.visible = true
				elif slotName3 == "isopodRadiodontBait":
					$slugPikaiid3.visible = true
					$slugPikaiid3Midlight.visible = true
					$slugPikaiid3Highlight.visible = true
					$graptolite.visible = true
					$graptoliteHighlight.visible = true
					$graptoliteMidlight.visible = true
				elif slotName3 == "lacemouthBait":
					if slotName1 != "lacemouthBait" and slotName2 != "lacemouthBait":
						if guyTaken != true:
							$bigBoyPikaiid3.visible = true
							$bigBoyPikaiid3Midlight.visible = true
							$bigBoyPikaiid3Highlight.visible = true
			
			
		
	if intro == 0 and DataStorage.gameData.has("Rest") == false:
		yield($AnimationPlayer,"animation_finished")
		UniversalFunctions.play_dialogue_JSON("pondIntro")
		intro = 1

func dataLoad():
	UniversalFunctions.update()
	if DataStorage.gameData.has("Pond"):
		var data = DataStorage.gameData["Pond"]
		intro = data["intro"]
		slotName1 = data["slotName1"]
		slotStage1 = data["slotStage1"]
		slotName2 = data["slotName2"]
		slotStage2 = data["slotStage2"]
		slotName3 = data["slotName3"]
		slotStage3 = data["slotStage3"]
		guyTaken = data["guyTaken"]
	$AnimationPlayer.play("load")
	
	
func dataSave():
	DataStorage.gameData["Pond"] = {
		"intro" : intro,
		"slotName1" : slotName1,
		"slotStage1" : slotStage1,
		"slotName2" : slotName2,
		"slotStage2" : slotStage2,
		"slotName3" : slotName3,
		"slotStage3" : slotStage3,
		"guyTaken" : guyTaken
	}



func _on_Slot1_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	
	
	UniversalFunctions.actions(Vector2(144,154),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
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
			if $Bag.currentItem == "bigBoyPikaiidBait":
				guyTaken = false
				if slotName1 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName2 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName3 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				else:
					if slotName1 != null:
						UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName3 != null:
						UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName2 != null:
						UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					else:
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitEscape")
						yield($Dialogue, "done")
						return
			elif $Bag.currentItem == "cancel":
				UniversalFunctions.play_dialogue_JSON("takeCancel")
				yield($Dialogue, "done")
				return
			if slotName1 != null:
				get_tree().get_root().get_node_or_null("/root/world/Slot1/"+slotName1).visible = false
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
	
	
	
	UniversalFunctions.actions(Vector2(184,109),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
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
			if $Bag.currentItem == "bigBoyPikaiidBait":
				guyTaken = false
				if slotName2 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName3 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName1 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				else:
					if slotName2 != null:
						UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName3 != null:
						UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName1 != null:
						UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					else:
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitEscape")
						yield($Dialogue, "done")
						return
			elif $Bag.currentItem == "cancel":
				UniversalFunctions.play_dialogue_JSON("takeCancel")
				yield($Dialogue, "done")
				return
			if slotName2 != null:
				get_tree().get_root().get_node_or_null("/root/world/Slot2/"+slotName2).visible = false
			slotStage2 = DataStorage.stage
			slotName2 = $Bag.currentItem
			UniversalFunctions.place([get_tree().get_root().get_node_or_null("/root/world/Slot2/"+$Bag.currentItem)], $Bag.currentItem)
			UniversalFunctions.play_dialogue_JSON($Bag.currentItem+"Place")
			yield($Dialogue, "done")
			$Bag.currentItem = null
		else:
			UniversalFunctions.play_dialogue_JSON("badBait")
			yield($Dialogue, "done")


func _on_Slot3_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	
	
	UniversalFunctions.actions(Vector2(169,62),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
	yield($Actions,"pressed")
	if $Actions.selected == "Look":
		if slotName3 != null:
			UniversalFunctions.play_dialogue_JSON(slotName3+str(DataStorage.stage-slotStage3))
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("placeable")
			yield($Dialogue, "done")
	elif $Actions.selected == "Use":
		UniversalFunctions.use(["driftWormBait","isopodRadiodontBait","lacemouthBait","bigBoyPikaiidBait"])
		yield(UniversalFunctions,"ran")
		if $Bag.currentItem != null:
			if $Bag.currentItem == "bigBoyPikaiidBait":
				guyTaken = false
				if slotName3 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName1 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				elif slotName2 == "lacemouthBait":
					UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
					yield($Dialogue, "done")
					return
				else:
					if slotName3 != null:
						UniversalFunctions.place([$bigBoyPikaiid3Midlight,$bigBoyPikaiid3,$bigBoyPikaiid3Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName1 != null:
						UniversalFunctions.place([$bigBoyPikaiidMidlight,$bigBoyPikaiid,$bigBoyPikaiidHighlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					elif slotName2 != null:
						UniversalFunctions.place([$bigBoyPikaiid2Midlight,$bigBoyPikaiid2,$bigBoyPikaiid2Highlight], $Bag.currentItem)
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitNull")
						yield($Dialogue, "done")
						return
					else:
						UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidBaitEscape")
						yield($Dialogue, "done")
						return
			elif $Bag.currentItem == "cancel":
				UniversalFunctions.play_dialogue_JSON("takeCancel")
				yield($Dialogue, "done")
				return
					
			if slotName3 != null:
				get_tree().get_root().get_node_or_null("/root/world/Slot3/"+slotName3).visible = false
			slotStage3 = DataStorage.stage
			slotName3 = $Bag.currentItem
			UniversalFunctions.place([get_tree().get_root().get_node_or_null("/root/world/Slot3/"+$Bag.currentItem)], $Bag.currentItem)
			UniversalFunctions.play_dialogue_JSON($Bag.currentItem+"Place")
			yield($Dialogue, "done")
			$Bag.currentItem = null
		else:
			UniversalFunctions.play_dialogue_JSON("badBait")
			yield($Dialogue, "done")






func _on_bagicon_pressed():
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

func _on_Exit_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	dataSave()
	UniversalFunctions.move("res://Rooms/MainRoom.tscn")

func _on_Algae_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	
	if DataStorage.observedSpecies.has("mochiDonutGraptolite"):
		if $Cursor.position.y > 114:
			UniversalFunctions.actions(Vector2(257,153),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
		else:
			UniversalFunctions.actions(Vector2(52,49),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
		yield($Actions,"pressed")
		if $Actions.selected == "Look":
			if DataStorage.cavesDiscovered == false:
				UniversalFunctions.play_dialogue_JSON("algaeLook0")
				yield($Dialogue, "done")
			else:
				UniversalFunctions.play_dialogue_JSON("algaeLook1")
				yield($Dialogue, "done")
		elif $Actions.selected == "Take":
			if DataStorage.cavesDiscovered == false:
				UniversalFunctions.play_dialogue_JSON("cavesDiscover")
				yield($Dialogue, "done")
				DataStorage.cavesDiscovered = true
				DataStorage.observedSpecies["mochiDonutGraptolite"] = 1
				if DataStorage.observedSpecies.has("arthrocaris"):
					DataStorage.observedSpecies["arthrocaris"] = 1
			else:
				UniversalFunctions.play_dialogue_JSON("cavesDiscoverContemplate")
				yield($Dialogue, "done")
				$Contemplate.visible = true
				yield($Contemplate, "pressed")
				$Contemplate.visible = false
				if $Contemplate.selected == true:
					$AnimationPlayer.play_backwards("load")
					UniversalFunctions.play_dialogue_JSON("algaeEnding")
					yield($Dialogue, "done")
					DataStorage.ending = 4
					$Contemplate.visible = false
					get_tree().change_scene("res://Components/Credits.tscn")
				else:
					UniversalFunctions.play_dialogue_JSON("cavesRestraint")
					yield($Dialogue, "done")
					$Contemplate.visible = false
	else:
		UniversalFunctions.play_dialogue_JSON("algaeLook0")

func _on_DriftWorm_pressed(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.slotsVisible == true:
		var counter = 0
		for i in DataStorage.inventory:
			if i == "driftWormBait":
				counter += 1
		if counter < 2:
			UniversalFunctions.actions(node.position,[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
			yield($Actions,"pressed")
			if $Actions.selected == "Look":
				UniversalFunctions.play_dialogue_JSON("driftWorm1Look")
				yield($Dialogue, "done")
			elif $Actions.selected == "Take":
				UniversalFunctions.pick_up([node, get_tree().get_root().get_node_or_null("/root/world/"+node.name+"Midlight"), get_tree().get_root().get_node_or_null("/root/world/"+node.name+"Highlight")], "driftWormBait")
				if DataStorage.observedSpecies["driftWorm"] == 0:
					UniversalFunctions.play_dialogue_JSON("driftWormTakeFirst")
					yield($Dialogue, "done")
				UniversalFunctions.play_dialogue_JSON("driftWormTake")
				yield($Dialogue, "done")
				if DataStorage.observedSpecies["driftWorm"] == 0:
					UniversalFunctions.play_dialogue_JSON("newData")
					yield($Dialogue, "done")
					DataStorage.observedSpecies["driftWorm"] = 1
		else:
			UniversalFunctions.play_dialogue_JSON("driftWorm1Look")
			yield($Dialogue, "done")
			
	else:
		UniversalFunctions.play_dialogue_JSON("driftWorm0")


func _on_knifePikaiid_pressed(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.slotsVisible == true:
		UniversalFunctions.actions(Vector2(node.position.x+16, node.position.y+3),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
		yield($Actions,"pressed")
		if $Actions.selected == "Look":
			UniversalFunctions.play_dialogue_JSON("letterBonePikaiid1Look")
			yield($Dialogue, "done")
		elif $Actions.selected == "Take":
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var randomX = rng.randf_range(0, 300)
			rng.randomize()
			var randomY = rng.randf_range(0, 200)
			node.coords = Vector2(int(randomX),int(randomY))
			node.speed = 80
			$SoundEffects.stream = load("res://Sounds/Splash.wav")
			$SoundEffects.play()
			UniversalFunctions.play_dialogue_JSON("letterBonePikaiidTake")
			yield($Dialogue, "done")
	else:
		UniversalFunctions.play_dialogue_JSON("letterBonePikaiid0")


func _on_crabTrapCrinoid2_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.observedSpecies.has("lacemouth") and DataStorage.inventory.has("lacemouthBait") == false and $lacemouth.visible == true:
		UniversalFunctions.actions(Vector2(253, 103),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
		yield($Actions,"pressed")
		if $Actions.selected == "Look":
			UniversalFunctions.play_dialogue_JSON("crabTrapCrinoid2Look")
			yield($Dialogue, "done")
		elif $Actions.selected == "Use":
			UniversalFunctions.play_dialogue_JSON("crabTrapCrinoid2Use")
			yield($Dialogue, "done")
	else:
		UniversalFunctions.play_dialogue_JSON("crabTrapCrinoidLook")


func _on_crabTrapCrinoid_pressed():
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
		

	if $Highlight/Viewport/YSort/crabTrapCrinoid/Trapped.visible == true:
		UniversalFunctions.pick_up([$Highlight/Viewport/YSort/crabTrapCrinoid/Trapped,$Midlight/Viewport/YSort/crabTrapCrinoid/Trapped,$ViewportContainer/Viewport/YSort2/crabTrapCrinoid/Trapped],"lacemouthBait")
		DataStorage.inventory.append("lacemouthBait")
		UniversalFunctions.play_dialogue_JSON("lacemouthTake1")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["crabTrapCrinoid"] = 1
		DataStorage.observedSpecies["letterBonePikaiid"] = 1
		DataStorage.observedSpecies["lacemouth"] = 1
		UniversalFunctions.play_dialogue_JSON("newData")
		yield($Dialogue, "done")
		return

	if DataStorage.observedSpecies.has("lacemouth") and DataStorage.inventory.has("lacemouthBait") == false and $lacemouth.visible == true:
		UniversalFunctions.actions(Vector2(62, 125),[$Actions/ActionRing/Look, $Actions/ActionRing/Use])
		yield($Actions,"pressed")
		if $Actions.selected == "Look":
			UniversalFunctions.play_dialogue_JSON("crabTrapCrinoid1Look")
			yield($Dialogue, "done")
		elif $Actions.selected == "Use":
			UniversalFunctions.use(["driftWormBait","isopodRadiodontBait","lacemouthBait","bigBoyPikaiidBait"])
			yield(UniversalFunctions,"ran")
			if $Bag.currentItem == "driftWormBait":
				UniversalFunctions.place([$Midlight/Viewport/YSort/crabTrapCrinoid/DriftWormCageBait], $Bag.currentItem)
				UniversalFunctions.play_dialogue_JSON("crabTrapCrinoid1Use")
				yield($Dialogue, "done")
			else:
				if $Bag.currentItem == "isopodRadiodontBait":
					UniversalFunctions.play_dialogue_JSON("crabTrapCrinoidTooSmall")
					yield($Dialogue, "done")
				elif $Bag.currentItem == "lacemouthBait" or $Bag.currentItem == "bigBoyPikaiidBait":
					UniversalFunctions.play_dialogue_JSON("crabTrapCrinoidTooLarge")
					yield($Dialogue, "done")
				else:
					UniversalFunctions.play_dialogue_JSON("badBait")
					yield($Dialogue, "done")
			$Bag.currentItem = null
					
	else:
		UniversalFunctions.play_dialogue_JSON("crabTrapCrinoidLook")




func _on_lacemouth_enter_trap():
	$lacemouth.visible = false
	$lacemouthMidlight.visible = false
	$lacemouthHighlight.visible = false
	$Highlight/Viewport/YSort/crabTrapCrinoid/Trapped.visible = true
	$Midlight/Viewport/YSort/crabTrapCrinoid/Trapped.visible = true
	$ViewportContainer/Viewport/YSort2/crabTrapCrinoid/Trapped.visible = true
	$Highlight/Viewport/YSort/crabTrapCrinoid/Trapped.play("default")
	$Midlight/Viewport/YSort/crabTrapCrinoid/Trapped.play("default")
	$ViewportContainer/Viewport/YSort2/crabTrapCrinoid/Trapped.play("default")
	UniversalFunctions.cutscene = false
	


func _on_lacemouth_pressed_data(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
		
	if DataStorage.observedSpecies.has("lacemouth") == true:
		if DataStorage.inventory.has("lacemouthBait") == false:
			UniversalFunctions.actions(node.position,[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
			yield($Actions,"pressed")
			if $Actions.selected == "Look":
				UniversalFunctions.play_dialogue_JSON("lacemouthLook1")
				yield($Dialogue, "done")
			elif $Actions.selected == "Take":
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				var randomX = rng.randf_range(0, 300)
				rng.randomize()
				var randomY = rng.randf_range(0, 200)
				node.coords = Vector2(int(randomX),int(randomY))
				node.speed = 80
				$SoundEffects.stream = load("res://Sounds/Splash.wav")
				$SoundEffects.play()
				UniversalFunctions.play_dialogue_JSON("lacemouthTake0")
				yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("lacemouthLook1")
			yield($Dialogue, "done")
	else:
		UniversalFunctions.play_dialogue_JSON("lacemouthLook0")
		DataStorage.observedSpecies["lacemouth"] = 0


func _on_graptolite_pressed_data(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.observedSpecies.has("mochiDonutGraptolite") == true:
		UniversalFunctions.play_dialogue_JSON("graptolite1")
		yield($Dialogue, "done")
	else:
		UniversalFunctions.play_dialogue_JSON("graptolite0")
		yield($Dialogue, "done")
		DataStorage.observedSpecies["mochiDonutGraptolite"] = 0


func _on_slugPikaiid_pressed_data(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
	if DataStorage.observedSpecies.has("slugPikaiid") == true:
		if DataStorage.observedSpecies.has("bigBoyPikaiid"):
			UniversalFunctions.play_dialogue_JSON("slugPikaiid1Late")
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("slugPikaiid1")
			yield($Dialogue, "done")
	else:
		if DataStorage.observedSpecies.has("bigBoyPikaiid"):
			UniversalFunctions.play_dialogue_JSON("slugPikaiid0Late")
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("slugPikaiid0")
			yield($Dialogue, "done")
		DataStorage.observedSpecies["lesserSlugPikaiid"] = 0
		DataStorage.observedSpecies["slugPikaiid"] = 0

func _on_giantPikaiid_pressed_data(node):
	if UniversalFunctions.cutscene == true:
		return
	if $AnimationPlayer.is_playing() == true:
		return
		
	if DataStorage.observedSpecies.has("bigBoyPikaiid") == true:
		if DataStorage.inventory.has("bigBoyPikaiidBait") == false:
			UniversalFunctions.actions(Vector2(node.position.x+46, node.position.y+24),[$Actions/ActionRing/Look, $Actions/ActionRing/Take])
			yield($Actions,"pressed")
			if $Actions.selected == "Look":
				if DataStorage.observedSpecies.has("slugPikaiid") == true:
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook1")
					yield($Dialogue, "done")
				else:
					UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook1Unique")
					yield($Dialogue, "done")
			elif $Actions.selected == "Take":
				guyTaken = true
				UniversalFunctions.pick_up([node, get_tree().get_root().get_node_or_null("/root/world/"+node.name+"Midlight"), get_tree().get_root().get_node_or_null("/root/world/"+node.name+"Highlight")], "bigBoyPikaiidBait")
				UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidTake")
				yield($Dialogue, "done")
		else:
			if DataStorage.observedSpecies.has("slugPikaiid") == true:
				UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook1")
				yield($Dialogue, "done")
			else:
				UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook1Unique")
				yield($Dialogue, "done")
	else:
		UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook0")
		yield($Dialogue, "done")
		if DataStorage.observedSpecies.has("slugPikaiid") == true:
			UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLookAdd")
			yield($Dialogue, "done")
		if DataStorage.cavesDiscovered == false:
			UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook0EndNoDiscovery")
			yield($Dialogue, "done")
		else:
			UniversalFunctions.play_dialogue_JSON("bigBoyPikaiidLook0EndDiscovery")
			yield($Dialogue, "done")
			
		DataStorage.observedSpecies["bigBoyPikaiid"] = 0
		DataStorage.observedSpecies["bigBoySlugPikaiid"] = 0


