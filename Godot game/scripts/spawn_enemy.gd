extends RigidBody2D

signal distroyed(position, points)
@export var laser_scene: PackedScene
@export var spawned_enemy: PackedScene
@export var SPEED = 50
@export var MIN_HP = 50
@export var MAX_HP = 200
@export var MASS = 1200
@export var range = 600
var HP
var damage = 10
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = MAX_HP
	$HPBar.max_value = HP
	$HPBar.value = HP
	mass = MASS
	rotation = randf_range(0, 2*PI)

func target(t):
	player = t


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = player.global_position.angle_to_point(position)
	rotation -= PI/2
	if position.distance_to(player.position) < range and position.distance_to(player.position) > 250:
		set_linear_velocity((Vector2.UP*SPEED).rotated(rotation))
	elif position.distance_to(player.position) < range:
		set_linear_velocity((Vector2.UP*SPEED).rotated(rotation+PI/2)+(Vector2.UP*clamp(player.linear_velocity.length(), 0, SPEED)).rotated(player.rotation))
	else:
		linear_velocity = Vector2.ZERO
	$HPBar.value = HP
	if HP <= 0:
		queue_free()

func _process(delta):
	if position.distance_to(player.position) < 1000:
		if($Spawn_Timer.is_stopped()):
			$Spawn_Timer.start()
	else:
		$Spawn_Timer.stop()

func _on_body_entered(body):
	if body.is_in_group('players'):
		HP -= body.damage
	if(body.is_in_group("asteroids")):
		HP -= body.damage
	if body.is_in_group("lasers"):
		HP -= body.damage
		body.queue_free()

func _on_laser_timer_timeout():
	#if position.distance_to(player.position) < 300:
	#	var laser = laser_scene.instantiate()
	#	get_parent().add_child(laser)
	#	laser.set_collision_layer_value(1, true)
	#	laser.position = position - Vector2(0, 20).rotated(rotation)
	#	laser.rotation = rotation
	#	laser.linear_velocity = Vector2.UP.rotated(rotation)*1000
	pass


func _on_spawn_timer_timeout():
	randomize()
	$Spawn_Timer.wait_time = randi_range(15, 30)
	var enemy = spawned_enemy.instantiate()
	get_parent().add_child(enemy)
	enemy.position = position - Vector2(0, 50).rotated(rotation)
	enemy.rotation = rotation
	enemy.target(player)
	pass # Replace with function body.
