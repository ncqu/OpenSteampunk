extends StaticBody3D
@onready var infopanel = preload("res://info_panel.tscn")
@export  var function : NodePath
@onready var fn = get_node(function)

var order = "idle"
var train = "null"

var info = {
	"station function reference" : str(fn),
	"order" : order,
	"train" : train,
}

func click_order():
	var ip = infopanel.instantiate()
	ip.visible = true
	get_parent().add_child(ip)
	ip.new_infopanel(info)

func newtr(tr):
	train = tr.name

func oldtr():
	train = "null"

func _ready():
	fn.connect("train_stopped", newtr, 1)
	fn.connect("train_started", oldtr)
