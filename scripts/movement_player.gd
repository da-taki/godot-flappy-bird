extends CharacterBody2D

const GRAVITY = 700.0
const JUMP_FORCE = -350.0

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_FORCE
		
	move_and_slide()
