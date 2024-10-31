class_name Camera_Stage2
extends CameraControllerBase


@export var top_left:Vector2
@export var bottom_right:Vector2
@export var autoscroll_speed:Vector3


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return	
		
	if draw_camera_logic:
		draw_logic()
		
	# Move camera
	global_position += delta * autoscroll_speed	
	var tpos = target.global_position
	var cpos = global_position
	
	# Push vessel into box
	target.global_position.x = clamp(
		tpos.x, 
		cpos.x + top_left.y + target.RADIUS, 
		cpos.x + bottom_right.y - target.RADIUS
	)
	target.global_position.z = clamp(
		tpos.z, 
		cpos.z - top_left.x + target.RADIUS, 
		cpos.z - bottom_right.x - target.RADIUS
	)	
	

		
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = top_left.y
	var right:float = bottom_right.y
	var top:float = -top_left.x
	var bottom:float = -bottom_right.x
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# top line
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
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
