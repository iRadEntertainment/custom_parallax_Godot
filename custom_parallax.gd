#=========================#
#   custom_parallax.gd    #
#=========================#

extends Node2D

export (NodePath) var cam_path
var cam
export (float, 0, 5) var x_scroll = 1
export (float, 0, 5) var y_scroll = 1
export (bool) var y_equal_x = false


#onready var cam = owner.find_node("cam")


var initial_children_positions = []

func _ready():
	set_process(false)
	# get all initial positions
	for child in get_children():
		initial_children_positions.append(child.global_position)
	
#	print("custom parallax: %s"%get_viewport().get_canvas_transform())
	cam = get_node(cam_path)
	if cam:
		set_process(true)

func _process(_d):
	var cam_pos = cam.get_camera_screen_center()
	for i in range(get_children().size()):
		var child = get_children()[i]
		var g_pos = initial_children_positions[i]
		if y_equal_x:
			child.global_position = g_pos + (cam_pos - g_pos) * (1 - x_scroll)
		else:
			child.global_position.x = g_pos.x + (cam_pos.x - g_pos.x) * (1 - x_scroll)
			child.global_position.y = g_pos.y + (cam_pos.y - g_pos.y) * (1 - y_scroll)

