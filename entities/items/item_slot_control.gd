class_name ItemSlotControl
extends Control

@onready var item_slot: ItemSlot = $ItemSlot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resized.connect(_on_resize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resize() -> void:
	pass
