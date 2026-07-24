extends Control

@onready var score_label: Label = $CenterContainer/LoseScreenItems/Label
@onready var click_sound: AudioStreamPlayer2D = $Click_Sound

func _ready() -> void:
	score_label.text = "You lose XD! Score: " + str(GameState.score)

func _on_rerun_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
