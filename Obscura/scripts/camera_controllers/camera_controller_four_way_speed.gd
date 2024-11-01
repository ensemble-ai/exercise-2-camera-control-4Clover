class_name FourWaySpeedUp
extends CameraControllerBase

@export var push_ratio : float = 0.5
@export var pushbox_top_left : Vector2 			= Vector2(-20 , -20)
@export var pushbox_bottom_right : Vector2 		= Vector2(20 , 20)
@export var speedup_zone_top_left : Vector2 	= Vector2(-10, -10)
@export var speedup_zone_bottom_right : Vector2 = Vector2(10 , 10)

var camera_velocity : Vector3 = Vector3.ZERO
var previous_target_position : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = target.global_position
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	################################## REFERENCE VARIABLES #########################################
	
	# Camera pos x and z
	var cam_x: float = global_position.x
	var cam_z: float = global_position.z
	
	# Target x and z for use
	var target_x : float = target.global_position.x
	var target_z : float = target.global_position.z
	
	# Speed up zone boundaries - INNER (centered on the camera)
	var speed_left_bound : float = cam_x + speedup_zone_top_left.x # negative
	var speed_right_bound : float = cam_x + speedup_zone_bottom_right.x
	var speed_top_bound : float = cam_z + speedup_zone_top_left.y # negative
	var speed_bottom_bound : float = cam_z + speedup_zone_bottom_right.y 

	# Push box zone boundaries - OUTER (centered on the camera)
	var push_left_bound : float = cam_x + pushbox_top_left.x # negative
	var push_right_bound : float = cam_x + pushbox_bottom_right.x
	var push_top_bound : float = cam_z + pushbox_top_left.y # negative
	var push_bottom_bound : float = cam_z + pushbox_bottom_right.y
	
	# Calculates the change in position
	var delta_position = target.global_position - previous_target_position

	# Movement direction along each axis
	var moving_right = delta_position.x > 0
	var moving_left = delta_position.x < 0
	var moving_up = delta_position.z > 0
	var moving_down = delta_position.z < 0  
	
	############################ FLAGS FOR PRESENCE IN GIVEN LOCATION ##############################
	
	# Flags for targets's position relative to inner and outer zones
	var inside_inner_x = target_x > speed_left_bound and target_x < speed_right_bound
	var inside_inner_z = target_z > speed_top_bound and target_z < speed_bottom_bound
	var is_inside_inner_zone = inside_inner_x and inside_inner_z

	var inside_outer_x = target_x > push_left_bound and target_x < push_right_bound
	var inside_outer_z = target_z > push_top_bound and target_z < push_bottom_bound
	var is_inside_outer_zone = inside_outer_x and inside_outer_z

	var is_touching_outer_x = not inside_outer_x
	var is_touching_outer_z = not inside_outer_z
	
	# Flags for camera movement conditions
	var is_between_zones = is_inside_outer_zone and not is_inside_inner_zone
	var is_touching_one_side = 	((is_touching_outer_x and inside_outer_z) or 
								(inside_outer_x and is_touching_outer_z))
	var is_touching_corner = is_touching_outer_x and is_touching_outer_z
	
	# Flags for moving towards the center from an outer zone
	var moving_towards_center_x = ((target_x < speed_left_bound and moving_right) or
								   (target_x > speed_right_bound and moving_left))

	var moving_towards_center_z = ((target_z < speed_top_bound and moving_up) or
								   (target_z > speed_bottom_bound and moving_down))

	
	############################### MOVEMENT BASED ON LOCATION #####################################
	
	# Camera velocity holder
	camera_velocity = Vector3.ZERO 
	
	if is_inside_inner_zone:
		# Inside center of the speed box
		camera_velocity = Vector3.ZERO
	elif is_between_zones:
		if moving_towards_center_x:
			camera_velocity.x = 0
		if moving_towards_center_z:
			camera_velocity.z = 0
		# Anywhere between inner and outer boxes
		camera_velocity = target.velocity * push_ratio
	elif is_touching_one_side:
		if moving_towards_center_x:
			camera_velocity.x = 0
		if moving_towards_center_z:
			camera_velocity.z = 0
		# Touching one outer box
		camera_velocity = Vector3(
			target.velocity.x if is_touching_outer_x else target.velocity.x * push_ratio,
			0,
			target.velocity.z if is_touching_outer_z else target.velocity.z * push_ratio
		)
	elif is_touching_corner:
		# Touching both outer boxes (corner)
		camera_velocity = target.velocity
	else:
		# SHOULD NEVER BE REACHED
		camera_velocity = Vector3.ZERO
		push_error("INCORRECT LOCATION FLAGS")
	
	if moving_towards_center_x:
		camera_velocity.x = 0
	if moving_towards_center_z:
		camera_velocity.z = 0
	
	
	################################################################################################
	
	# Update camera/previous position
	global_position += camera_velocity * delta
	previous_target_position = target.global_position
	super(delta)
	
	


