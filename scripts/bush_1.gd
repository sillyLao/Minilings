extends StaticBody3D

@onready var planet : CSGSphere3D = $"../Planète"
@onready var fruit_scene : PackedScene = preload("res://scenes/fruit_1.tscn")

var r : float
var theta : float = PI/3
var phi : float = PI/4
var slots : Array = [Vector2(-0.003, -0.003), Vector2(0.003, -0.003), Vector2(0.00, 0.003)]

func _ready():
	r = planet.radius + 0.001
	position = Vector3(r*sin(theta)*sin(phi), r*cos(theta), r*sin(theta)*cos(phi))
	rotation = Vector3(theta+PI/2, phi, float(theta-PI < 0)*PI)


func _on_timer_fruit_timeout():
	for PT in slots:
		var fruit = fruit_scene.instantiate()
		fruit.r = r
		fruit.theta = theta+PT.y
		fruit.phi = phi+PT.x
		get_node("..").add_child(fruit)
