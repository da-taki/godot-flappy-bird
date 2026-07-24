extends Node2D

signal scored
signal lost

@export var speed: float = 180.0
@export var gap_size: float = 180.0

const PILLAR_HALF_HEIGHT: float = 200.0

@onready var top_pillar: StaticBody2D = $TopPillar
@onready var bottom_pillar: StaticBody2D = $BottomPillar
@onready var score_collision: CollisionShape2D = $ScoreZone/Collision

var has_scored: bool = false
var has_lost: bool = false

func _ready() -> void:
	score_collision.shape = score_collision.shape.duplicate()

	apply_gap_size()

func configure_difficulty(
	new_speed: float,
	new_gap_size: float
) -> void:
	speed = new_speed
	gap_size = new_gap_size

	apply_gap_size()


func apply_gap_size() -> void:
	if not is_node_ready():
		return

	var distance_from_center: float = (
		PILLAR_HALF_HEIGHT + gap_size / 2.0
	)

	top_pillar.position.y = -distance_from_center
	bottom_pillar.position.y = distance_from_center

	update_score_zone()


func update_score_zone() -> void:
	var shape := score_collision.shape

	if shape is SegmentShape2D:
		shape.a = Vector2(
			0.0,
			-gap_size / 2.0 + 5.0
		)

		shape.b = Vector2(
			0.0,
			gap_size / 2.0 - 5.0
		)

	elif shape is RectangleShape2D:
		shape.size = Vector2(
			20.0,
			gap_size - 10.0
		)


func _physics_process(delta: float) -> void:
	position.x -= delta * speed

	if global_position.x < -650.0:
		queue_free()


func _on_score_zone_body_entered(body: Node2D) -> void:
	if has_scored:
		return

	if body is CharacterBody2D:
		has_scored = true
		scored.emit()


func _on_lose_upper_body_entered(body: Node2D) -> void:
	lose(body)


func _on_lose_lower_body_entered(body: Node2D) -> void:
	lose(body)


func lose(body: Node2D) -> void:
	if has_lost:
		return

	if body is CharacterBody2D:
		has_lost = true
		lost.emit()