func draw_logic() -> void:
	# Speed up zone boundaries - INNER (centered on the camera)
	var speed_left_bound : float = speedup_zone_top_left.x # negative
	var speed_right_bound : float = speedup_zone_bottom_right.x
	var speed_top_bound : float = speedup_zone_top_left.y # negative
	var speed_bottom_bound : float = speedup_zone_bottom_right.y 

	# Push box zone boundaries - OUTER (centered on the camera)
	var push_left_bound : float = pushbox_top_left.x # negative
	var push_right_bound : float = pushbox_bottom_right.x
	var push_top_bound : float = pushbox_top_left.y # negative
	var push_bottom_bound : float = pushbox_bottom_right.y
	
	# SPEED UP BOX
	var mesh_instance_speedup := MeshInstance3D.new()
	var immediate_mesh_speedup := ImmediateMesh.new()
	var material_speedup := ORMMaterial3D.new()
	
	mesh_instance_speedup.mesh = immediate_mesh_speedup
	mesh_instance_speedup.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Speedup zone boundaries - INNER (same as in logic)
	var speed_left:float = speed_left_bound
	var speed_right:float = speed_right_bound
	var speed_top:float = speed_top_bound
	var speed_bottom:float = speed_bottom_bound
	
	immediate_mesh_speedup.surface_begin(Mesh.PRIMITIVE_LINES, material_speedup)
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_right, 0, speed_top))
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_right, 0, speed_bottom))
	
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_right, 0, speed_bottom))
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_left, 0, speed_bottom))
	
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_left, 0, speed_bottom))
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_left, 0, speed_top))
	
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_left, 0, speed_top))
	immediate_mesh_speedup.surface_add_vertex(Vector3(speed_right, 0, speed_top))
	immediate_mesh_speedup.surface_end()

	material_speedup.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_speedup.albedo_color = Color.BLACK
	
	add_child(mesh_instance_speedup)
	mesh_instance_speedup.global_transform = Transform3D.IDENTITY
	mesh_instance_speedup.global_position = Vector3(global_position.x, 
													target.global_position.y, 
													global_position.z)
	
	# Free the mesh after one frame
	await get_tree().process_frame
	mesh_instance_speedup.queue_free()
	
	# PUSH BOX
	var mesh_instance_push := MeshInstance3D.new()
	var immediate_mesh_push := ImmediateMesh.new()
	var material_push := ORMMaterial3D.new()
	
	mesh_instance_push.mesh = immediate_mesh_push
	mesh_instance_push.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Push box boundaries - OUTER (same as in logic)
	var left:float = push_left_bound
	var right:float = push_right_bound
	var top:float = push_top_bound
	var bottom:float = push_bottom_bound
	
	immediate_mesh_push.surface_begin(Mesh.PRIMITIVE_LINES, material_push)
	immediate_mesh_push.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh_push.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh_push.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh_push.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh_push.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh_push.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh_push.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh_push.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh_push.surface_end()
	
	material_push.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_push.albedo_color = Color.BLACK
	
	add_child(mesh_instance_push)
	mesh_instance_push.global_transform = Transform3D.IDENTITY
	mesh_instance_push.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Free the mesh after one frame
	await get_tree().process_frame
	mesh_instance_push.queue_free()
