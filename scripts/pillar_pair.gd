extends Node2D

@export var speed: float = 180.0

func _physics_process(delta: float) -> void:
	position.x -= delta * speed
	
	if global_position.x < -610:
		queue_free()
