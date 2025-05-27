extends Node2D

var points_mouse: Array[Vector2] = []
var draw_size: float = 20.0
var default_color: Color = Color.ALICE_BLUE

var lines_points : Array[Vector2] = []

var erase_radius = 20.0

var pre_pos : Vector2
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if pre_pos.distance_to(get_global_mouse_position()) > draw_size:
			points_mouse.append(get_global_mouse_position())
			pre_pos = get_global_mouse_position()
		queue_redraw()
	elif Input.is_action_just_pressed("ui_down"):
		points_mouse.clear()
		queue_redraw()
	elif Input.is_action_pressed("ui_up"):
		erase_points(get_global_mouse_position())
		queue_redraw()
	

func _draw() -> void:
	if points_mouse.is_empty():
		return

	# Draw circles
	for point in points_mouse:
		draw_circle(point, draw_size, default_color)

	# Draw lines between distant points
	for i in range(points_mouse.size() - 1):
		var from = points_mouse[i]
		var to = points_mouse[i + 1]
		var dist = from.distance_to(to)
		if dist > draw_size:
			# Shaheem FIx these 2 lines down here
			lines_points.append(from)
			lines_points.append(to)
			draw_line(from, to, default_color, draw_size * 2)

func erase_points(pos : Vector2):
	for point in points_mouse:
		if pos.distance_to(point) <= erase_radius:
			pre_pos
			points_mouse.erase(point)

func _ready() -> void:
	while true:
		await get_tree().create_timer(1).timeout
		print(points_mouse.size())
