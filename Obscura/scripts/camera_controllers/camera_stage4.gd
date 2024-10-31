class_name Camera_Stage4
extends CameraControllerBase

@export var cross_length:float = 5.0
@export var lead_speed_ratio:float
@export var catchup_delay_duration:float
@export var catchup_speed:float
@export var leash_distance:float

var _is_catching = false


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
	# Measure direction from camera to target
	var temp_unit_direction = Vector3((tpos.x - cpos.x), 0, (tpos.z - cpos.z)).normalized()
	# Measure input direction, and unit move direction
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).limit_length(1.0)
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Camera lead move when player move
	if !(direction == Vector3.ZERO):
		_is_catching = false
		global_position.x += delta * direction.x * lead_speed_ratio * target.velocity.length()
		global_position.z += delta * direction.z * lead_speed_ratio * target.velocity.length()
	# Camera catch vessel when player stop
	elif (direction == Vector3.ZERO):
		if !_is_catching:
			await get_tree().create_timer(catchup_delay_duration).timeout
			_is_catching = true
		else:
			global_position.x = move_toward(cpos.x, tpos.x, abs(delta * catchup_speed * temp_unit_direction.x))
			global_position.z = move_toward(cpos.z, tpos.z, abs(delta * catchup_speed * temp_unit_direction.z))
			
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
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
