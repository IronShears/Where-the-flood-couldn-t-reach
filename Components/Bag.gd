extends Node2D
var items = 25
var currentItem
var combined
var mode = 0
signal pressed

func _ready():
	update()
	currentItem = null
	combined = null
	
func update():
	if mode == 1:
		$Bag/ScrollContainer/GridContainer/Tablet.visible = false
	else:
		$Bag/ScrollContainer/GridContainer/Tablet.visible = true
	for i in items:
		get_tree().get_root().get_node_or_null("/root/world/Bag/Bag/ScrollContainer/GridContainer/Item"+str(i)).visible = false
	var num = 0
	for i in DataStorage.inventory:
		var current = get_tree().get_root().get_node_or_null("/root/world/Bag/Bag/ScrollContainer/GridContainer/Item"+str(num))
		current.flip_h = false
		current.texture_normal = load("res://Components/Textures/"+i+".png")
		current.visible = true
		current.currentItem = i
		var previous = get_tree().get_root().get_node_or_null("/root/world/Bag/Bag/ScrollContainer/GridContainer/Item"+str(num-1))
		if previous != null:
			if previous.currentItem == i:
				current.flip_h = true
		num+=1
		
func _on_Tablet_pressed():
	if mode == 0:
		$Bag.visible = false
		$Tablet.visible = true
		currentItem = null
		combined = null



func _on_close_pressed():
	if mode == 0:
		currentItem = null
		combined = null
		$Bag/FlavorText.set_bbcode("")
		get_tree().get_root().get_node_or_null("/root/world/BagIcon").visible = true
		get_tree().get_root().get_node_or_null("/root/world/Radio").visible = true
		self.visible = false
		UniversalFunctions.cutscene = false
	else: 
		currentItem = "cancel"
		emit_signal("pressed")


func _on_Item_combined():
	if mode == 1:
		return
	if combined == null:
		return
		
	if currentItem == combined:
		return
	if UniversalFunctions.dialogueJson.has(currentItem+combined):
		DataStorage.inventory.append(currentItem+combined)
		UniversalFunctions.play_dialogue_JSON(currentItem+combined)
		DataStorage.inventory.erase(currentItem)
		DataStorage.inventory.erase(combined)
	elif UniversalFunctions.dialogueJson.has(combined+currentItem):
		DataStorage.inventory.append(combined+currentItem)
		UniversalFunctions.play_dialogue_JSON(combined+currentItem)
		DataStorage.inventory.erase(currentItem)
		DataStorage.inventory.erase(combined)
	elif currentItem == "teaLilyCup":
		if combined.substr(0,11) == "waterBottle":
			DataStorage.inventory.erase(currentItem)
			DataStorage.inventory.erase(combined)
			DataStorage.inventory.append("teaLilyWaterBottle")
			UniversalFunctions.play_dialogue_JSON("teaLilyWaterBottleCombine")
	elif combined == "teaLilyCup":
		if currentItem.substr(0,11) == "waterBottle":
			DataStorage.inventory.erase(currentItem)
			DataStorage.inventory.erase(combined)
			DataStorage.inventory.append("teaLilyWaterBottle")
			UniversalFunctions.play_dialogue_JSON("teaLilyWaterBottleCombine")
	else:
		UniversalFunctions.play_dialogue_JSON("cannotCombine")
		
	currentItem = null
	combined = null
	$Bag/FlavorText.set_bbcode("")
	update()
	self.visible = false
	get_tree().get_root().get_node_or_null("/root/world/BagIcon").visible = true
	get_tree().get_root().get_node_or_null("/root/world/Radio").visible = true


func _on_Item_pressed():
	if mode == 0:
		return
	emit_signal("pressed")


func _on_Tablet_mouse_entered():
	if currentItem == null:
		$Bag/FlavorText.set_bbcode(UniversalFunctions.dialogueJson["tablet"])
	else:
		$Bag/FlavorText.set_bbcode(UniversalFunctions.dialogueJson["tabletNo"])
		


func _on_Tablet_mouse_exited():
	$Bag/FlavorText.set_bbcode("")
