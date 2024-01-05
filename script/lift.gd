extends StaticBody3D


func interact():
	if Game.player.is_holding("Key"):
		Game.player.get_holding().queue_free()
		Game.player.position.y += 50
		queue_free()
	else:
		Game.say("I need a key.")
