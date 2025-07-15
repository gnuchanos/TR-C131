extends CharacterBody3D


func _process(delta: float) -> void:
	$CubeChan2/AnimationPlayer.play("idl")
