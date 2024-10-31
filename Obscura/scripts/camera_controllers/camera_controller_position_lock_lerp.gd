class_name CameraControllerPositionLockLerp
extends CameraControllerBase


@export var follow_speed:float = 30
@export var catchup_speed:float = 5
@export var leash_distance:float = 50
#Base exports
#@export var target:Vessel
#@export var dist_above_target:float = 10.0
#@export var zoom_speed:float = 10.0
#@export var min_zoom:float = 5.0
#@export var max_zoom:float = 100.0
#@export var draw_camera_logic:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = target.global_position
	max_zoom = 85


# camera does not move until passing leash distance, 
# then it follows player at its follow speed, and if player stops moving, 
# will catchup using the catchup speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_speed = target.get_real_velocity().length() * 0.75 # 75% of target speed
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var target_pos: Vector3       = target.global_position
	var distance_to_target: float = global_position.distance_to(target_pos)
	
	# Adjust follow and leash distances based on zoom level
	var zoom_scale: float          = transform.basis.get_scale().length()  # Zoom scale factor
	var scaled_follow_speed: float  = follow_speed * zoom_scale
	var scaled_catchup_speed: float  = catchup_speed * zoom_scale
	var scaled_leash_distance: float = leash_distance * zoom_scale

	if distance_to_target > scaled_leash_distance:
		# global_position += target.velocity
		global_position = global_position.lerp(target_pos, scaled_follow_speed * delta)
	else:
		global_position = global_position.lerp(target_pos, scaled_catchup_speed * delta)
	
	super(delta)


func draw_logic() -> void:
	var crosshair_instance := MeshInstance3D.new()
	var crosshair_mesh := ImmediateMesh.new()
	var crosshair_material := ORMMaterial3D.new()
	var crosshair_size: float = 5  # Adjust size as needed
	
	crosshair_instance.mesh = crosshair_mesh
	crosshair_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Draw crosshair lines
	crosshair_mesh.surface_begin(Mesh.PRIMITIVE_LINES, crosshair_material)
	crosshair_mesh.surface_add_vertex(Vector3(-crosshair_size, 0, 0))
	crosshair_mesh.surface_add_vertex(Vector3(crosshair_size, 0, 0))

	crosshair_mesh.surface_add_vertex(Vector3(0, 0, -crosshair_size))
	crosshair_mesh.surface_add_vertex(Vector3(0, 0, crosshair_size))
	crosshair_mesh.surface_end()
	
	crosshair_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	crosshair_material.albedo_color = Color.DARK_RED # Red
	
	add_child(crosshair_instance)
	crosshair_instance.global_transform = Transform3D.IDENTITY
	crosshair_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	crosshair_instance.queue_free()
