tool
extends ParallaxBackground
class_name Visualizer_ParallaxBackground

export var camera_path : NodePath

export(float, 0.0001, 999.0) var refresh_rate : float = 0.01

# The camera must have no script or have a tool script for it to work
onready var camera = get_node(camera_path)

onready var refresh_timer = Timer.new()

#### ACCESSORS ####

func is_class(value: String): return value == "Visualizer_ParallaxBackground" or .is_class(value)
func get_class() -> String: return "Visualizer_ParallaxBackground"


#### BUILT-IN ####

func _ready() -> void:
	if !Engine.editor_hint:
		return
	
	if not camera is Camera2D && camera != null:
		push_error("The node found at the given path %s isn't a Camera2D. Make sure the camera_path leads to a Camera2D" % str(camera_path))
	else:
		add_child(refresh_timer)
		
		var __ = refresh_timer.connect("timeout", self, "_on_refresh_timer_timeout")
		
		refresh_timer.set_wait_time(refresh_rate)
		refresh_timer.start()

#### VIRTUALS ####



#### LOGIC ####


func _update_layers_position() -> void:
	if camera == null or not camera is Camera2D:
		return
	
	for child in get_children():
		if child is ParallaxLayer:
			child.position = -camera.get_global_position() * child.motion_scale + child.motion_offset



#### INPUTS ####



#### SIGNAL RESPONSES ####


func _on_refresh_timer_timeout() -> void:
	_update_layers_position()


