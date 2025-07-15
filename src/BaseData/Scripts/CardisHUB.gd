extends Node3D

var x0Speed = randf_range(-1, 1)
var x1Speed = randf_range(-1, 1)
var x2Speed = randf_range(-1, 1)
var x3Speed = randf_range(-1, 1)

var timer = randf_range(1, 5)

@onready var x0 = $"Cardis/3DMap/r0"
@onready var x1 = $"Cardis/3DMap/r1"
@onready var x2 = $"Cardis/3DMap/r2"
@onready var x3 = $"Cardis/3DMap/r3"

@onready var EnergyRotate = $Cardis/energyDC/rotate
@onready var startEngine = $Cardis/startEngineObject
@onready var InsideSoumd = $InsideSound
@onready var _3DMapRotate = $Cardis/screen1

var AreaEnter = false
var StartGameTime = 5

@onready var talk = $talkArea/firstONE/talkFirstOne
var talkFinish = false
# preload 2 sound for first talk
var talkTurkishSound = preload("res://BaseData/Sound/talk_turkish.wav")
var talkenglishsound = preload("res://BaseData/Sound/talk_english.wav")

func _ready() -> void:
	$Cardis/centerObject/CenterAnim.play("loop")
	GlobalVAR.PlayerCanJump = false
	if GlobalVAR.lang == "turkish":
		talk.stream = talkTurkishSound
	elif GlobalVAR.lang == "english":
		talk.stream = talkenglishsound
	talk.play()

func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		timer = randf_range(1, 5)

		x0Speed = randf_range(-1, 1)
		x1Speed = randf_range(-1, 1)
		x2Speed = randf_range(-1, 1)
		x3Speed = randf_range(-1, 1)

	x0.rotate_y(x0Speed * delta)
	x1.rotate_y(x1Speed * delta)
	x2.rotate_y(x2Speed * delta)
	x3.rotate_y(x3Speed * delta)

	_3DMapRotate.rotate_y(0.1 * delta)
	EnergyRotate.rotate_y(-1 * delta)

	if not InsideSoumd.playing:
		InsideSoumd.play()

	if not talk.playing:
		talkFinish = true

	if not AreaEnter:
		if StartGameTime > 0:
			StartGameTime -= delta
		else:
			StartGameTime = 5
			get_tree().change_scene_to_file("res://GameData/Scenes/gameScene.tscn")
	else:
		$ui.visible = true
		StartGameTime = 5
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://GameData/Scenes/gameScene.tscn")

		# keep watch
		var FPS_Player = $FPS
		var Watcher = $talkArea/firstONE

		var target_pos = FPS_Player.global_transform.origin
		var watcher_pos = Watcher.global_transform.origin

		target_pos.y = watcher_pos.y
		Watcher.look_at(target_pos, Vector3.UP)
		Watcher.rotate_y(deg_to_rad(90))

	if GlobalVAR.lang == "turkish":
		$ui/strtext.text = "Haritayı gezebilirsin Oyuna başlamak için Enter'a bas."
	elif GlobalVAR.lang == "english":
		$ui/strtext.text = "You can explore the map. Press Enter to start the game."

func _on_exit_area_body_entered(body: Node3D) -> void:
	if body.name == "FPS":
		$ui.show()
		$ui/strtext.show()
		AreaEnter = true
