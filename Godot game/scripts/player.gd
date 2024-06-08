extends RigidBody2D

@export var MASS = 1800
@export var laser_scene: PackedScene
signal hit(value)
signal move(x, y)
var screen_size = Vector2.ZERO
var MAX_LINEAR_SPEED = 500
var linear_speed = 0
var linear_acceleration = 2
var positionReset = true
var start_postion = Transform2D(0, Vector2.ZERO)
var HP = 120
var damage = 10
var canFire = true

func _ready():
	physics_material_override.friction = 0
	mass = MASS
	inertia = MASS*.5
	$RightParticles.emitting = false
	$LeftParticles.emitting = false
	screen_size = get_viewport_rect().size

func _input(event):
	if event.is_action_pressed("fire") and canFire:
		$Fire_Timer.start(VariableStorage.get_fireSpeed())
		canFire = false
		for i in VariableStorage.get_fireAmount():
			var laser = laser_scene.instantiate()
			get_parent().add_child(laser)
			laser.set_collision_layer_value(3, true)
			laser.set_collision_mask_value(3, true)
			laser.set_damage(VariableStorage.get_damage())
			laser.position = position - Vector2(i*3-(VariableStorage.get_fireAmount()/2)*3, 35-abs(i-(VariableStorage.get_fireAmount()/2))).rotated(rotation)
			laser.rotation = rotation

func _physics_process(delta):
	if(not VariableStorage.physics):
		angular_velocity = 0
	linear_speed = linear_velocity.length()
	$RightParticles.emitting = false
	$LeftParticles.emitting = false
	$AnimatedSprite2D.play("still")
	if Input.is_action_pressed("break"):
		if(linear_speed != 0):
			linear_speed -= linear_acceleration
			linear_velocity = linear_velocity.normalized()*linear_speed
		$AnimatedSprite2D.play("still")
	if Input.is_action_pressed("turn_left") and Input.is_action_pressed("turn_right"):
		apply_central_force(Vector2(0, -VariableStorage.get_speed()).rotated(rotation))
		$RightParticles.emitting = true
		$LeftParticles.emitting = true
		$AnimatedSprite2D.play("forward")
	elif not VariableStorage.physics and Input.is_action_pressed("turn_left"):
		angular_velocity = (-PI*2)/3
		$RightParticles.emitting = true
		$LeftParticles.emitting = false
		$AnimatedSprite2D.play("turnRight")
	elif not VariableStorage.physics and Input.is_action_pressed("turn_right"):
		angular_velocity = (PI*2)/3
		$RightParticles.emitting = false
		$LeftParticles.emitting = true
		$AnimatedSprite2D.play("turnLeft")
	elif Input.is_action_pressed("turn_right"):
		if(VariableStorage.physics):
			apply_force(Vector2(0, -150).rotated(rotation), Vector2(-22, 12).rotated(rotation))
		$RightParticles.emitting = false
		$LeftParticles.emitting = true
		$AnimatedSprite2D.play("turnLeft")
	elif Input.is_action_pressed("turn_left"):
		if(VariableStorage.physics):
			apply_force(Vector2(0, -150).rotated(rotation), Vector2(22, 12).rotated(rotation))
		$RightParticles.emitting = true
		$LeftParticles.emitting = false
		$AnimatedSprite2D.play("turnRight")
	if Input.is_action_pressed("accelerate"):
		apply_central_force(Vector2(0, -VariableStorage.get_speed()).rotated(rotation))
		$RightParticles.emitting = true
		$LeftParticles.emitting = true
		$AnimatedSprite2D.play("forward")
	if(abs(linear_speed) > MAX_LINEAR_SPEED):
		linear_velocity = linear_velocity.normalized()*500

func _integrate_forces(state):
	if not positionReset:
		state.set_transform(start_postion)
		positionReset = true
	emit_signal("move", state.get_transform().x, state.get_transform().y)

func start(location):
	positionReset = false
	linear_velocity = Vector2.ZERO
	rotation = 0
	start_postion = Transform2D(rotation, location)

func _on_player_body_entered(body):
	if(body.is_in_group("enemys")):
		emit_signal("hit", body.damage) 
	if(body.is_in_group("asteroids")):
		emit_signal("hit", body.damage)
	if(body.is_in_group("lasers")):
		emit_signal("hit", body.damage)
		body.queue_free()

func _on_fire_timer_timeout():
	canFire = true
