extends Node

@export var laser_scene: PackedScene
@export var asteroid_scene: PackedScene
@export var basic_enemy_scene: PackedScene
@export var ship_enemy_scene: PackedScene
@export var big_ship_enemy_scene: PackedScene
@export var snake_enemy_scene: PackedScene
@export var spawn_enemy_scene: PackedScene
@export var crystal_scene: PackedScene
@export var player_scene: PackedScene
var playing = false
var player

func new_game():
	player = player_scene.instantiate()
	add_child(player)
	player.position = $startPosition.position
	player.connect("hit", Callable($HUD, "_on_player_hit"))
	$asteroid_timer.start()
	$basic_enemy_timer.start()
	$ship_enemy_timer.start()
	$big_enemy_timer.start()
	$snake_enemy_timer.start()
	$HUD.start_game()
	playing = true
	VariableStorage.set_crystals(0)

func on_asteroid_distroyd(pos, HP):
	randomize()
	var size = round(clamp(randf_range(HP/20, HP*1.5/10), 1, 6))
	for i in range(0, size):
		var crystal = crystal_scene.instantiate()
		crystal.set_transform(Transform2D(randf_range(0, 2*PI), Vector2(pos.x + randf_range(-25*(HP/20), 25*(HP/20)), pos.y + randf_range(-25*(HP/20), 25*(HP/20)))))
		add_child(crystal)

func _process(delta):
	if(player != null):
		$Background.adjust(player.linear_velocity)

func _on_asteroid_timer_timeout():
	randomize()
	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)
	var pos = player.position - $startPosition.position + Vector2((randf_range(-get_viewport().size.x/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.x, 1.5*get_viewport().size.x)), (randf_range(-get_viewport().size.y/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.y, 1.5*get_viewport().size.y)))
	asteroid.position = pos
	asteroid.connect("distroyed", Callable(self, "on_asteroid_distroyd"))


func _on_HUD_game_start():
	new_game()


func _on_HUD_game_over():
	get_tree().call_group("enemys", "queue_free") 
	get_tree().call_group("crystals", "queue_free")
	get_tree().call_group("players", "queue_free")
	get_tree().call_group("lasers", "queue_free")
	playing = false
	$asteroid_timer.stop()
	$basic_enemy_timer.stop()
	$ship_enemy_timer.stop()
	$big_enemy_timer.stop()
	$snake_enemy_timer.stop()


func _on_basic_enemy_timer_timeout():
	randomize()
	$basic_enemy_timer.wait_time = randi_range(8, 15)
	var enemy = basic_enemy_scene.instantiate()
	add_child(enemy)
	enemy.target(player)
	var pos = player.position - $startPosition.position + Vector2((randf_range(-get_viewport().size.x/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.x, 1.5*get_viewport().size.x)), (randf_range(-get_viewport().size.y/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.y, 1.5*get_viewport().size.y)))
	enemy.position = pos


func _on_ship_enemy_timer_timeout():
	randomize()
	$ship_enemy_timer.wait_time = randi_range(6, 12)
	var enemy = spawn_enemy_scene.instantiate()
	add_child(enemy)
	enemy.target(player)
	var pos = player.position - $startPosition.position + Vector2((randf_range(-get_viewport().size.x/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.x, 1.5*get_viewport().size.x)), (randf_range(-get_viewport().size.y/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.y, 1.5*get_viewport().size.y)))
	enemy.position = pos


func _on_big_enemy_timer_timeout():
	randomize()
	$big_enemy_timer.wait_time = randi_range(6, 12)
	var enemy = big_ship_enemy_scene.instantiate()
	add_child(enemy)
	enemy.target(player)
	var pos = player.position - $startPosition.position + Vector2((randf_range(-get_viewport().size.x/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.x, 1.5*get_viewport().size.x)), (randf_range(-get_viewport().size.y/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.y, 1.5*get_viewport().size.y)))
	enemy.position = pos


func _on_snake_enemy_timer_timeout():
	randomize()
	$snake_enemy_timer.wait_time = randi_range(10, 16)
	var enemy = snake_enemy_scene.instantiate()
	add_child(enemy)
	enemy.target(player)
	var pos = player.position - $startPosition.position + Vector2((randf_range(-get_viewport().size.x/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.x, 1.5*get_viewport().size.x)), (randf_range(-get_viewport().size.y/2, 0) if (randi_range(0, 1) == 0) else randf_range(get_viewport().size.y, 1.5*get_viewport().size.y)))
	enemy.position = pos
