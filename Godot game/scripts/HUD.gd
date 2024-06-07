extends CanvasLayer

signal game_start
signal game_over
@export var regen_time = 1
var playing = false

func _ready():
	layer = 1
	$HPBar.visible = false
	$SheildBar.visible = false
	$score.visible = false
	$Label2.visible = false
	$upgrade_screen.visible = false

func start_game():
	$HPBar.visible = true
	$SheildBar.visible = true
	$score.visible = true
	$Label2.visible = true
	$HPBar.max_value = 100
	$HPBar.value = 100
	$Button.visible = false
	$Label.visible = false
	playing = true

func _on_player_hit(value):
	if $SheildBar.value > 0:
		$SheildBar.value -= value;
	else:
		$HPBar.value -= value

func _input(event):
	if playing and event.is_action_pressed("upgrade_screen"):
		$upgrade_screen.visible = not $upgrade_screen.visible

func _process(delta):
	if $SheildBar.value < $SheildBar.max_value and $RegenTimer.is_stopped():
		$RegenTimer.start(regen_time)
	elif $SheildBar.value == $SheildBar.max_value:
			$RegenTimer.stop()
	$score.text = str(VariableStorage.get_crystals())
	if $HPBar.value <= 0:
		emit_signal("game_over")
		$HPBar.visible = false
		$SheildBar.visible = false
		$score.visible = false
		$upgrade_screen.visible = false
		$Label2.visible = false
		$Button.visible = true
		$Label.visible = true

func _on_Button_pressed():
	emit_signal("game_start")

func _on_regen_timer_timeout():
	$SheildBar.value += 10
