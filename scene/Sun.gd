extends DirectionalLight3D

func rn():
	$AnimationPlayer.play("sun")

func _ready():
	rn()

func _on_animation_player_animation_finished(anim_name):
	rn()
