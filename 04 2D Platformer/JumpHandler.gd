extends Node

onready var player = get_parent()
onready var p_container = get_node("../..")

var in_jump := false

func _ready():
	yield(player, "ready")



