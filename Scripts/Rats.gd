extends Node3D

@export var radius: float

var floor: StaticBody3D
var floorShape: WorldBoundaryShape3D

var playerIn: bool
var playerRef: Player

func _ready():
	floor = $Floor
	floorShape = $Floor/Shape.shape

func _process(_dt):
	UpdateFloor()

func UpdateFloor():
	if playerIn:
		floor.visible = true
		var dir: Vector3 = (position - playerRef.position).normalized()
		playerRef.up_direction = dir
		floorShape.plane = Plane(dir, -radius)
	else:
		floor.visible = false

func AreaCollision(body, inside: bool):
	if body.is_in_group("Player"):
		playerRef = body
		playerIn = inside