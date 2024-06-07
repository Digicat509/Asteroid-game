extends RigidBody2D

signal distroyed(position, points)
@export var SPEED = 20;
@export var MIN_HP = 10
@export var MAX_HP = 40
var HP
var damage = 10

func _ready():
	#if(VariableStorage.physics):
	physics_material_override.bounce = 1
	$AnimatedSprite2D.visible = false
	$HPBar.visible = false
	randomize()
	linear_velocity = Vector2(randf_range(-SPEED, SPEED), randf_range(-SPEED, SPEED))
	HP = randf_range(MIN_HP, MAX_HP)
	$HPBar.max_value = HP
	$HPBar.value = HP
	rotation = randf_range(0, 2*PI)
	mass = scale.x*3000
	await get_tree().create_timer(.25).timeout
	$AnimatedSprite2D.visible = true
	$HPBar.visible = true

func _process(delta):
	$HPBar.value = HP
	if HP <= 0:
		emit_signal("distroyed", global_position, $HPBar.max_value)
		queue_free()
	

func _on_asteroid_body_entered(body):
	if body.is_in_group("players"):
		HP -= body.damage
	if body.is_in_group("enemys"):
		HP -= body.damage
	if body.is_in_group("lasers"):
		HP -= body.damage
		body.queue_free()
