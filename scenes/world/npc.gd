extends Area2D


@onready var dialog_bubble: Polygon2D = $DialogBubble


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if has_overlapping_bodies():
		dialog_bubble.visible = true
	else:
		dialog_bubble.visible = false
