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
	
	# Vessel is in static region
	if tpos.x > speedup_zone_top_left.y and tpos.x < speedup_zone_bottom_right.y and tpos.z > -speedup_zone_top_left.x and tpos.z < -speedup_zone_bottom_right.x:
		# Add some test message is you want
		pass
	# Vessel is out of static region
	else:
		# Vessel is moving
		if !target.velocity.is_equal_approx(Vector3.ZERO):
			var temp_direction = Vector2((tpos.x - cpos.x),(tpos.z - cpos.z))
			var temp_unit_direction = temp_direction.normalized()
			global_position.x = move_toward(cpos.x, tpos.x, abs(delta * push_ratio * target.speed * temp_unit_direction.x))
			global_position.z = move_toward(cpos.z, tpos.z, abs(delta * push_ratio * temp_unit_direction.y))
	
		
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
