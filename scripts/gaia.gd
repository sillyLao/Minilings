extends CharacterBody3D

@onready var planet : CSGSphere3D = $"../Planète"

var r = 2.001
var theta = PI/2
var phi = 0

func _physics_process(_delta):
	theta = theta - (PI+PI) * floor(theta / (PI+PI))
	phi = phi - (PI+PI) * floor(phi / (PI+PI))
	# déplacements manuels
	position = Vector3(r*sin(theta)*sin(phi), r*cos(theta), r*sin(theta)*cos(phi))
	if Input.is_action_pressed("ui_left"):
		phi -= PI/400
	if Input.is_action_pressed("ui_right"):
		phi += PI/400
	if Input.is_action_pressed("ui_up"):
		theta -= PI/400
	if Input.is_action_pressed("ui_down"):
		theta += PI/400
	#rotation
	var dir = planet.position.direction_to(position)
	rotation = Vector3(theta+PI/2, phi, float(theta-PI < 0)*PI)
	print(rotation)
	
