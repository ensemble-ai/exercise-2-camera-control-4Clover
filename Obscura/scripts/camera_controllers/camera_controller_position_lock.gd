class_name CameraControllerPositionLock
extends CameraControllerBase

@export var box_width:float = 10.0
@export var box_height:float = 10.0
@export var push_box : PushBox
#Base exports
#@export var target:Vessel
#@export var dist_above_target:float = 10.0
#@export var zoom_speed:float = 10.0
#@export var min_zoom:float = 5.0
#@export var max_zoom:float = 100.0
#@export var draw_camera_logic:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	
	global_position = target.position
	
	super(delta)
		
func draw_logic() -> void:
	push_box.draw_logic()
