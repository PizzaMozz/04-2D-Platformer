extends Node

var player = null

var fade = null
var fade_speed = 0.015

var fade_in = false
var fade_out = ""

var death_zone = 1000

const SAVE_PATH = "user://savegame.sav"
const SECRET = "C220 Is the Best!"
var save_file = ConfigFile.new()

onready var HUD = get_node_or_null("/root/Game/UI/HUD")
onready var Coins = get_node_or_null("/root/Game/Coins")
onready var Menu = load("res://Levels/Menu.gd")
onready var Coin = load("res://Coin/Coin.tscn")

var save_data = {
	"general": {
		"score":0,
		"level":1
	}
}

func _ready():
	update_score(0)

func _physics_process(_delta):
	if fade == null:
		fade = get_node_or_null("/root/Game/Camera/Fade")
	if fade_out != "":
		execute_fade_out(fade_out)
	if fade_in:
		execute_fade_in()

func update_score(s):
	HUD = get_node_or_null("/root/Game/UI/HUD")
	save_data["general"]["score"] += s
	HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])

func start_fade_in():
	if fade != null:
		fade.visible = true
		fade.color.a = 1
		fade_in = true

func start_fade_out(target):
	if fade != null:
		fade.color.a = 0
		fade.visible = true
		fade_out = target

func execute_fade_in():
	if fade != null:
		fade.color.a -= fade_speed
		if fade.color.a <= 0:
			fade_in = false

func execute_fade_out(target):
	if fade != null:
		fade.color.a += fade_speed
		if fade.color.a >= 1:
			fade_out = ""
			

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().change_scene("res://Levels/Menu.tscn")
		
func save_game():
	var save_game = File.new()						# create a new file object
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)	# prep it for writing to, make sure the contents are encrypted
	save_game.store_string(to_json(save_data))				# convert the data to a json representation and write it to the file
	save_game.close()							# close the file so other processes can read from or write to it
	
func load_game():
	var save_game = File.new()						# Create a new file object
	if not save_game.file_exists(SAVE_PATH):
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)	# The file should be encrypted
	var contents = save_game.get_as_text()					# Get the contents of the file
	var result_json = JSON.parse(contents)
	save_game.close()							# Close the file so other processes can read from or write to it
	
	if save_data["general"]["level"] == 1:
		var _scene = get_tree().change_scene("res://Levels/Level1.tscn")
	if save_data["general"]["level"] == 2:
		var _scene = get_tree().change_scene("res://Levels/Level2.tscn")
	if save_data["general"]["level"] == 3:
		var _scene = get_tree().change_scene("res://Levels/Level3.tscn")
	call_deferred("restart_level")						# When it's done being loaded, call the restart_level method		# When it's done being loaded, call the restart_level methodd

