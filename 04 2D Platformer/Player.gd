extends KinematicBody2D

onready var Backup = get_node("/root/Main/Player_Container/Backup_Camera")

var velocity = Vector2.ZERO
var jump_power = Vector2(0, 260)
var direction = 1

export var gravity : float = 500
export var jump_gravity : float = 10
export var terminal_velocity : float = 250
var current_gravity = gravity

export var move_speed = 10
export var max_move = 200

var moving = false
var is_jumping = false
var live_time = 0
var blinkspeed = 20
func _process(delta):
	if live_time < 1:
		if(sin(live_time*blinkspeed) > 0.8 or sin(live_time*blinkspeed) < -0.8):
			visible = false
		else:
			visible = true
		live_time += delta
	else: visible = true

func _physics_process(_delta):
	if(position.y >= 100): die()
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_jumping:
		velocity.y = 0
		velocity -= jump_power
		current_gravity = jump_gravity
		set_animation("Jumping")
		is_jumping = true

		
	if(Input.is_action_just_released("jump") and is_jumping):
		current_gravity = gravity
		is_jumping = false

	velocity += (move_speed) * move_vector()
	velocity.y += current_gravity*_delta  # in the example gravity is tied to the framerate lol
	if not is_moving():
		velocity.x = 0
		if is_on_floor():
			set_animation("Idle")
		else:
			set_animation("Falling")
	else:
		set_animation("Moving")
		velocity.x = clamp(velocity.x,-max_move,max_move)
		if direction < 0 and not $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = true
			velocity.x = 0
		if direction > 0 and $AnimatedSprite.flip_h:
			$AnimatedSprite.flip_h = false
			velocity.x = 0
	if velocity.y > terminal_velocity: velocity.y = terminal_velocity
	move_and_slide(velocity, Vector2.UP)

	Backup.position = position



func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func die():
	Backup.current = true
	queue_free()
