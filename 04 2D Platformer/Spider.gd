extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed : float = 3
export var lag : float = 0
var currentTime : float = 0
var original_position : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = position
	currentTime += lag


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentTime += delta
	position.y = original_position.y + ((sin(currentTime*speed)+0.5)*8)
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.die()
