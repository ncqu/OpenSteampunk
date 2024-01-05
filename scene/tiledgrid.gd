extends Node3D
@onready var grid_cell = preload("res://building_tile.tscn")
var grid_size = 50
var cell_size = 3
var cell_spacing = 0.1

func generate_grid():
	for x in range(grid_size):
		for z in range(grid_size):
			var grid_cell_instance = grid_cell.instantiate()
			grid_cell_instance.transform.origin = Vector3(x * (cell_size + cell_spacing),0.1, z * (cell_size + cell_spacing))
			add_child(grid_cell_instance)
