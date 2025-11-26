extends Control

var config_path = "user://settings.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_settings()

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(config_path)
	if err == OK:
		var volume = config.get_value("audio", "volume", 100)
		var muted = config.get_value("audio", "muted", false)
		var fullscreen = config.get_value("video", "fullscreen", false)
		# Aplica volum i mute al bus Master
		if muted:
			AudioServer.set_bus_volume_db(0, linear_to_db(0.0))
		else:
			AudioServer.set_bus_volume_db(0, linear_to_db(volume / 100.0))
		# Aplica pantalla completa segons la configuració guardada
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

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
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_highscores_pressed() -> void:
	pass # Replace with function body.

func _on_about_pressed() -> void:
	pass # Replace with function body.
