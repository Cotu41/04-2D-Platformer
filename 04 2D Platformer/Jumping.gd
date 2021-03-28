extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

var in_jump := false

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Jumping")

func physics_process(_delta):
#	if player.is_moving():
#		player.jump_power.x = clamp(player.jump_power.x + (player.move_vector().x * player.leap_speed), -player.max_leap, player.max_leap)
#	if Input.is_action_pressed("jump"):
#		player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
#	else:
#		player.velocity.y = 0
#		player.velocity += player.jump_power
#		player.move_and_slide(player.velocity, Vector2.UP)
#		SM.set_state("Falling")
		
	if Input.is_action_just_pressed("jump") and not in_jump:
		player.velocity.y = 0
		player.velocity += player.jump_power
		player.gravity = Vector2(0, 20)
		player.move_and_slide(player.velocity, Vector2.UP)
		SM.set_state("Jumping")
		in_jump = true
		
	if(Input.is_action_just_released("jump") and in_jump):
		player.velocity.y = 0
		SM.set_state("Falling")
		player.gravity = Vector2(0,30)
		in_jump = false

# start jump on spacebar down

# start increased gravity on spacebar up

# this gives the illusion that you jump with more power the longer you hold,
# without the weird power-jump mechanic that's hard to judge
