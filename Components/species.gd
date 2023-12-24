extends Button

var allImages = ["arthrocaris", "bigBoyPikaiid", "bigBoySlugPikaiid", "crabTrapCrinoid",
				"crackerEurypterid0", "crackerEurypterid1", "driftWorm", 
				"isopodRadiodont", "lacemouth", "lesserSlugPikaiid", "letterBonePikaiid",
				"mochiDonutGraptolite", "slugPikaiid", "teaCupPikaiid", "teaLily", "veinerWorm2", 
				"wiggleTrilobite0", "wiggleTrilobite1"]


func _on_species_pressed():
	if get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/MainScreen") != null:
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/MainScreen").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/Title").set_bbcode(UniversalFunctions.dialogueJson[name+"NameLong"])
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/Text").set_bbcode(UniversalFunctions.dialogueJson[name+"Text"+ str(DataStorage.observedSpecies[name])])
		var file = File.new()
		if allImages.has(name+str(DataStorage.observedSpecies[name])):
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").play(name+str(DataStorage.observedSpecies[name]))
		elif allImages.has(name):
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").play(name)
		else:
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species").visible = true
	else:
		get_tree().get_root().get_node_or_null("/root/world/Tablet/MainScreen").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/Title").set_bbcode(UniversalFunctions.dialogueJson[name+"NameLong"])
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/Text").set_bbcode(UniversalFunctions.dialogueJson[name+"Text"+ str(DataStorage.observedSpecies[name])])
		var file = File.new()
		if allImages.has(name+str(DataStorage.observedSpecies[name])):
			get_tree().get_root().get_node_or_null("/root/worldTablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").play(name+str(DataStorage.observedSpecies[name]))
		elif allImages.has(name):
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").play(name)
		else:
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species").visible = true
