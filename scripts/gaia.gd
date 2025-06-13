extends CharacterBody3D

@onready var planet : CSGSphere3D = $"../Planète"

var r : float
var theta : float = PI/2
var phi : float = 0
var PT : Vector2

func _ready():
	r = planet.radius + 0.01
	PT = Vector2(phi, theta)

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
	PT = Vector2(phi, theta)
	
