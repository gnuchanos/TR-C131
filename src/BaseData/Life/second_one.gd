extends CharacterBody3D


func _process(_delta: float) -> void:
	$CubeChan2/AnimationPlayer.play("idl")
