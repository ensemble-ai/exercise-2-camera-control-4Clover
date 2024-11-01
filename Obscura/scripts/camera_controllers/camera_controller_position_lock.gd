class_name CameraControllerPositionLock
extends CameraControllerBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = target.global_position
	draw_camera_logic = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	global_position = target.global_position
	super(delta)
	
	
func draw_logic() -> void:
	var crosshair_instance := MeshInstance3D.new()
	var crosshair_mesh := ImmediateMesh.new()
	var crosshair_material := ORMMaterial3D.new()
	var crosshair_size: float = 5 # Length of each axis 
	
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
