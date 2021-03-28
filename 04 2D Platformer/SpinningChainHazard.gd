extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var rotation_speed : float = 70

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += rotation_speed*delta;
	





func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.die()
