extends Camera3D

@onready var main_camera = $"../../../Camera3D"

func _process(_delta: float) -> void:
	global_position = main_camera.global_position + Vector3(0, 1.75, 0)

	var target = main_camera.global_position + -main_camera.global_transform.basis.z * 10.0
	look_at(target, Vector3.UP)
