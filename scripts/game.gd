extends Node2D

const PILLAR_SCENE: PackedScene = preload(
	"res://scenes/pillar_pair.tscn"
)

const DIFFICULTY_SCORE: int = 7

@export var spawn_x: float = 700.0

@onready var score_label: Label = $UI/ScoreLabel
@onready var pillar_spawn_timer: Timer = $PillarSpawnTimer

var is_game_over: bool = false

func _ready() -> void:
	GameState.score = 0

	update_score_label()
	update_difficulty()
	spawn_pillar()

func spawn_pillar() -> void:
	var spawn_y: float
	var pillar_speed: float
	var pillar_gap: float

	if GameState.score < DIFFICULTY_SCORE:
		spawn_y = randf_range(-120.0, 120.0)
		pillar_speed = 180.0
		pillar_gap = 180.0
	else:
		spawn_y = randf_range(-160.0, 160.0)
		pillar_speed = 205.0
		pillar_gap = 125.0

	var pillar := PILLAR_SCENE.instantiate() as Node2D

	add_child(pillar)

	pillar.connect("scored", add_score)
	pillar.connect("lost", game_over)

	pillar.configure_difficulty(
		pillar_speed,
		pillar_gap
	)

	pillar.position = Vector2(
		spawn_x,
		spawn_y
	)

	print(
		"Score: ",
		GameState.score,
		" | Gap: ",
		pillar_gap,
		" | Speed: ",
		pillar_speed,
		" | Spawn Y: ",
		spawn_y
	)

func add_score() -> void:
	GameState.score += 1

	update_score_label()
	update_difficulty()

func update_difficulty() -> void:
	if GameState.score < DIFFICULTY_SCORE:
		pillar_spawn_timer.wait_time = 2.4
	else:
		pillar_spawn_timer.wait_time = 2.0

func update_score_label() -> void:
	score_label.text = str(GameState.score)

func game_over() -> void:
	if is_game_over:
		return

	is_game_over = true

	get_tree().change_scene_to_file(
		"res://scenes/lose_screen.tscn"
	)

func _on_pillar_spawn_timer_timeout() -> void:
	spawn_pillar()

func _on_borders_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		game_over()
