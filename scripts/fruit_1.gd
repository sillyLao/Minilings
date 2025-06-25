extends Area3D

@onready var planet : CSGSphere3D = $"../Planète"

var r : float
var theta : float = PI/3
var phi : float = PI/4

func _ready():
	position = Vector3(r*sin(theta)*sin(phi), r*cos(theta), r*sin(theta)*cos(phi))
	rotation = Vector3(theta+PI/2, phi, float(theta-PI < 0)*PI)
