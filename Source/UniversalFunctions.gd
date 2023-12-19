extends Node

onready var dialogueBox : Node2D = get_tree().get_root().get_node_or_null("/root/world/Dialogue")
onready var soundEffects = get_tree().get_root().get_node_or_null("/root/world/SoundEffects")
onready var actionsNode = get_tree().get_root().get_node_or_null("/root/world/Actions")
onready var actionsRing = get_tree().get_root().get_node_or_null("/root/world/Actions/ActionRing")
onready var animationPlayer = get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer")
onready var inventory = get_tree().get_root().get_node_or_null("/root/world/Bag")
var dialoguePlaying = false
var cutscene = false
var dialogueJson
var cutsceneTimer := Timer.new()
signal ran


func _ready():
	add_child(cutsceneTimer)
	cutsceneTimer.wait_time = 0.05
	var file = File.new()
	assert(file.file_exists("res://Components/Text.json"))
	file.open("res://Components/Text.json", file.READ)
	dialogueJson = parse_json(file.get_as_text())
	
func update():
	dialogueBox = get_tree().get_root().get_node_or_null("/root/world/Dialogue")
	soundEffects = get_tree().get_root().get_node_or_null("/root/world/SoundEffects")
	actionsNode = get_tree().get_root().get_node_or_null("/root/world/Actions")
	actionsRing = get_tree().get_root().get_node_or_null("/root/world/Actions/ActionRing")
	animationPlayer = get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer")
	inventory = get_tree().get_root().get_node_or_null("/root/world/Bag")


func play_dialogue_JSON(dialogue : String):
	if dialoguePlaying == true:
		return
	dialogueBox.visible = true
	dialoguePlaying = true
	cutscene = true
	dialogueBox.dialogue = dialogueJson[dialogue]
	dialogueBox.page = 0
	dialogueBox.endpoint = dialogueBox.dialogue.size() - 1
	dialogueBox.firstline = true
	dialogueBox.new_line()
	yield(dialogueBox, "done")
	dialogueBox.visible = false
	dialoguePlaying = false
	cutsceneTimer.start(0.05)
	yield(cutsceneTimer, "timeout")
	cutsceneTimer.start(0.05)
	yield(cutsceneTimer, "timeout")
	if dialogueBox == null:
		return
	if dialogueBox.visible == false:
		cutscene = false
		
func pick_up(sprite, item):
	for i in sprite:
		i.visible = false
	DataStorage.inventory.append(item)
	inventory.update()
	soundEffects.stream = load("res://Sounds/pickUp.wav")
	soundEffects.play()
	
	
func use(itemNeeded):
	inventory.mode = 1
	inventory.update()
	inventory.visible = true
	yield(inventory, "pressed")
	inventory.mode = 0
	for i in itemNeeded:
		if i == inventory.currentItem:
			emit_signal("ran")
			inventory.visible = false
			inventory.update()
			DataStorage.inventory.erase(i)
			return
	inventory.currentItem = null
	inventory.visible = false
	inventory.update()
	emit_signal("ran")
	
func place(sprite, item):
	for i in sprite:
		i.visible = true
	for i in item:
		DataStorage.inventory.erase(i)
	inventory.update()
	soundEffects.stream = load("res://Sounds/Place.wav")
	soundEffects.play()
	
	
func swap(item1, item2):
	DataStorage.inventory.erase(item1)
	DataStorage.inventory.append(item2)
	inventory.update()
	
func move(scene):
	if cutscene == false:
		animationPlayer.play_backwards("load")
		yield(animationPlayer,"animation_finished")
		soundEffects.stream = load("res://Sounds/Move.wav")
		soundEffects.play()
		yield(soundEffects,"finished")
		get_tree().change_scene(scene)
	

func actions(position, options):
	cutscene = true
	actionsNode.arrange(options)
	actionsRing.global_position = position
	actionsNode.visible = true
	yield(actionsNode, "pressed")
	actionsNode.visible = false
	cutscene = false
