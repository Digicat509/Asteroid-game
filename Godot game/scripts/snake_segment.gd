extends RigidBody2D

@export var MIN_HP = 20
@export var MAX_HP = 40
@export var MASS = 1200
var player
var HP
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = MAX_HP
	$HPBar.max_value = HP
	$HPBar.value = HP

func target(t):
	player = t
	$Turret.target(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	global_rotation = get_parent().global_position.angle_to_point(global_position)
	global_rotation -= PI/2
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
