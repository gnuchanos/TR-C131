extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Cardis_portable/AnimationPlayer.play("open")
	$CubeChan2/AnimationPlayer.play("idl")
