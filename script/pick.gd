extends RigidBody3D

func disable():
	$CollisionShape3D.disabled = true
	freeze = true

func enable():
	$CollisionShape3D.disabled = false
	freeze = false
