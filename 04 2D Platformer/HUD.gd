extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "SCORE: " + str(score)
	pass # Replace with function body.

func add_score(added_score):
	score += added_score
	$Score.text = "SCORE: " + str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
