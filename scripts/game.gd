extends Node3D

@onready var gaia = $gaia

func _physics_process(_delta):
	$Debug.text = "[b]Cart : [/b]" + str(gaia.position) + "
[b]r         : [/b]" + str(gaia.r) +"
[b]theta : [/b]" + str(gaia.theta) +"
[b]phi     : [/b]" + str(gaia.phi) +"
"
