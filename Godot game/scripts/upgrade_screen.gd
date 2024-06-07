extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_upgrade_speed_pressed():
	if VariableStorage.get_crystals() >= 5:
		VariableStorage.add_crystals(-5)
		VariableStorage.add_speed(10)


func _on_upgrade_damage_pressed():
	if VariableStorage.get_crystals() >= 8:
		VariableStorage.add_crystals(-8)
		VariableStorage.add_damage(1)


func _on_upgrade_fire_amount_pressed():
	if VariableStorage.get_crystals() >= 15:
		VariableStorage.add_crystals(-15)
		VariableStorage.add_fireAmount(1)


func _on_upgrade_fire_speed_pressed():
	if VariableStorage.get_crystals() >= 5:
		VariableStorage.add_crystals(-5)
		VariableStorage.add_fireSpeed(-.02)
