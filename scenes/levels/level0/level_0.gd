extends Node2D

var can_pass = false;


@onready var win_area: Area2D = $WinArea
@onready var win_message: RichTextLabel = $Player/Camera2D/CanvasLayer/CenterContainer/WinMessage


@onready var conductor: NPC = $NPCs/Conductor
@onready var player: Player = $Player

@onready var no_bubble: Polygon2D = $NPCs/Conductor/NoBubble
@onready var no_bubble_slot_control: ItemSlotControl = $NPCs/Conductor/NoBubble/MarginContainer/HFlowContainer/ItemSlotCointrol

@onready var pass_bubble: Polygon2D = $NPCs/Conductor/PassBubble

#@onready var ticket_item: Item = $NPCs/Cold/Bubble/MarginContainer/HFlowContainer/ItemSlotControl/TicketItem



func _ready() -> void:
	conductor.remove_child.call_deferred(pass_bubble)
	win_area.body_entered.connect(_on_win_area_entered)

func _process(delta: float) -> void:
	win_message
	if player.item_slot.item and no_bubble_slot_control.item_slot.item != null:
		can_pass = true
		conductor.dialog_bubble = pass_bubble
		if conductor.get_children().has(no_bubble):
			conductor.remove_child(no_bubble)
	else:
		can_pass = false
		conductor.dialog_bubble = no_bubble
		if conductor.get_children().has(pass_bubble):
			conductor.remove_child(pass_bubble)

func _on_win_area_entered(body: Node2D):
	if body == player and can_pass:
		win_message.visible = true
		player.set_process(false)
		player.set_physics_process(false)
		
