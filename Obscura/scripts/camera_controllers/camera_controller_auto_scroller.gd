class_name CameraControllerAutoScroller
extends CameraControllerBase

@export var top_left := Vector2(-50 , 50)
@export var bottom_right := Vector2(50, -50)
@export var autoscroll_speed := Vector3(18, 0, 0)

# Create camera box, move camera box at scroll speed, if target is against left edge, add velocity to target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	global_position = target.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	super(delta)
	
func draw_logic() -> void:
	var delta : float = get_process_delta_time()
	global_position += autoscroll_speed * delta
	
	var tpos : Vector3 = target.global_position
	var cpos : Vector3 = global_position
	var left : float = top_left.x
	var right : float = bottom_right.x
	var top : float = bottom_right.y
	var bottom : float =  top_left.y
	
	
	#Left edge - PUSH
	var diff_bwtn_left_edge: float = (tpos.x - target.WIDTH / 2.0) - (cpos.x + left)
	if diff_bwtn_left_edge < 0:
		target.global_position.x = cpos.x + left + target.WIDTH / 2.0
	
	#Right edge - STOP
	var diff_bwtn_right_edge: float = (tpos.x + target.WIDTH / 2.0) - (cpos.x + right)
	if diff_bwtn_right_edge > 0: 
		target.global_position.x = cpos.x + right - target.WIDTH / 2.0
		
	#Top edge - STOP
	var diff_bwtn_top_edge: float = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + top)
	if diff_bwtn_top_edge < 0:
		target.global_position.z = cpos.z - top + target.HEIGHT / 2.0
		#
	#Bottom edge - STOP
	var diff_bwtn_bottom_edge: float = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + bottom)
	if diff_bwtn_bottom_edge > 0:
		target.global_position.z = cpos.z + bottom - target.HEIGHT / 2.0
		
	
	
	#Box drawing
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
