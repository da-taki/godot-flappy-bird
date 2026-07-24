extends Control

@onready var click_sound: AudioStreamPlayer2D = $ClickSound

func _on_play_button_pressed() -> void:
	click_sound.play()

	get_tree().change_scene_to_file("res://scenes/game.tscn")
