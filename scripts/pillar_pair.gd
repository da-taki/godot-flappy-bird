extends Node2D

signal scored
signal lost

@export var speed: float = 180.0

var has_scored: bool = false
var has_lost: bool = false

func _physics_process(delta: float) -> void:
	position.x -= delta * speed
	
	if global_position.x < -610:
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
