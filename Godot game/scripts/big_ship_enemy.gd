extends RigidBody2D

signal distroyed(position, points)
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
	$Turret.target(t)
	$Turret2.target(t)
	
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

func _on_body_entered(body):
	if body.is_in_group('players'):
		HP -= body.damage
	if(body.is_in_group("asteroids")):
		HP -= body.damage
	if body.is_in_group("lasers"):
		HP -= body.damage
		body.queue_free()
