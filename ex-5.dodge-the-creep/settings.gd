extends Control

var config_path = "user://settings.cfg"
var volume_value = 100  # Valor per defecte
var muted = false
var fullscreen = false

func _ready():
	load_settings()

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "volume", volume_value)
	config.set_value("audio", "muted", muted)
	config.set_value("video", "fullscreen", fullscreen)
	config.save(config_path)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(config_path)
	if err == OK:
		volume_value = config.get_value("audio", "volume", 100)
		muted = config.get_value("audio", "muted", false)
		$VBoxContainer/HSlider.value = volume_value
		$VBoxContainer/MuteCheckButton.button_pressed = muted
		if muted:
			AudioServer.set_bus_volume_db(0, linear_to_db(0.0))
		else:
			AudioServer.set_bus_volume_db(0, linear_to_db(volume_value / 100.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_h_slider_value_changed(value: float) -> void:
	volume_value = value
	AudioServer.set_bus_volume_db(0, linear_to_db(value / 100.0))
	save_settings()

func _on_check_button_toggled(toggled_on: bool) -> void:
	muted = toggled_on
	if muted:
		AudioServer.set_bus_volume_db(0, linear_to_db(0.0)) # Silencia totalment
	else:
		# Restableix el volum anterior (recuperat d'una variable existent)
		AudioServer.set_bus_volume_db(0, linear_to_db(volume_value / 100.0))
	save_settings()

func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	fullscreen = toggled_on
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	save_settings()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
