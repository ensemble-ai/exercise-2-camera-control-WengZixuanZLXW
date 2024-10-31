class_name Camera_Stage5
extends CameraControllerBase

@export var push_ratio:float
@export var pushbox_top_left:Vector2
@export var pushbox_bottom_right:Vector2
@export var speedup_zone_top_left:Vector2
@export var speedup_zone_bottom_right:Vector2


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	var temp_unit_direction = Vector3((tpos.x - cpos.x), 0, (tpos.z - cpos.z)).normalized()
	var target_unit_direction = Vector3(target.velocity.x, 0, target.velocity.z).normalized()
	# Vessel is in static region
	if tpos.x > cpos.x + speedup_zone_top_left.y and tpos.x < cpos.x + speedup_zone_bottom_right.y and tpos.z > cpos.z - speedup_zone_top_left.x and tpos.z < cpos.z - speedup_zone_bottom_right.x:
		pass
	# Vessel is out of static region
	else:
		# Vessel is moving
		if !target.velocity.is_equal_approx(Vector3.ZERO):
			global_position.x = cpos.x + delta * push_ratio * target.velocity.length() * target_unit_direction.x
			global_position.z = cpos.z + delta * push_ratio * target.velocity.length() * target_unit_direction.z
		if tpos.x < global_position.x + pushbox_top_left.y + target.RADIUS or tpos.x > global_position.x + pushbox_bottom_right.y - target.RADIUS:
			global_position.x = cpos.x + delta * target.velocity.x
		if tpos.z < global_position.z - pushbox_top_left.x + target.RADIUS or tpos.z > global_position.z - pushbox_bottom_right.x - target.RADIUS:
			global_position.z = cpos.z + delta * target.velocity.z
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var speedup_left:float = speedup_zone_top_left.y
	var speedup_right:float = speedup_zone_bottom_right.y
	var speedup_top:float = -speedup_zone_top_left.x
	var speedup_bottom:float = -speedup_zone_bottom_right.x
	
	var pushbox_left:float = pushbox_top_left.y
	var pushbox_right:float = pushbox_bottom_right.y
	var pushbox_top:float = -pushbox_top_left.x
	var pushbox_bottom:float = -pushbox_bottom_right.x
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# Speedup_zone
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_top))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_top))
	# PushBox
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
