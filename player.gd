extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jump()
	var input_axis := Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_animations(input_axis)
	move_and_slide()
	
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
			
func handle_acceleration(input_axis: float, delta: float) -> void:
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func apply_friction(input_axis: float, delta: float) -> void:
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func update_animations(input_axis: float) -> void:
	if input_axis != 0:
		animated_sprite_2d.flip_h = input_axis < 0
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")
