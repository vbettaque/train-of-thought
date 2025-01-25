class_name ItemSlot
extends Area2D

@export var color: Color = Color(Color.DARK_GRAY, 0.5)
@export_range(0, 64, 1, "suffix:px") var large_margin: float = 16

var enlarged: bool = false:
	set(new):
		enlarged = new or item
		queue_redraw()

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var slot_shape: RectangleShape2D

var item: Item
var item_parent: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exit)
	self.input_event.connect(_on_input_event)
	slot_shape = collision_shape_2d.shape
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_input_event(viewport: Node, event:InputEvent, shape_idx:int) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		if mouse_event.button_index != MOUSE_BUTTON_LEFT: return
		if mouse_event.pressed and item:
			remove_item()
	
func _draw() -> void:
	var margin: float = large_margin if enlarged else 0.0
		
	var size = slot_shape.size + Vector2(margin, margin)
	var rect := Rect2(-size/2, size)
	draw_rect(rect, color)

func _on_body_entered(body: Node2D):
	if body is not Item: return
	var item := body as Item
	item.released.connect(_on_item_released)
	enlarged = true

func _on_body_exit(body: Node2D):
	if body is not Item: return
	var item := body as Item
	item.released.disconnect(_on_item_released)
	enlarged = false
	
func _on_item_released(item: Item):
	insert_item(item)

func insert_item(item: Item):
	self.item = item
	item_parent = item.get_parent()
	item.reparent(self)
	item.position = Vector2.ZERO
	item.set_physics_process(false)
	item.freeze = true
	
func remove_item():
	item.reparent(item_parent)
	item.set_physics_process(true)
	item.freeze = false
	item.grab()
	self.item = null
	item_parent = null
