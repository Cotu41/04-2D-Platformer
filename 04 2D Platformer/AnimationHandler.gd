extends Node

onready var player = get_parent()
var state : String

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state("Idle")

func set_state(new_state):
	if new_state != state:
		player.set_animation(new_state)
		state = new_state
