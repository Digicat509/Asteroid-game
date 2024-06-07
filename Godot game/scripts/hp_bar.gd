extends ProgressBar

var sb

# Called when the node enters the scene tree for the first time.
func _ready():
	sb = StyleBoxFlat.new()
	sb.set_corner_radius_all(5)
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("00f300")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ratio = value/max_value
	setColor(Color(1.0 if ratio<0.5 else (2 - 2*ratio),1.0 if ratio>0.5 else (2*ratio),0,1))
	


func setColor(x):
	sb.bg_color = x
