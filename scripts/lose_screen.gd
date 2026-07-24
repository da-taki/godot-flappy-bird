extends Control

@onready var score_label: Label = $CenterContainer/LoseScreenItems/Label
@onready var click_sound: AudioStreamPlayer2D = $ClickSound

func _ready() -> void:
	score_label.text = "You lose XD! Score: " + str(GameState.score)

func _on_rerun_button_pressed() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
