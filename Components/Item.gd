extends TextureButton

signal combined
signal pressed_data
var currentItem 
onready var bag = get_tree().get_root().get_node_or_null("/root/world/Bag")
onready var bagFlavorText = get_tree().get_root().get_node_or_null("/root/world/Bag/Bag/FlavorText")




func _on_Item0_pressed():
	if bag.mode == 0:
		if bag.currentItem == null:
			bag.currentItem = currentItem
			var flavorTextEdit = UniversalFunctions.dialogueJson["combineItem"]
			flavorTextEdit = flavorTextEdit.replace("{item}", UniversalFunctions.dialogueJson[bag.currentItem+"Name"])
			bagFlavorText.set_bbcode(flavorTextEdit)
		else:
			bag.combined = currentItem
			emit_signal("combined")
	else:
		bag.currentItem = currentItem
		emit_signal("pressed_data")
		

func _on_Item0_mouse_entered():
	if bag.currentItem == null:
		bagFlavorText.set_bbcode("[center]"+ UniversalFunctions.dialogueJson[currentItem+"InvDesc"]+"[/center]")
	else:
		if bag.currentItem == currentItem:
			return
		var flavorTextEdit = UniversalFunctions.dialogueJson["combineTwoItems"]
		flavorTextEdit = flavorTextEdit.replace("{item1}", "[color=#4f80a0]"+UniversalFunctions.dialogueJson[bag.currentItem+"Name"]+"[/color]")
		flavorTextEdit = flavorTextEdit.replace("{item2}", "[color=#4f80a0]"+UniversalFunctions.dialogueJson[currentItem+"Name"]+"[/color]")
		bagFlavorText.set_bbcode(flavorTextEdit)
		
func _on_Item0_mouse_exited():
	if bag.mode == 0:
		if bag.currentItem == null:
			bagFlavorText.set_bbcode(UniversalFunctions.dialogueJson["combineBagPrompt"])
		else:
			var flavorTextEdit = UniversalFunctions.dialogueJson["combineItem"]
			flavorTextEdit = flavorTextEdit.replace("{item}", UniversalFunctions.dialogueJson[bag.currentItem+"Name"])
			bagFlavorText.set_bbcode(flavorTextEdit)
	else:
		bagFlavorText.set_bbcode(UniversalFunctions.dialogueJson["useBagPrompt"])
