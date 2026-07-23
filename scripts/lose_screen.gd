extends Control

@onready var score_label: Label = $CenterContainer/LoseScreenItems/Label

func _ready() -> void:
	score_label.text = "You lose XD! Score: " + str(GameState.score)

func _on_rerun_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
