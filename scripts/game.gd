extends Node3D

@onready var gaia = $gaia
var minilings_number = 0
var deaths = 0

func _ready():
	for i in range(2):
		var miniling = $gaia.duplicate()
		#var miniling = preload("res://scenes/gaia.tscn").instantiate()
		add_child(miniling)

func _physics_process(_delta):
	$Debug.text = "[b]naissances : [/b]" + str(minilings_number) + "
[b]population : [/b]" + str(minilings_number - deaths)
