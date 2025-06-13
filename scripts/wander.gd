extends Node

@onready var agent = $"../.."
@onready var planet = $"../../../Planète"

@export var speed : float
@export var wander_range : float

func LookForPos(startpos : Vector2) -> Vector2:
	var theta = startpos.y
	var phi = startpos.x
	theta += randf_range(-1, 1)*asin(wander_range*0.08/planet.radius)
	phi += randf_range(-1, 1)*asin(wander_range*0.08/planet.radius)
	return Vector2(phi, theta)
