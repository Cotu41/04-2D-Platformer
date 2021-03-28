extends Node

const SAVE_PATH = "user://savegame.sav"
const SECRET = "C220 Is the Best!"
var save_file = ConfigFile.new()

onready var HUD = get_node_or_null("/root/Main/UI/HUD")
onready var Coins = get_node_or_null("/root/Main/Coins")
onready var Game = load("res://Main.tscn")
onready var Coin = load("res://Coin.tscn")

var save_data = {
	"general": {
		"score":0
		,"coins":[]
	}
}


func _ready():
	update_score(0)

func set_level(level):
	if level == 2:
		HUD = get_node_or_null("/root/Scene2/UI/HUD")
		Coins = get_node_or_null("/root/Scene2/Coins")
		Game = load("res://Scene2.tscn")

func reaquaint():
	HUD = get_tree().current_scene.get_node("UI/HUD")
	Coins = get_tree().current_scene.get_node("Coins")
	Game = get_tree().current_scene;

func update_score(s):
	save_data["general"]["score"] += s
	HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])


func restart_level():
	HUD = get_node_or_null("/root/Main/UI/HUD")
	Coins = get_node_or_null("/root/Main/Coins")
	
	for c in Coins.get_children():
		c.queue_free()
	for c in save_data["general"]["coins"]:
		var coin = Coin.instance()
		coin.position = str2var(c)
		Coins.add_child(coin)
	update_score(0)
	get_tree().paused = false

# ----------------------------------------------------------
func save_game():
	save_data["general"]["coins"] = []
	save_data["general"]["mines"] = []
	for c in Coins.get_children():
		save_data["general"]["coins"].append(var2str(c.position))

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)
	save_game.store_string(to_json(save_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)
	var contents = save_game.get_as_text()
	var result_json = JSON.parse(contents)
	if result_json.error == OK:
		save_data = result_json.result
	else:
		print("Error: ", result_json.error)
	save_game.close()
	
	var _scene = get_tree().change_scene_to(Game)
	call_deferred("restart_level")

