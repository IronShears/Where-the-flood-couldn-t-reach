extends Node2D
signal go

func _ready():
	set_text()
	
func _unhandled_key_input(_event):
	if Input.is_action_pressed("ui_cancel"):
			_on_BackButton_pressed()
	
func set_text():
	$MainScreen/VBoxContainer/Title.set_bbcode(UniversalFunctions.dialogueJson["scpTitle"])
	var textUpdate
	if DataStorage.ending == 0:
		textUpdate = UniversalFunctions.dialogueJson["scpText"]
	else:
		textUpdate = UniversalFunctions.dialogueJson["scpTextEnding"]
		textUpdate = textUpdate.replace("{ending}", UniversalFunctions.dialogueJson["endingText" + str(DataStorage.ending)])
		if DataStorage.ending == 3:
			textUpdate = textUpdate.replace("{number}", DataStorage.observedSpecies.size()-6)
			textUpdate = textUpdate.replace("{cave}", UniversalFunctions.dialogueJson["caveEnd"+str(DataStorage.cavesDiscovered)])
	textUpdate = textUpdate.replace("{species}", DataStorage.observedSpecies.size()+1)
	if DataStorage.cavesDiscovered == true:
		textUpdate = textUpdate.replace("{cavesDiscovered}", UniversalFunctions.dialogueJson["cavesDiscovered"])
		textUpdate = textUpdate.replace("{energySource}", UniversalFunctions.dialogueJson["energySource1"])
	else:
		textUpdate = textUpdate.replace("{cavesDiscovered}", "")
		textUpdate = textUpdate.replace("{energySource}", UniversalFunctions.dialogueJson["energySource0"])
		
	$MainScreen/VBoxContainer/Text.set_bbcode(textUpdate)
	$MainScreen/VBoxContainer/describedSpecies.set_bbcode(UniversalFunctions.dialogueJson["describedSpecies"])
	$MainScreen/VBoxContainer/crinoids.set_bbcode(UniversalFunctions.dialogueJson["crinoids"])
	$MainScreen/VBoxContainer/hemichordates.set_bbcode(UniversalFunctions.dialogueJson["hemichordates"])
	$MainScreen/VBoxContainer/chordates.set_bbcode(UniversalFunctions.dialogueJson["chordates"])
	$MainScreen/VBoxContainer/arthropods.set_bbcode(UniversalFunctions.dialogueJson["arthropods"])
	
	$MainScreen/VBoxContainer/teaLily.set_text(">"+UniversalFunctions.dialogueJson["teaLilyName"])
	$MainScreen/VBoxContainer/crabTrapCrinoid.set_text(">"+UniversalFunctions.dialogueJson["crabTrapCrinoidName"])
	$MainScreen/VBoxContainer/veinerWorm.set_text(">"+UniversalFunctions.dialogueJson["veinerWormName"])
	$MainScreen/VBoxContainer/driftWorm.set_text(">"+UniversalFunctions.dialogueJson["driftWormName"])
	$MainScreen/VBoxContainer/teaCupPikaiid.set_text(">"+UniversalFunctions.dialogueJson["teaCupPikaiidName"])
	$MainScreen/VBoxContainer/letterBonePikaiid.set_text(">"+UniversalFunctions.dialogueJson["letterBonePikaiidName"])
	if DataStorage.observedSpecies.has("isopodRadiodont"):
		$MainScreen/VBoxContainer/arthropods.visible = true
		$MainScreen/VBoxContainer/isopodRadiodont.set_text(">"+UniversalFunctions.dialogueJson["isopodRadiodontName"])
		$MainScreen/VBoxContainer/isopodRadiodont.visible = true
	if DataStorage.observedSpecies.has("crackerEurypterid"):
		$MainScreen/VBoxContainer/arthropods.visible = true
		$MainScreen/VBoxContainer/crackerEurypterid.set_text(">"+UniversalFunctions.dialogueJson["crackerEurypteridName"])
		$MainScreen/VBoxContainer/crackerEurypterid.visible = true
	if DataStorage.observedSpecies.has("lacemouth"):
		$MainScreen/VBoxContainer/lacemouth.set_text(">"+UniversalFunctions.dialogueJson["lacemouthName"])
		$MainScreen/VBoxContainer/lacemouth.visible = true
	if DataStorage.observedSpecies.has("mochiDonutGraptolite"):
		$MainScreen/VBoxContainer/mochiDonutGraptolite.set_text(">"+UniversalFunctions.dialogueJson["mochiDonutGraptoliteName"])
		$MainScreen/VBoxContainer/mochiDonutGraptolite.visible = true
	if DataStorage.observedSpecies.has("wiggleTrilobite"):
		$MainScreen/VBoxContainer/wiggleTrilobite.set_text(">"+UniversalFunctions.dialogueJson["wiggleTrilobiteName"])
		$MainScreen/VBoxContainer/wiggleTrilobite.visible = true
	if DataStorage.observedSpecies.has("slugPikaiid"):
		if DataStorage.observedSpecies.has("bigBoyPikaiid"):
			$MainScreen/VBoxContainer/lesserSlugPikaiid.set_text(">"+UniversalFunctions.dialogueJson["lesserSlugPikaiidName"])
			$MainScreen/VBoxContainer/lesserSlugPikaiid.visible = true
			$MainScreen/VBoxContainer/slugPikaiid.visible = false
		else:
			$MainScreen/VBoxContainer/slugPikaiid.set_text(">"+UniversalFunctions.dialogueJson["slugPikaiidName"])
			$MainScreen/VBoxContainer/slugPikaiid.visible = true
	if DataStorage.observedSpecies.has("bigBoyPikaiid"):
		if DataStorage.observedSpecies.has("slugPikaiid"):
			$MainScreen/VBoxContainer/bigBoyPikaiid.set_text(">"+UniversalFunctions.dialogueJson["bigBoyPikaiidName"])
			$MainScreen/VBoxContainer/bigBoyPikaiid.visible = true
			$MainScreen/VBoxContainer/bigBoySlugPikaiid.visible = false
		else:
			$MainScreen/VBoxContainer/bigBoySlugPikaiid.set_text(">"+UniversalFunctions.dialogueJson["bigBoySlugPikaiidName"])
			$MainScreen/VBoxContainer/bigBoySlugPikaiid.visible = true
	if DataStorage.observedSpecies.has("arthrocaris"):
		$MainScreen/VBoxContainer/arthropods.visible = true
		$MainScreen/VBoxContainer/arthrocaris.set_text(">"+UniversalFunctions.dialogueJson["arthrocarisName"])
		$MainScreen/VBoxContainer/arthrocaris.visible = true



func _on_BackButton_pressed():
	if $MainScreen.visible == false:
		$Species.visible = false
		$MainScreen.visible = true
	else:
		visible = false
		if get_tree().get_root().get_node_or_null("/root/world/Bag/Bag") != null:
			get_tree().get_root().get_node_or_null("/root/world/Bag/Bag").visible = true
		emit_signal("go")
