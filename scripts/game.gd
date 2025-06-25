extends Node3D

@onready var gaia = $gaia
var minilings_number = 0
var deaths = 0

func _ready():
	for i in range(3):
		var miniling = $gaia.duplicate()
		#var miniling = preload("res://scenes/gaia.tscn").instantiate()
		add_child(miniling)

func _process(delta):
	$Debug.text = str(snapped(delta*1000, 0.001)) + "ms | " + str(snapped((1/delta), 0.01)) + " FPS
	[b]naissances : [/b]" + str(minilings_number) + "
[b]population : [/b]" + str(minilings_number - deaths)
