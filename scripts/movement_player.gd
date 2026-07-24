extends CharacterBody2D

const GRAVITY = 700.0
const JUMP_FORCE = -350.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var flap_sound: AudioStreamPlayer = $FlapSound

func _ready() -> void:
	animated_sprite.play("Flapping")
func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	velocity.y += delta * GRAVITY
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_FORCE
		flap_sound.play()
		
	rotation = clamp(
		velocity.y / 700.0,
		-0.45,
		0.9
	)
	move_and_slide()
	
	velocity.x = 0
