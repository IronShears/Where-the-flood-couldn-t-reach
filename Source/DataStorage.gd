extends Node

var language = ""
var filter
var stage = 0
var inventory : Array = ["baitBox",
						"waterBottleFull",
						"lamp"]
var observedSpecies : Dictionary = {"driftWorm" : 0,
									"veinerWorm" : 0,
									"teaLily" : 0,
									"crabTrapCrinoid" : 0,
									"teaCupPikaiid" : 0,
									"letterBonePikaiid" : 0}
var cavesDiscovered = false
var ending = 0
var slotsVisible = false
var gameData : Dictionary
var path = "user://save_data.json"
var saveFile

func _ready():
	var directory = Directory.new();
	if directory.file_exists(path):
		var file2 = File.new()
		assert(file2.file_exists("user://save_data.json"))
		file2.open("user://save_data.json", file2.READ)
		saveFile = parse_json(file2.get_as_text())
		language = saveFile["language"]
		filter = saveFile["filter"]
		observedSpecies = saveFile["observedSpecies"]
		ending = saveFile["ending"]

func reset():
	filter = null
	stage = 0
	inventory = ["baitBox",
				"waterBottleFull",
				"lamp"]
	observedSpecies = {"driftWorm" : 0,
						"veinerWorm" : 0,
						"teaLily" : 0,
						"crabTrapCrinoid" : 0,
						"teaCupPikaiid" : 0,
						"letterBonePikaiid" : 0}
	cavesDiscovered = false
	ending = 0
	gameData = {}
	saveFile = null
	var dir = Directory.new()
	dir.remove("user://save_data.json")



func save_game():
	var dictionary
	dictionary = {
	"language" : language,
	"filter" : filter,
	"observedSpecies" : observedSpecies, 
	"ending" : ending
	}
	var file2 = File.new()
	file2.open(path, File.WRITE)
	file2.store_line(to_json(dictionary))
	file2.close()
