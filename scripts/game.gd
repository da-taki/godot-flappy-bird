extends Node2D

const PILLAR_SCENE: PackedScene = preload("res://scenes/pillar_pair.tscn")

@export var spawn_x: float = 700.0
@export var minimum_spawn_y: float = -160.0
@export var maximum_spawn_y: float = 160.0

func _ready() -> void:
	spawn_pillar()
	
func spawn_pillar() -> void: 
	var pillar := PILLAR_SCENE.instantiate() as Node2D
	
	add_child(pillar)
	
	pillar.position = Vector2(
		spawn_x,
		randf_range(minimum_spawn_y, maximum_spawn_y)
	)
func _on_pillar_spawn_timer_timeout() -> void:
	spawn_pillar()
