class_name Crosshair
extends Control

func _ready():
	# Center crosshair and trigger _draw()
	custom_minimum_size = get_viewport_rect().size
	update_minimum_size()
	

func _draw():
	var center: Vector2     = custom_minimum_size / 2
	var crosshair_size: int = 50  # Size of crosshair arms in PIXELS

	# Vertical line
	draw_line(center - Vector2(0, crosshair_size), center + Vector2(0, crosshair_size), Color.WHITE, 2)
	# Horizontal line
	draw_line(center - Vector2(crosshair_size, 0), center + Vector2(crosshair_size, 0), Color.WHITE, 2)
