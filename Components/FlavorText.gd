# DialogBox.gd
extends Node

# Variables
signal close
signal auto_close
signal done
onready var textBox : RichTextLabel = $Text
onready var nameBox : RichTextLabel = $Name
onready var timer : Timer = $Timer
onready var charname: String
onready var text: String
onready var time = 0.05
onready var closetime = 1
onready var hold = false
onready var dialogue
onready var page = null
onready var autoclose = false
onready var endpoint 
onready var dialogueBox
onready var radio = get_tree().get_root().get_node_or_null("/root/world/Radio")
var firstline
var rng = RandomNumberGenerator.new()
var clip1
var clip2
var clip3


func _play_dialog():
	$Voice.playing = false
	if charname == "nullCommander":
		clip1 = load("res://Sounds/Voices/Commander O'Cuill1.mp3")
		clip2 = load("res://Sounds/Voices/Commander O'Cuill2.mp3")
		clip3 = load("res://Sounds/Voices/Commander O'Cuill3.mp3")
	elif charname == "null":
		pass
	else:
		clip1 = load("res://Sounds/Voices/" + charname + "1.mp3")
		clip2 = load("res://Sounds/Voices/" + charname + "2.mp3")
		clip3 = load("res://Sounds/Voices/" + charname + "3.mp3")
	if charname != "null" and charname != "nullCommander":
		nameBox.set_bbcode(UniversalFunctions.dialogueJson[charname])
	else:
		nameBox.set_bbcode("")
		
	$AutoCloseTimer.stop()
	textBox.set_process_input(true)
	textBox.set_bbcode(text)
	textBox.set_visible_characters(0)
	timer.wait_time = time
	$AutoCloseTimer.wait_time = closetime


func _input(event):
	
	if dialogue == null:
		if text != "null":
			if event is InputEventMouseButton and event.is_pressed():
				if hold == false: 
					if textBox.get_visible_characters() < textBox.get_total_character_count():
						textBox.set_visible_characters(textBox.get_total_character_count())
						$AutoCloseTimer.start()
					else:
						charname = "null"
						text = "null"
						emit_signal("close")
	if dialogue != null:
		if dialogue[page]["type"] == "Dialogue" or dialogue[page]["type"] == "DialogueAuto":
			if event is InputEventMouseButton and event.is_pressed():
				if textBox.get_visible_characters() > textBox.get_total_character_count():
					if page < endpoint:
						if dialogue[page]["type"] == "Dialogue" or dialogue[page]["type"] == "DialogueImage":
							new_line()
					else:
						dialogue = null
						emit_signal("done")
						radio.set_material(null)
				elif textBox.get_visible_characters() < textBox.get_total_character_count():
					textBox.set_visible_characters(textBox.get_total_character_count())
					if dialogue[page]["type"] == "DialogueAuto" or dialogue[page]["type"] == "DialogueImageAuto":
						$AutoCloseTimer.start()
				

func skip_input():
	if page < endpoint:
		new_line()
	else:
		dialogue = null
		emit_signal("done")

func set_up():
	radio.set_material(null)
	first_line()
	charname = dialogue[page]["name"]
	text = dialogue[page]["text"]
	time = dialogue[page]["tickSpeed"]
	$Dialoguebox.visible = false
	$Dialoguebox2.visible = false
	if charname != "Commander O'Cuill" and charname != "null":
		$Name.rect_position = Vector2(8, 3)
		$Text.rect_position = Vector2(8, 17)
		$Dialoguebox.visible = true
	elif charname == "null":
		$Text.rect_position = Vector2(8, 3)
		$Dialoguebox.visible = true
	else:
		$Name.rect_position = Vector2(40, 141)
		$Text.rect_position = Vector2(40, 155)
		$Dialoguebox2.visible = true
		radio.set_material(load("res://Source/Highlight.tres"))
	if dialogue[page]["type"] == "DialogueAuto":
		closetime = dialogue[page]["closeSpeed"]
		autoclose = true
	
func new_line():
	if firstline == false and dialogue[page+1]["type"] == "Dialogue" or firstline == true and dialogue[page]["type"] == "Dialogue":
		set_up()
					
		_play_dialog()
	elif firstline == false and dialogue[page+1]["type"] == "DialogueAuto" or firstline == true and dialogue[page]["type"] == "DialogueAuto":
		set_up()
		_play_dialog()
	else:
		print(dialogue[page+1]["type"])
	

func first_line():
	if firstline == true:
		firstline = false
	else:
		page += 1

func _on_Timer_timeout():
	if dialogue != null:
		if self.visible == true and textBox.visible_characters < textBox.get_total_character_count():
			if  textBox.visible_characters < textBox.get_total_character_count()-1:
				if text[textBox.visible_characters+1] == " ":
					textBox.set_visible_characters(textBox.get_visible_characters()+1)
			if charname != "null":
				if $Voice.playing == false and text[textBox.visible_characters] != ".": 
					rng.randomize()
					var pitch 
					if dialogue[page]["tickSpeed"] == 0.05:
						pitch = rng.randf_range(0.90, 1.05)
					elif  dialogue[page]["tickSpeed"] > 0.5:
						pitch = rng.randf_range(0.90 - (dialogue[page]["tickSpeed"]*15), 1.05 - (dialogue[page]["tickSpeed"]*15))
					elif  dialogue[page]["tickSpeed"] < 0.5:
						pitch = rng.randf_range(0.90 + (abs(dialogue[page]["tickSpeed"]-0.10) *4), 1.05 + (abs(dialogue[page]["tickSpeed"]-0.10) *4))
					$Voice.pitch_scale =  pitch
					var aeiouy = ["a", "e", "i", "o", "u", "y", "A", "E", "I", "O", "U", "Y"]
					var bcdfghjklmn = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N"]
					var clip = clip3
					
					for i in aeiouy:
						if text[textBox.visible_characters] == i:
							clip = clip1
					for i in bcdfghjklmn:
						if text[textBox.visible_characters] == i:
							clip = clip2
					$Voice.stream = clip
					$Voice.play()
			if $Static.playing == false:
				if charname == "nullCommander" or charname == "Commander O'Cuill":
					$Static.play()
				
		else:
			$Static.playing = false
		textBox.set_visible_characters(textBox.get_visible_characters()+1)
		if textBox.visible_characters == textBox.get_total_character_count():
			if dialogue[page]["type"] == "DialogueAuto":
				$AutoCloseTimer.start()
		


func _on_AutoCloseTimer_timeout():
	if autoclose == true:
		autoclose = false
		$Voice.playing = false
		skip_input()
	emit_signal("auto_close")
	radio.set_material(null)
	
