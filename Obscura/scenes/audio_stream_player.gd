extends AudioStreamPlayer

@onready var bus_idx = AudioServer.get_bus_index("Music")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_mute(bus_idx, true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
