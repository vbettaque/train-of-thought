extends Area2D

var held = false

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		held = false
	if held and event is InputEventMouseMotion:
		position += event.relative

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		held = true
