extends RigidBody2D

@export var segment_scene: PackedScene
@export var SPEED = 75
@export var MIN_HP = 50
@export var MAX_HP = 200
@export var MASS = 1200
@export var range = 600
var HP
var damage = 10
var player
var segments = []
var rotationalVelocity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	HP = MAX_HP
	$HPBar.max_value = HP
	$HPBar.value = HP
	mass = MASS
	#rotation = randf_range(0, 2*PI)
	for i in randi_range(2, 2):
		var segment = segment_scene.instantiate()
		add_child(segment)
		segment.position = Vector2(0, 65*(i+1)).rotated(rotation)
		segment.rotation = rotation
		segment.target(player)
		segments.append(segment)
	$TurnTimer.start(2)

func target(t):
	player = t
	for s in segments:
		s.target(t)

func _physics_process(delta):
	rotation += rotationalVelocity
	set_linear_velocity((Vector2.UP*SPEED).rotated(rotation))
	for s in segments:
		s.set_linear_velocity((Vector2.UP*SPEED).rotated(rotation))
	$HPBar.value = HP
	if HP <= 0:
		queue_free()


func _on_turn_timer_timeout():
	rotationalVelocity = randf_range(-PI/1024, PI/1024)
	pass

func _on_body_entered(body):
	if body.is_in_group('players'):
		HP -= body.damage
	if(body.is_in_group("asteroids")):
		HP -= body.damage
	if body.is_in_group("lasers"):
		HP -= body.damage
		body.queue_free()
