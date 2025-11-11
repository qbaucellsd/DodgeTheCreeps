extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_singleplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://singleplayer/main.tscn")

func _on_local_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://multiplayer/main.tscn")

func _on_online_multiplayer_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_highscores_pressed() -> void:
	pass # Replace with function body.

func _on_about_pressed() -> void:
	pass # Replace with function body.
