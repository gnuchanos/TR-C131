extends CharacterBody3D

@export var max_health := 100
@export var speed := 5.0

var current_health := 100
var target_player: Node3D = null
var Wait := 0.5

@onready var visual = $"6ArrowIdiot"  # Model node'un
@onready var fight_area = $FightArea
@onready var idiot_area = $IdiotArea
@onready var anim = $"6ArrowIdiot/anim"
var TargetInArea = false
var DieOneTimePlay = false

func _ready():
	current_health = max_health

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	if target_player:
		var dir = target_player.global_position - global_position
		dir.y = 0
		if dir.length() > 0.1:
			dir = dir.normalized()
			
			# Model sadece Y ekseninde hedefe bakacak
			var target_pos = target_player.global_position
			var visual_pos = visual.global_transform.origin
			target_pos.y = visual_pos.y
			visual.look_at(target_pos, Vector3.UP)
			
			# Eğer modelin farklı yönde bakıyorsa düzeltmek için 90 derece döndür
			visual.rotate_y(deg_to_rad(90))  # Gerekirse 90 yerine -90 deneyebilirsin
			
			# Hedefe doğru yürü
			velocity.x = dir.x * speed
			velocity.z = dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if Wait > 0:
		Wait -= delta
	else:
		if TargetInArea:
			$hit.play()
			GlobalVAR.PlayerHealth -= 10
			Wait = 0.5
			anim.play("cfp/idl_hit")
			GlobalVAR.UiUpdate = true
		else:
			anim.play("cfp/idl")

	if current_health <= 0:
		if not DieOneTimePlay:
			$die.play()
			DieOneTimePlay = true
			

		if not $die.playing:
			queue_free()


	move_and_slide()

func apply_damage(amount):
	anim.play("cfp/idl_GetHit")
	current_health -= amount

func _on_idiot_area_body_entered(body):
	if body.name == "FPS":
		TargetInArea = true

func _on_idiot_area_body_exited(body: Node3D) -> void:
	if body.name == "FPS":
		TargetInArea = false

func _on_fight_area_body_entered(body):
	if body.name == "FPS":
		target_player = body

func _on_fight_area_body_exited(body):
	if body == target_player:
		target_player = null
