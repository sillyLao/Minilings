extends CharacterBody3D

@onready var planet : CSGSphere3D = $"../Planète"

var mitosis_rate = 0.3

var r : float
var theta : float = PI/3
var phi : float = PI/4
var PT : Vector2
var children_count : float = 0

func _ready():
	r = planet.radius + 0.002
	PT = Vector2(phi, theta)
	get_node("..").minilings_number += 1
	print(get_node("..").minilings_number)
	$MitosisTimer.wait_time += randf()
	$MitosisTimer.start()

func _physics_process(_delta):
	theta = theta - (PI+PI) * floor(theta / (PI+PI))
	phi = phi - (PI+PI) * floor(phi / (PI+PI))
	position = Vector3(r*sin(theta)*sin(phi), r*cos(theta), r*sin(theta)*cos(phi))
	rotation = Vector3(theta+PI/2, phi, float(theta-PI < 0)*PI)
	#if phi < PT.x:
		#$AnimatedSprite3D.flip_h = true
	#elif phi > PT.x:
		#$AnimatedSprite3D.flip_h = false
	$AnimatedSprite3D.flip_h = (phi < PT.x)
	PT = Vector2(phi, theta)
	

func modulo(a: float, n: float) -> float:
	return a - floor(a/n) * n

func mitosis():
	$GPUParticles3D.emitting = true
	var child =	duplicate()
	child.theta = theta
	child.phi = phi
	child.evolve_color()
	get_node("..").add_child(child)
	children_count += 1


#func evolve_color():
	#var sprite = get_node("AnimatedSprite3D")
	#var n = 0
	#var color_diff : Vector3 = Vector3.ZERO
	#if abs(sprite.modulate[n]-1) > abs(sprite.modulate[n+1]-1):
		#if abs(sprite.modulate[n]-1) > abs(sprite.modulate[n+2]-1):
			#pass
		#else:
			#n = 2
	#else:
		#if abs(sprite.modulate[n+1]-1) > abs(sprite.modulate[n+2]-1):
			#n = 1
		#else:
			#n = 2
	#if randf() <= 0.6:
		#var mod = sign(sprite.modulate[n]-1)*0.04
		#sprite.modulate[n] += randf_range(-0.08+mod, 0.08+mod)
	#else:
		#var tout : Array = [0, 1, 2]
		#tout.erase(n)
		#sprite.modulate[tout[randi_range(0,1)]] += randf_range(-0.08, 0.08)

func evolve_color() -> void:
	var sprite : AnimatedSprite3D = get_node("AnimatedSprite3D")
	sprite.modulate.h = modulo(sprite.modulate.h + (randf())/30, 1)
	sprite.modulate.s = clamp(sprite.modulate.s + (randf() - 0.15)/10, 0, 1)


func _on_mitosis_timer_timeout():
	$MitosisTimer.wait_time = 1
	$MitosisTimer.start()
	print("a")
	if randf() <= mitosis_rate:
		mitosis()
		print("b")
		if randf() < sqrt(children_count)/1.5:
			get_node("..").deaths += 1
			queue_free()
