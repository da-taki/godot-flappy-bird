extends Control

var game_script = preload("res://scripts/game.gd")
@onready var game_instance = game_script.new()
@onready var my_Label = $CenterContainer/LoseScreenItems/Label

func _ready() -> void:
	my_Label.text = "You lose XD! Score: " + str(game_instance.score)

func _on_rerun_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
