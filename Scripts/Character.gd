extends CharacterBody2D

#Movement
var speed = 400.0
var accel = 1500
const friction = 600
var input = Vector2.ZERO
var flyspeed = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const maxfallspeed = 1000
#Actions
var sprint = false
var walking = false
var flying = false



func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input.normalized()

func player_movement(delta):
	
	# Adds the gravity.
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		walking = true
	else:
		walking = false
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= maxfallspeed:
			velocity.y = maxfallspeed
	
	if Global.stamina > 100.0:
		Global.stamina = 100.0
	if Global.stamina < 0:
		Global.stamina = 0
	
	if velocity.y == 0 and sprint == false:
		Global.stamina += 0.5
	
	
	
	if velocity.x == 0:
		$Character.play("Idle")
	elif sprint == true and speed > 400:
		$Character.play("Sprint") #Sprint anim
	elif sprint == false:
		$Character.play("Walk")
	
	
	
	if Input.is_action_pressed("ui_sprint") and is_on_floor() and Global.stamina > 0 and walking == true:
		accel = 2000
		speed = 600
		Global.stamina -= 0.25
		sprint = true
	else:
		accel = 1500
		speed = 400
		sprint = false
	
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(speed)
	
	if Input.is_action_pressed("ui_fly") and Global.stamina > 0:
		velocity.y = flyspeed
		Global.stamina -= 1
	
	if Input.is_action_pressed("ui_right"):
		$Character.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		$Character.scale.x = -1
	
	
	move_and_slide()

func _physics_process(delta):
	
	player_movement(delta)
	
	
	
	
	pass
