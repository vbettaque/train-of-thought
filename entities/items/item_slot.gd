@tool

class_name ItemSlot
extends Control

@export var color: Color = Color(Color.DARK_GRAY, 0.5)
@export_range(0, 64, 1, "suffix:px") var large_margin: float = 8

var enlarged: bool = false:
	set(new):
		enlarged = new
		queue_redraw()

@onready var slot_area: Area2D = $SlotArea
@onready var collision_shape_2d: CollisionShape2D = $SlotArea/CollisionShape2D
var slot_shape: RectangleShape2D

@export var item: Item:
	set(new_item):
		if item: remove_item()
		item = new_item
		if item: insert_item(item)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot_shape = collision_shape_2d.shape
	
	resized.connect(_on_resize)
	
	slot_shape.changed.connect(queue_redraw)
	slot_area.mouse_entered.connect(_on_mouse_entered)
	slot_area.mouse_exited.connect(_on_mouse_exited)
	slot_area.body_entered.connect(_on_body_entered)
	slot_area.body_exited.connect(_on_body_exit)
	slot_area.input_event.connect(_on_input_event)
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_resize() -> void:
	collision_shape_2d.position = size / 2
	slot_shape.size = size
	
func _on_mouse_entered() -> void:
	enlarged = true
	
func _on_mouse_exited() -> void:
	enlarged = false

func _on_input_event(viewport: Node, event:InputEvent, shape_idx:int) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		if mouse_event.button_index != MOUSE_BUTTON_LEFT: return
		if mouse_event.pressed and item:
			item = null
	
func _draw() -> void:
	var margin: float = large_margin if enlarged else 0.0
	var margin_vector = Vector2(margin, margin)
	var rect_size = self.size + 2 * margin_vector
	var rect_pos = - margin_vector
	var rect := Rect2(rect_pos, rect_size)
	draw_rect(rect, color)
 
func _on_body_entered(body: Node2D):
	if body is not Item: return
	var item := body as Item
	item.released.connect(_on_item_released)

func _on_body_exit(body: Node2D):
	if body is not Item: return
	var item := body as Item
	item.released.disconnect(_on_item_released)
	
func _on_item_released(item: Item):
	self.item = item

func insert_item(item: Item):
	item.reparent(self)
	item.position = size / 2
	item.set_physics_process(false)
	item.freeze = true
	
func remove_item():
	item.reparent(get_tree().root)
	item.set_physics_process(true)
	item.freeze = false
	item.grab()
