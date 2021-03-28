extends Node2D

export var speed : float = 4
export var drop_speed : float = 250
export var amount : float = 5
export var time_to_drop : float = 1.5

var start_rot
var start_y
var wobble_t : float = 0
var wobbling = false
var dropped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	start_rot = $Sprite.rotation_degrees
	start_y = position.y
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wobbling:
		wobble(delta)
	elif not dropped and position.y > start_y:
		position.y -= (drop_speed/2)*delta
	elif dropped and position.y < 600:
		position.y += drop_speed*delta
	elif dropped:
		dropped = false
		$Sprite.rotation_degrees = start_rot
	
	pass


func wobble(delta):
	$Sprite.rotation_degrees = start_rot + (sin(wobble_t*speed)*amount)
	wobble_t += delta
	if wobble_t >= time_to_drop:
		dropped = true
		wobbling = false
		wobble_t = 0


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		wobbling = true
	pass # Replace with function body.
