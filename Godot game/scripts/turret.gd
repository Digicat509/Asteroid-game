extends Node2D

signal distroyed(position, points)
@export var laser_scene: PackedScene
@export var range = 700
var damage = 10
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	rotation = randf_range(0, 2*PI)

func _process(delta):
	rotation = player.global_position.angle_to_point(global_position)
	pass

func target(t):
	player = t

func _on_timer_timeout():
	if global_position.distance_to(player.position) < range:
		var laser = laser_scene.instantiate()
		add_child(laser)
		laser.set_collision_layer_value(2, true)
		laser.set_collision_mask_value(2, true)
		laser.global_position = global_position
		laser.rotation = rotation
