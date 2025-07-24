extends CanvasLayer

@onready var health = $health





func _ready() -> void:
	health.text = "Health: " + str(GlobalVAR.PlayerHealth)

func _process(_delta: float) -> void:
	if GlobalVAR.UiUpdate:
		health.text = "Health: " + str(GlobalVAR.PlayerHealth)
		GlobalVAR.UiUpdate = false

	$fps.text = "FPS: " + str(Engine.get_frames_per_second())
