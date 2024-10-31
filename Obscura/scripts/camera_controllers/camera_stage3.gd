class_name Camera_Stage3
extends CameraControllerBase


@export var cross_length:float = 5.0
@export var follow_speed_ratio:float = 0.8
@export var catchup_speed_ratio:float = 0.9
@export var leash_distance:float = 10


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	# Measure direction from camera to target
	var tpos = target.global_position
	var cpos = global_position
	var temp_unit_direction = Vector3((tpos.x - cpos.x), 0, (tpos.z - cpos.z)).normalized()
	# Follow when player is moving
	if !target.velocity.is_equal_approx(Vector3.ZERO):
		global_position.x = move_toward(cpos.x, tpos.x, abs(delta * follow_speed_ratio * target.velocity.length() * temp_unit_direction.x))
		global_position.z = move_toward(cpos.z, tpos.z, abs(delta * follow_speed_ratio * target.velocity.length() * temp_unit_direction.z))
	# Catchup when player is stoping
	elif target.velocity.is_equal_approx(Vector3.ZERO):
		global_position.x = move_toward(cpos.x, tpos.x, abs(delta * catchup_speed_ratio * target.BASE_SPEED * temp_unit_direction.x))
		global_position.z = move_toward(cpos.z, tpos.z, abs(delta * catchup_speed_ratio * target.BASE_SPEED * temp_unit_direction.z))
	
	# Measure direction from camera to target again
	tpos = target.global_position
	cpos = global_position
	# Limit the distance in LeashDistance
	temp_unit_direction = Vector3((tpos.x - cpos.x), 0, (tpos.z - cpos.z)).normalized()
	if Vector2(target.global_position.x - global_position.x, target.global_position.z - global_position.z).length() > (leash_distance):
		global_position = target.global_position - temp_unit_direction * leash_distance
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -cross_length / 2.0
	var right:float = cross_length / 2.0
	var top:float = -cross_length / 2.0
	var bottom:float = cross_length / 2.0
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0.1, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0.1, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0.1, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0.1, bottom))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
