extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(round((get_parent() as Node3D).global_position))
	text += "\n"
	text += str(round((%Vessel as Vessel).global_position))
	text += "\n"
	text += str(round( 1.0 / _delta ))
	text += "\n"
	text += str(Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).limit_length(1.0))
	text += "\n"
	text += str(get_parent().dist_above_target)
	text += "\n"
	var parent = get_parent()
	#var distance_to_target: float = parent.global_position.distance_to(%Vessel)
	text += str(parent)
	
