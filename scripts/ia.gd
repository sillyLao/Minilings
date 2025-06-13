extends Node

@onready var agent : CharacterBody3D = $".."
@onready var timer : Timer = $"Timer"
@onready var Wander = $"Wander"

var goal_pos : Vector2

func _ready():
	await agent.ready
	doWander()

func _physics_process(delta):
	agent.theta = move_toward(agent.theta, goal_pos.y, Wander.speed/1000)
	agent.phi = move_toward(agent.phi, goal_pos.x, Wander.speed/1000)

func doWander():
	timer.wait_time = Wander.speed
	timer.start()
	goal_pos = Wander.LookForPos(agent.PT)
	print(agent.PT)
	print(goal_pos)
	
func _on_timer_timeout():
	doWander()
