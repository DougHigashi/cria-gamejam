extends CharacterBody3D

@onready var pivot := $Pivot
@onready var player := $Player

@export var speed := 3
@export var sprint_multiplier := 2
@export var rotate_speed := 0.05
@export var gravity := -300
var rot_dir = 0


func _physics_process(delta: float) -> void:
	rotate_player(get_rotation_vector())
	move_player(get_input_vector())
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	
	var vec = Vector3()
	var vec2 = Vector3()
	vec2.z = Input.get_action_strength("move_bw") - Input.get_action_strength("move_fw")
	vec.y = Input.get_action_strength("rotate_r") - Input.get_action_strength("rotate_l")
	print(vec)
	print(vec2)
	print(rot_dir)


func get_rotation_vector():
	var rotation_vector = Vector3.ZERO
	rotation_vector.y = Input.get_action_strength("rotate_l") - Input.get_action_strength("rotate_r")
	if(Input.is_action_pressed("rotate_l")):
		rot_dir += Input.get_action_strength("rotate_l") - Input.get_action_strength("rotate_r")
	elif(Input.is_action_pressed("rotate_r")):
		rot_dir += Input.get_action_strength("rotate_l") - Input.get_action_strength("rotate_r")
	
	return rotation_vector

func rotate_player(rotation_vector):
	if(rotation_vector != Vector3.ZERO):
		pivot.rotate(rotation_vector, rotate_speed)

func get_input_vector():
	var input_vector = Vector3.ZERO
	if(Input.get_action_strength("move_bw")):
		input_vector.z = -1
	elif(Input.get_action_strength("move_fw")):
		input_vector.z = 1

	return input_vector

func get_sprint():
	var sprinting
	if Input.get_action_strength("sprint") != 0:
		return

func move_player(input_vector):
	velocity = input_vector.rotated(Vector3(0, 1, 0), rot_dir * rotate_speed) * speed
