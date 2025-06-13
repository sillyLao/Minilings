extends Camera3D

@onready var pivot = $".."
@onready var planet = $"../../Planète"

var rotating : bool = false
var mouse_pos_temp : Vector2 = Vector2.ZERO
var position_aim : Vector3

func _ready() -> void:
	position_aim = position

func _process(_delta):
	#rotation.x = clamp(rotation.x, -1, 1)
	position_aim.z = clamp(position_aim.z, planet.radius+0.1, planet.radius*2.5)
	position.z = lerp(position.z, position_aim.z, 0.08)

func _input(event):
	if event is InputEventMouse:
		if rotating:
			if event is InputEventMouseMotion:
				pivot.rotate(Vector3.UP,
					event.relative.x * lerp(-0.0002, -0.005, (position.z-planet.radius)/(planet.radius*1.5))
				)
				
				pivot.rotate_object_local(Vector3.RIGHT,
					event.relative.y * lerp(-0.0002, -0.005, (position.z-planet.radius)/(planet.radius*1.5))
				)
		if event.is_action_pressed("camera_rotate"):
			rotating = true
			mouse_pos_temp = get_viewport().get_mouse_position()
			print(mouse_pos_temp)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if event.is_action_released("camera_rotate"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_viewport().warp_mouse(mouse_pos_temp)
			rotating = false
	if event.is_action("scroll_up"):
		if position_aim.z > position_aim.z:
			position_aim.z = position.z
		position_aim.z += -0.1
	if event.is_action("scroll_down"):
		if position_aim.z < position_aim.z:
			position_aim.z = position.z
		position_aim.z += 0.1
		
	
