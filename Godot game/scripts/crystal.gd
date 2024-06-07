extends Area2D

func _on_crystal_body_entered(body):
	if(body.is_in_group("players")):
		VariableStorage.add_crystals(1)
		queue_free()
