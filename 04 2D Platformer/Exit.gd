extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var destination : int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if destination == 1:
			var _target = get_tree().change_scene("res://Main.tscn")
		elif destination == 2:
			var _target = get_tree().change_scene("res://Scene2.tscn")
		else:
			get_tree().quit()
			
	pass # Replace with function body.
