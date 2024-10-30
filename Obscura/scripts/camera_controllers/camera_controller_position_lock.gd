class_name CameraControllerPositionLock
extends CameraControllerBase

@export var box_width:float = 10.0
@export var box_height:float = 10.0

#Base exports
#@export var target:Vessel
#@export var dist_above_target:float = 10.0
#@export var zoom_speed:float = 10.0
#@export var min_zoom:float = 5.0
#@export var max_zoom:float = 100.0
#@export var draw_camera_logic:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = false
	global_position = target.position
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		$CanvasLayer.visible = false
		print("Not drawing logic")
		return
	
	if draw_camera_logic:
		draw_logic()
	else:
		$CanvasLayer.visible = false
	
	global_position = target.position
	super(delta)
	
	
func draw_logic() -> void:
	print("Drawing Logic State: " + str(draw_camera_logic))
	$CanvasLayer.visible = true
