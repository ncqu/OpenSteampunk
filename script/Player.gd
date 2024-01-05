extends CharacterBody3D

@export var speed = 30
@export var jump_vel = 4.5

var rayclider
var frame1 = Vector3.ZERO
var frame2 = Vector3.ZERO
var holdindex = 0

@onready var camera = $Camera3D

var look_sensitivity = ProjectSettings.get_setting("player/look_sensitivity")

func _physics_process(delta):
	var horizontal_velocity = Input.get_vector("a", "d", "w", "s").normalized() * speed
	velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z
	move_and_slide()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("revolve"):
			rotate_y(-event.relative.x * look_sensitivity)
			camera.rotate_x(-event.relative.y * look_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	if event is InputEventMouseButton: # up = 4, down = 5
		if event.button_index == 5:
			camera.fov += event.get_factor()
		elif event.button_index == 4:
			camera.fov -= event.get_factor()
		

func say(what):
	pass
	#says.text = what
	#await get_tree().create_timer(len(what)/5).timeout
	#says.text = ""

