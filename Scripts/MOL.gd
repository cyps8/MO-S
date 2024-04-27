extends CharacterBody3D

class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var camDir: Vector3
var rightDir: Vector3

var verticalComponent: Vector3
var horizontalComponent: Vector3

func _physics_process(dt):
	camDir = ($Arm/Cam.global_position - position).normalized()
	rightDir = ($Arm/Cam/Right.global_position - $Arm/Cam.global_position).normalized()

	print(camDir)

	if is_on_floor():
		verticalComponent = Vector3.ZERO
	else:
		verticalComponent += -up_direction * gravity * dt

	var inputDir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (camDir * inputDir.y) + (rightDir * inputDir.x)

	horizontalComponent = direction * 3

	if Input.is_action_just_pressed("Jump"):
		verticalComponent += up_direction * JUMP_VELOCITY

	velocity = verticalComponent + horizontalComponent

	move_and_slide()

	#s$Mesh.rotation.y = deg_to_rad(up_direction.y * 90)

	$Mesh.rotation.x = deg_to_rad(up_direction.z * 90)

	$Mesh.rotation.z = deg_to_rad(up_direction.x * -90)