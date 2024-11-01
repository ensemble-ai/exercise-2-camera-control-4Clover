class_name CameraControllerLerpTargetFocus
extends CameraControllerBase


@export var lead_speed : float = 30 # set to below target right now but updated below to 1% more
@export var catchup_speed : float = 5
@export var catchup_delay_duration : float = 0.1
@export var leash_distance : float = 10

var idle_time : float = 0.0
var current_direction : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = target.global_position
	max_zoom = 85
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	# Variables for easier reference and adjusting lead_speed to be greater than target speed
	var target_velocity : Vector3 	= target.velocity
	var is_moving : bool 			= target_velocity.length() > 0
	lead_speed 						= target.velocity.length() * 1.01 # 1% more of target speed
	
	# ZOOM SCALING - Unneeded due to positions being relative in calculations #
	#var zoom_scale: float          		= transform.basis.get_scale().length()
	#var scaled_lead_speed: float  		= lead_speed * zoom_scale
	#var scaled_catchup_speed: float  	= catchup_speed * zoom_scale
	#var scaled_leash_distance: float 	= leash_distance * zoom_scale
	#lead_speed 							= scaled_lead_speed
	#catchup_speed 						= scaled_catchup_speed
	#leash_distance 						= scaled_leash_distance
	
	var desired_direction : Vector3 = target_velocity.normalized()
	
	# Determines if movement will be towards the next place or towards ZERO = vessel
	if is_moving:
		idle_time = 0.0
		desired_direction = target_velocity.normalized()
	else:
		desired_direction = Vector3.ZERO
		idle_time += delta
	
	# Old version would move target to camera position, it felt better visually 
	# Can add it needed
	
	# Smoothing factor and a lerp to apply smooth
	var smoothing_factor : float = 0.1  
	current_direction = current_direction.lerp(desired_direction, smoothing_factor)
	
	# Calculate the position the camera needs to move to
	var target_offset : Vector3 = current_direction * leash_distance
	var camera_new_position : Vector3 = target.global_position + target_offset
	
	# Conditionals for whether the camera is moving around or back onto player
	if is_moving or idle_time < catchup_delay_duration:
		# Move towards the target position at lead_speed
		global_position = global_position.lerp(
			camera_new_position, clamp(lead_speed * delta, 0, 1))
	else:
		# After delay, move towards the player's position at catchup_speed
		global_position = global_position.lerp(
			target.global_position, clamp(catchup_speed * delta, 0, 1))
	
	
	super(delta)


# Draw crosshair -- based on PushBox code
func draw_logic() -> void:
	var crosshair_instance 		:= MeshInstance3D.new()
	var crosshair_mesh 			:= ImmediateMesh.new()
	var crosshair_material 		:= ORMMaterial3D.new()
	var crosshair_size: float 	 = 5 # Length of each axis
	
	crosshair_instance.mesh = crosshair_mesh
	crosshair_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Draw crosshair lines
	crosshair_mesh.surface_begin(Mesh.PRIMITIVE_LINES, crosshair_material)
	crosshair_mesh.surface_add_vertex(Vector3(-crosshair_size/2, 0, 0))
	crosshair_mesh.surface_add_vertex(Vector3(crosshair_size/2, 0, 0))

	crosshair_mesh.surface_add_vertex(Vector3(0, 0, -crosshair_size/2))
	crosshair_mesh.surface_add_vertex(Vector3(0, 0, crosshair_size/2))
	crosshair_mesh.surface_end()
	
	crosshair_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	crosshair_material.albedo_color = Color.DARK_RED # Red
	
	add_child(crosshair_instance)
	crosshair_instance.global_transform = Transform3D.IDENTITY
	crosshair_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	crosshair_instance.queue_free()
