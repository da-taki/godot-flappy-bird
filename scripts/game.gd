extends Node2D

const PILLAR_SCENE: PackedScene = preload("res://scenes/pillar_pair.tscn")

@export var spawn_x: float = 700.0
@export var minimum_spawn_y: float = -160.0
@export var maximum_spawn_y: float = 160.0

var score: int = 0

@onready var score_label: Label = $UI/ScoreLabel

func _ready() -> void:
	update_score_label()
	spawn_pillar()
	
func spawn_pillar() -> void: 
	var pillar := PILLAR_SCENE.instantiate() as Node2D
	
	add_child(pillar)
	pillar.connect("scored", add_score)
	
	pillar.position = Vector2(
		spawn_x,
		randf_range(minimum_spawn_y, maximum_spawn_y)
	)
	
func add_score() -> void:
	score += 1
	update_score_label()
	
func update_score_label() -> void:
	score_label.text = str(score)
	
func _on_pillar_spawn_timer_timeout() -> void:
	spawn_pillar()
