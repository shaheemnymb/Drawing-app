extends Node2D

# Constands
const DEFAULT_BRUSH_SIZE = 20.0

# Member Variables
var all_draw_points : Array[Vector2]
var current_points : Array[Vector2]

# Mouse Variables
var mouse_left_down : bool

func _unhandled_input(event: InputEvent) -> void:
	mouse_input(event)

# Our Main Function In this script
func _draw() -> void:
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func mouse_input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			# Mouse Button Down
			mouse_left_down = true
		elif event.button_index == 1 and not event.pressed:
			# Mouse Button Up
			mouse_left_down = false
	elif event is InputEventMouseMotion:
		if mouse_left_down:
			add_draw_point(get_global_mouse_position())

func add_draw_point(pos : Vector2):
	current_points.append(pos)
