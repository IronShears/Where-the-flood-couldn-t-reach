extends Button



func _on_species_pressed():
	if get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/MainScreen") != null:
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/MainScreen").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/Title").set_bbcode(UniversalFunctions.dialogueJson[name+"NameLong"])
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/Text").set_bbcode(UniversalFunctions.dialogueJson[name+"Text"+ str(DataStorage.observedSpecies[name])])
		var file = File.new()
		if file.file_exists("res://Components/Textures/"+name+str(DataStorage.observedSpecies[name])+".png"):
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").texture = load("res://Components/Textures/"+name+str(DataStorage.observedSpecies[name])+".png")

		elif file.file_exists("res://Components/Textures/"+name+".png"):
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").texture = load("res://Components/Textures/"+name+".png")
		else:
			get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species/VBoxContainer/image").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Bag/Tablet/Species").visible = true
	else:
		get_tree().get_root().get_node_or_null("/root/world/Tablet/MainScreen").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/Title").set_bbcode(UniversalFunctions.dialogueJson[name+"NameLong"])
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/Text").set_bbcode(UniversalFunctions.dialogueJson[name+"Text"+ str(DataStorage.observedSpecies[name])])
		var file = File.new()
		if file.file_exists("res://Components/Textures/"+name+str(DataStorage.observedSpecies[name])+".png"):
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/worl/Tablet/Species/VBoxContainer/image").texture = load("res://Components/Textures/"+name+str(DataStorage.observedSpecies[name])+".png")

		elif file.file_exists("res://Components/Textures/"+name+".png"):
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").visible = true
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").texture = load("res://Components/Textures/"+name+".png")
		else:
			get_tree().get_root().get_node_or_null("/root/world/Tablet/Species/VBoxContainer/image").visible = false
		get_tree().get_root().get_node_or_null("/root/world/Tablet/Species").visible = true


