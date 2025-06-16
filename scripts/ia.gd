extends Node

@onready var planet : CSGSphere3D = $"../../Planète"
@onready var agent : CharacterBody3D = $".."
@onready var timer : Timer = $"Timer"
@onready var Wander = $"Wander"

var goal_pos : Vector2
var theta_speed : float
var phi_speed : float

func _ready():
	await agent.ready
	doWander()

func _physics_process(delta):
	if not goal_pos == agent.PT:
		agent.theta = move_toward(agent.theta, goal_pos.y, theta_speed/1000)
		agent.phi = move_toward(agent.phi, goal_pos.x, phi_speed/1000)
	if $RayCast3D.is_colliding():
		print(4)

func WillCollide(pos : Vector2) -> bool:
	var r = planet.radius
	var theta = pos.y
	var phi = pos.x
	var goal_cart = Vector3(r*sin(theta)*sin(phi), r*cos(theta), r*sin(theta)*cos(phi))
	var goal_diff = agent.position - goal_cart
	$RayCast3D.position = agent.position
	$RayCast3D.target_position = -goal_diff
	$RayCast3D.force_raycast_update()
	$RayCast3D/Sprite3D.position = -goal_diff
	print("eeee  " + str($RayCast3D.get_collider()))
	print("eeee  " + str($RayCast3D.is_colliding()))
	return $RayCast3D.is_colliding()

func doWander():
	print(1)
	var can_move := false
	var temp_goal_pos = agent.PT
	while not can_move:
		temp_goal_pos = Wander.LookForPos(agent.PT)
		can_move = !WillCollide(temp_goal_pos)
	goal_pos = temp_goal_pos
	
	if goal_pos.x > goal_pos.y:
		theta_speed = (abs(agent.theta-goal_pos.y)*Wander.speed/abs(agent.phi-goal_pos.x))
		phi_speed = Wander.speed
	else:
		phi_speed = (abs(agent.phi-goal_pos.x)*Wander.speed/abs(agent.theta-goal_pos.y))
		theta_speed = Wander.speed
	timer.wait_time = Wander.speed
	timer.start()
	
func _on_timer_timeout():
	doWander()
