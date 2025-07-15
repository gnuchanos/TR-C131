extends Node3D


var AreaEnter = false
var nextLevelTimer = 5

@onready var raycast = $FPS/head/GunRay
var attack_damage = 10

func _ready() -> void:
	GlobalVAR.PlayerHandReady = true
	GlobalVAR.PlayerCanJump   = true
	if GlobalVAR.PlayerHandReady:
		$FPS/head/SubViewportContainer/SubViewport/Camera3D/Weapon31.show()

func _process(delta):
	if Input.is_action_just_pressed("leftM"):
		if raycast.is_colliding():
			var hit = raycast.get_collider()
			if hit and hit.has_method("apply_damage"):
				hit.apply_damage(attack_damage)

	if not $music.playing:
		$music.play()

	if AreaEnter:
		if nextLevelTimer > 0:
			nextLevelTimer -= delta
		else:
			get_tree().change_scene_to_file("res://GameData/Scenes/youWin.tscn")

	if GlobalVAR.PlayerHealth == 0:
		get_tree().change_scene_to_file("res://GameData/Scenes/gameScene.tscn")
		GlobalVAR.PlayerHealth = 100

func _on_finish_area_body_entered(body: Node3D) -> void:
	if body.name == "FPS":
		AreaEnter = true
		$FPS/energy.visible = true
func _on_finish_area_body_exited(body: Node3D) -> void:
	if body.name == "FPS":
		AreaEnter = false
		$FPS/energy.visible = false
