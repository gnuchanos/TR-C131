extends Window

@onready var MouseSpeedText = $BLACKHOLE/VBoxContainer/mouseSpeedtext
@onready var MusicVolumeText = $BLACKHOLE/VBoxContainer/MusicVolumeText
@onready var EffectVolumeText = $BLACKHOLE/VBoxContainer/EffectVolumeText
@onready var AtmosphereVolumeText = $BLACKHOLE/VBoxContainer/AtmosphereVolumeText
@onready var VoiceVolumeText = $BLACKHOLE/VBoxContainer/VoiceVolumeText
@onready var FovText = $BLACKHOLE/VBoxContainer/fovText
@onready var ShadersText = $BLACKHOLE/VBoxContainer/shadersText

func _ready() -> void:
	if GlobalVAR.lang == "turkish":
		MouseSpeedText.text = "Fare Hızı"
		MusicVolumeText.text = "Müzik Ses Seviyesi"
		EffectVolumeText.text = "Efekt Ses Seviyesi"
		AtmosphereVolumeText.text = "Ortam Ses Seviyesi"
		VoiceVolumeText.text = "Seslendirme Seviyesi"
		FovText.text = "Görüş Açısı (FOV)"
		ShadersText.text = "Gölgelendiriciler"
	elif GlobalVAR.lang == "english":
		MouseSpeedText.text = "Mouse Speed"
		MusicVolumeText.text = "Music Volume"
		EffectVolumeText.text = "Effect Volume"
		AtmosphereVolumeText.text = "Atmosphere Volume"
		VoiceVolumeText.text = "Voice Volume"
		FovText.text = "Field of View (FOV)"
		ShadersText.text = "Shaders"

func _on_close_requested() -> void:
	self.hide()

var FullScreen = false
func _on_window_mode_pressed() -> void:
	if FullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		FullScreen = false
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/windowMode/WindowMode.text = "Pencere Modu"
		else:
			$BLACKHOLE/VBoxContainer/windowMode/WindowMode.text = "Window Mode"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		FullScreen = true
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/windowMode/WindowMode.text = "Tam Ekran"
		else:
			$BLACKHOLE/VBoxContainer/windowMode/WindowMode.text = "Full Screen"


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
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Shader 0 Aç"
		else:
			$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Open Shader 0"
	else:
		GlobalVAR.shader0 = true
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Shader 0 Kapat"
		else:
			$BLACKHOLE/VBoxContainer/shader0/shader0Button.text = "Close Shader 0"

func _on_shader_1_button_2_pressed() -> void:
	if GlobalVAR.shader1:
		GlobalVAR.shader1 = false
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Shader 1 Aç"
		else:
			$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Open Shader 1"
	else:
		GlobalVAR.shader1 = true
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Shader 1 Kapat"
		else:
			$BLACKHOLE/VBoxContainer/shader1/shader1Button.text = "Close Shader 1"

func _on_music_mute_button_pressed() -> void:
	if not GlobalVAR.disableMusic:
		GlobalVAR.disableMusic = true
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/windowMode2/musicMuteButton.text = "Müziği Aç"
		else:
			$BLACKHOLE/VBoxContainer/windowMode2/musicMuteButton.text = "Open Music"
	else:
		GlobalVAR.disableMusic = false
		if GlobalVAR.lang == "turkish":
			$BLACKHOLE/VBoxContainer/windowMode2/musicMuteButton.text = "Müziği Kapat"
		else:
			$BLACKHOLE/VBoxContainer/windowMode2/musicMuteButton.text = "Close Music"
