extends Node3D


var AreaEnter = false
var nextLevelTimer = 5

@onready var raycast = $FPS/head/GunRay
var attack_damage = 25

@onready var IdiotsList = [
	$npc/Idiot6ArrowCap/UniParticles3D,
	$npc/Idiot6ArrowCap2/UniParticles3D,
	$npc/Idiot6ArrowCap3/UniParticles3D,
	$npc/Idiot6ArrowCap4/UniParticles3D,
	$npc/Idiot6ArrowCap5/UniParticles3D,
	$npc/Idiot6ArrowCap6/UniParticles3D,
	$npc/Idiot6ArrowCap7/UniParticles3D,
	$npc/Idiot6ArrowCap8/UniParticles3D,
	$npc/Idiot6ArrowCap9/UniParticles3D,
	$npc/Idiot6ArrowCap10/UniParticles3D,
	$npc/Idiot6ArrowCap11/UniParticles3D,
	$npc/Idiot6ArrowCap12/UniParticles3D,
	$npc/Idiot6ArrowCap13/UniParticles3D,
	$npc/Idiot6ArrowCap14/UniParticles3D,
	$npc/Idiot6ArrowCap15/UniParticles3D
]

var waitWeapon = 0
var easterEggAreaEnter = false

@onready var music = $music
@onready var easter = $easterArea/easter
@onready var ambiance = $ambiance

func _ready() -> void:
	GlobalVAR.PlayerHandReady = true
	GlobalVAR.PlayerCanJump   = true

	for i in IdiotsList:
		i.stop()

	$easterYO/anim.play("idle")

	if not GlobalVAR.PlayerHandReady:
		$FPS/head/SubViewportContainer/SubViewport/Camera3D/Weapon31.hide()
		$FPS/head/SubViewportContainer/SubViewport/Camera3D/flashLight.hide()
	else:
		$FPS/head/SubViewportContainer/SubViewport/Camera3D/Weapon31.show()
		$FPS/head/SubViewportContainer/SubViewport/Camera3D/flashLight.show()

func _process(delta):
	if waitWeapon > 0:
		waitWeapon -= delta
	else:
		if Input.is_action_pressed("leftM"):
			if raycast.is_colliding():
				var hit = raycast.get_collider()
				if hit and hit.has_method("apply_damage"):
					hit.apply_damage(attack_damage)
			waitWeapon = 0.7

	if AreaEnter:
		if nextLevelTimer > 0:
			nextLevelTimer -= delta
		else:
			get_tree().change_scene_to_file("res://GameData/Scenes/youWin.tscn")

	if GlobalVAR.PlayerHealth == 0:
		get_tree().change_scene_to_file("res://GameData/Scenes/gameScene.tscn")
		GlobalVAR.PlayerHealth = 100

	if easterEggAreaEnter:
		if not easter.playing:
			easter.play()
		music.stop()
		ambiance.stop()
	else:
		if not GlobalVAR.disableMusic:
			if not music.playing:
				music.play()
		else:
			music.stop()

		if not ambiance.playing:
			ambiance.play()
		easter.stop()

	$WorldEnvironment.environment.sky_rotation.y -= 0.05 * delta

func _on_finish_area_body_entered(body: Node3D) -> void:
	if body.name == "FPS":
		AreaEnter = true
		$FPS/energy.visible = true
func _on_finish_area_body_exited(body: Node3D) -> void:
	if body.name == "FPS":
		AreaEnter = false
		$FPS/energy.visible = false


func _on_easter_area_body_entered(body: Node3D) -> void:
	if body.name == "FPS":
		easterEggAreaEnter = true
func _on_easter_area_body_exited(body: Node3D) -> void:
	if body.name == "FPS":
		easterEggAreaEnter = false
