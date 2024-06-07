extends Area2D   

var damage = 10
var notReady
var velocity

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	pass

func _ready():
	notReady = true

func _process(delta):
	if(notReady):
		velocity = Vector2.UP.rotated(rotation)*20
		notReady = false

func _physics_process(delta):
	if(not notReady):
		position += velocity

func set_damage(new):
	damage = new

func _on_body_entered(body):
	if(body.is_in_group("players")):
		body.emit_signal("hit", damage)
	if(body.is_in_group("asteroids")):
		body.HP -= damage
	if(body.is_in_group("enemys")):
		body.HP -= damage
	queue_free()
