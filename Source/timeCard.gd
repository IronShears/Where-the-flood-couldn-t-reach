extends RichTextLabel

signal finished
onready var loading = get_tree().get_root().get_node_or_null("/root/world/AnimationPlayer")
	

func run():
	set_bbcode("[center]"+UniversalFunctions.dialogueJson["restTitle"+str(DataStorage.stage)]+"[/center]")
	set_visible_characters(0)
	$Timer.start()

func _on_Timer_timeout():
	if visible_characters < get_total_character_count():
		set_visible_characters(get_visible_characters()+1)
	else:
		emit_signal("finished")
		$Timer.stop()
		yield(loading, "animation_finished")
		set_visible_characters(0)
