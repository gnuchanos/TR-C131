extends Window




func _on_close_requested() -> void:
	self.hide()

var FullScreen = false
func _on_window_mode_pressed() -> void:
	if FullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		FullScreen = false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		FullScreen = true

func _on_mousespeed_slider_value_changed(value: float) -> void:
	GlobalVAR.MouseSpeed = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_effect_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effect"), value)

func _on_atmosphere_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Atmosphere"), value)

func _on_voice_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), value)

func _on_fov_slider_value_changed(value: float) -> void:
	GlobalVAR.PlayerFOV_Current = value
	GlobalVAR.PlayerFOV_MIN = value

func _on_shader_0_pressed() -> void:
	if GlobalVAR.shader0:
		GlobalVAR.shader0 = false
		$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Open Shader 0"
	else:
		GlobalVAR.shader0 = true
		$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Close Shader 0"

func _on_shader_1_button_2_pressed() -> void:
	if GlobalVAR.shader1:
		GlobalVAR.shader1 = false
		$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Open Shader 1"
	else:
		GlobalVAR.shader1 = true
		$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Close Shader 1"
