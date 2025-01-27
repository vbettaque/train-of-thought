class_name NPC
extends Area2D

@export var dialog_bubble: Polygon2D
@onready var sprite: AnimatedSprite2D = $Sprite

@export var bobbing_strength: float = 8
@export var bobbing_speed: float = 5
@export var bobbing_offset: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bobbing_offset = 2 * randf() * PI
	if dialog_bubble:
		remove_child.call_deferred(dialog_bubble)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	
func _process(delta: float) -> void:
	sprite.position.y = bobbing_strength \
		* sin(bobbing_speed * (Time.get_ticks_msec() / 1000.) + bobbing_offset)
	

func _on_body_entered(body: Node2D):
	if body is Player and dialog_bubble:
		add_child.call_deferred(dialog_bubble)
	

func _on_body_exited(body: Node2D):
	if body is Player and dialog_bubble:
		remove_child.call_deferred(dialog_bubble)
