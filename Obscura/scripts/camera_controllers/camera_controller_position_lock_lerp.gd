class_name CameraControllerPositionLockLerp
extends CameraControllerBase


@export var follow_speed:float = 45
@export var catchup_speed:float = 100
@export var leash_distance:float = 30


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
	
	# Target position and distance to target
	var target_pos: Vector3 = target.global_position
	var distance_to_target: float = global_position.distance_to(target_pos)

	# Adjust leash distance based on zoom level
	var zoom_scale: float = transform.basis.get_scale().length()
	var scaled_leash_distance: float = leash_distance * zoom_scale

	var player_moving : bool = target.velocity.length() > 0
	
	# Decide on camera speed and scale to zoom, first making follow_speed 90% of target speed
	follow_speed = target.get_real_velocity().length() * 0.9 # 90% of target speed
	var speed : float = follow_speed if player_moving else catchup_speed
	speed = speed * zoom_scale

	# Fractional max camera distance moved in a frame
	var distance = (speed * delta) / distance_to_target
	distance = clamp(distance, 0, 1)
	# Move camera
	global_position = global_position.lerp(target_pos, distance)
	
	 # Enforcing leash distance
	distance_to_target = global_position.distance_to(target_pos)
	if distance_to_target > scaled_leash_distance:
		var direction = (global_position - target_pos).normalized()
		global_position = target_pos + direction * scaled_leash_distance
	
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
