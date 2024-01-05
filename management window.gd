extends Control

@onready var close = $close



func _on_close_pressed():
	visible = false
