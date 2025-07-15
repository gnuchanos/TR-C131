extends CharacterBody3D




func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	$fatih/anim.play("fatih_/idl")

	move_and_slide()
