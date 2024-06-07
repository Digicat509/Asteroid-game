extends RigidBody2D

signal distroyed(position, points)
@export var MIN_X_SPEED = -20.0
@export var MIN_Y_SPEED = -20.0
@export var MAX_X_SPEED = 20.0
@export var MAX_Y_SPEED = 20.0
@export var MIN_HP = 1
@export var MAX_HP = 4
var HP
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = MAX_HP
	$HPBar.max_value = HP
	$HPBar.value = HP
	rotation = randf_range(0, 2*PI)

func target(t):
	player = t
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = player.global_position.angle_to_point(position)
	rotation -= PI/2
	if position.distance_to(player.position) < 300:
		set_linear_velocity(Vector2(MAX_X_SPEED, MAX_Y_SPEED).rotated(rotation+PI))
	else:
		linear_velocity = Vector2.ZERO
	$HPBar.value = HP
	if HP <= 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group('lasers'):
		HP -= 1
		linear_velocity += (body.linear_velocity.normalized()*10)
		body.queue_free()
	if body.is_in_group('players'):
		linear_velocity -= ((body.linear_velocity/4)*body.linear_velocity.normalized())
		HP -= 2
	if(body.is_in_group("asteroids")):
		emit_signal("hit")
		linear_velocity = -linear_velocity/4
