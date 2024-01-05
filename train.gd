extends PathFollow3D
var order = ""
@export var speed = 0.03

var info = {
	"order" : order,
	"destination" : "venice",
}

func _ready():
	progress = 0

func _process(delta):
	info["order"] = order
	if order == "" and progress_ratio < 1:
		progress_ratio += speed * delta

func _on_area_3d_area_entered(area):
	if area.is_in_group("function"):
		order = area.type
		if order == "STATION":
			speed = 0
			await get_tree().create_timer(5).timeout
			order = ""
			speed = 0.03
		

