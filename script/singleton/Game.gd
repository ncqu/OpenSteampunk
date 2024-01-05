extends Node

var buildings = {
	"brick_house_small_singular" : preload("res://brick_house_small_singular.tscn"),
	"street" : preload("res://street.tscn"),
	"footpath" : preload("res://footpath.tscn")
}

enum state {
	GAME_IDLE,
	GAME_BEGIN_TOWER,
	GAME_BUILD,
}
var placing = 0
var game_state = state.GAME_BEGIN_TOWER
