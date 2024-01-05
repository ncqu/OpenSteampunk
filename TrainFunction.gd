extends Area3D
signal train_stopped
signal train_started

@export var type = "STATION"



func _on_area_entered(area):
	if area.is_in_group("train"):
		emit_signal("train_stopped", area)


func _on_area_exited(area):
	if area.is_in_group("train"):
		emit_signal("train_started")
