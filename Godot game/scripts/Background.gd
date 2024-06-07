extends CanvasLayer

@export var star_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in randi_range(7500, 10000):
		var star = star_scene.instantiate()
		star.position = Vector2(randi_range(-get_viewport().size.x*5, get_viewport().size.x*5), randi_range(-get_viewport().size.x*5, get_viewport().size.y*5))
		add_child(star)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func adjust(diff):
	for s in get_tree().get_nodes_in_group("stars"):
		s.position -= diff/1000

func _on_viewport_size_changed():
	get_tree().call_group("stars", "queue_free")
	randomize()
	for i in randi_range(7500, 10000):
		var star = star_scene.instantiate()
		star.position = Vector2(randi_range(-get_viewport().size.x*5, get_viewport().size.x*5), randi_range(-get_viewport().size.x*5, get_viewport().size.y*5))
		add_child(star)
