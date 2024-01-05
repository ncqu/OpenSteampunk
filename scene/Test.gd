extends Node3D

@onready var scenemakeruppers = $Scenemakeruppers
@onready var clickableobjects = $ClickableObjects
@onready var player = $Player #All root scene nodes must have this. Check Game singleton.
@onready var clocktower = $ClickableObjects/Clocktower
@onready var startUI = $clock
@onready var placeUI = $placeUI
@onready var HBox = $Control/ScrollContainer/HBoxContainer
var house

const RAY_LENGTH = 1000

func _ready():
	build_placement_menu()

func _physics_process(delta):
	$Label.text = str(Engine.get_frames_per_second())
	var space_state = get_world_3d().direct_space_state
	var cam = player.camera
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var bquery = PhysicsRayQueryParameters3D.create(origin, end, 2)
	var equery = PhysicsRayQueryParameters3D.create(origin, end)
	var bresult = space_state.intersect_ray(bquery)
	var eresult = space_state.intersect_ray(equery)
	clocktowerbuild(bresult, eresult)
	build(bresult, eresult)
	rotater()
	click_order(eresult, bresult)

func clocktowerbuild(result, eresult):
	if Game.game_state == Game.state.GAME_BEGIN_TOWER:
		if result != {}:
			startUI.visible = true
			clocktower.position = result["position"] 
	else:
		startUI.visible = false

func build(result, eresult):
	if Game.game_state == Game.state.GAME_BUILD:
		if result != {}:
			placeUI.visible = true
			house.position = result["position"]
	else:
		placeUI.visible = false

func rotater():
	if Input.is_action_just_pressed("rl"):
		if Game.game_state == Game.state.GAME_BEGIN_TOWER:
			clocktower.rotate_y(deg_to_rad(-15))
		elif Game.game_state == Game.state.GAME_BUILD:
			house.rotate_y(deg_to_rad(-90))
	if Input.is_action_just_pressed("rr"):
		if Game.game_state == Game.state.GAME_BEGIN_TOWER:
			clocktower.rotate_y(deg_to_rad(15))
		elif Game.game_state == Game.state.GAME_BUILD:
			house.rotate_y(deg_to_rad(90))

func click_order(result, resulte):
	if Input.is_action_just_pressed("click"):
		if result != {}:
			match Game.game_state:
				Game.state.GAME_IDLE:
					if result["collider"].get_parent() == clickableobjects or result["collider"].is_in_group("ExcludedClickables"):
						result["collider"].click_order()
				Game.state.GAME_BEGIN_TOWER:
					clocktower.position = result["position"]
					Game.game_state = Game.state.GAME_IDLE
				Game.state.GAME_BUILD:
					#house.position = result["position"]
					house.position.y = 0
					Game.game_state = Game.state.GAME_IDLE

func build_placement_menu():
	if len(HBox.get_children()) != 0:
		for child in HBox.get_children():
			child.queue_free()
	for building in Game.buildings:
		initiate_button(building)

func initiate_button(id):
	var button = Button.new()
	id.replace("_", " ")
	button.name = id
	button.text = id
	button.pressed.connect(new_placement.bind(id))
	HBox.add_child(button)

func new_placement(id):
	house = Game.buildings[id].instantiate()
	house.rotation = clocktower.rotation
	clickableobjects.add_child(house)
	Game.placing = 0
	Game.game_state = Game.state.GAME_BUILD
