extends AnimationTree

@onready var playback = self.get("parameters/playback")

func _ready() -> void:
	active = true
	playback.travel("onpc_idle_")

func _process(delta: float) -> void:
	if Input.is_action_pressed("leftM"):
		playback.travel("onpc_idle_Talk")
	elif Input.is_action_pressed("rightM"):
		playback.travel("onpc_idle_think")
	elif Input.is_action_pressed("q"):
		playback.travel("onpc_idle_bye")
	elif Input.is_action_pressed("e"):
		playback.travel("onpc_idle__pcUse")
	else:
		playback.travel("onpc_idle_")
