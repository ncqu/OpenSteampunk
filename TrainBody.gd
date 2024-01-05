extends StaticBody3D
@onready var infopanel = preload("res://info_panel.tscn")

func click_order():
	var ip = infopanel.instantiate()
	ip.visible = true
	get_parent().add_child(ip)
	ip.new_infopanel(get_parent().info)
