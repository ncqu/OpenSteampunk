extends Control
@onready var player = null
@onready var placeholder = $ScrollContainer/VBoxContainer/Placeholder
@onready var placeholder_button = $ScrollContainer/VBoxContainer/PlaceholderButton

var global = {}

func new_infopanel(dict):
	visible = true
	global = dict
	for element in dict:
		#if placeholder == null:
		#	while placeholder == null:
		#		if placeholder != null:
		#			break
		#			$Window.hide()
		#	$Window.hide()
		if placeholder != null:
			if element.begins_with("BT_"):
				pass
			else:
				var pl = placeholder.duplicate()
				pl.visible = true
				pl.get_node("name").text = element
				pl.get_node("data").text = dict[element]
				pl.name = element
				$ScrollContainer/VBoxContainer.add_child(pl)
				
#func _process(delta):
#	for element in global:
#		var pl = get_node("ScrollContainer/VBoxContainer/" + element)
#		if pl != null:
#			pl.get_node("data").text = global[element]


func _on_close_pressed():
	queue_free()
