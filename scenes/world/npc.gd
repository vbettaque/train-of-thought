extends Area2D

@onready var dialog_bubble: Polygon2D = $DialogBubble


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_bubble.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node2D):
	if body is Player:
		dialog_bubble.visible = true
	

func _on_body_exited(body: Node2D):
	if body is Player:
		dialog_bubble.visible = false
