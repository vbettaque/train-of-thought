class_name Item
extends RigidBody2D

var in_slot := false
var is_dragged := false
var mouse_offset := Vector2.ZERO

signal grabbed(Item)
signal released(Item)

@onready var selection_area: Area2D = $SelectionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selection_area.input_event.connect(_on_input_event)
	#selection_area.mouse_exited.connect(_on_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if selected and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#release()


func _physics_process(delta: float) -> void:
	var dir := Vector2.ZERO
	if is_dragged:
		dir = direction_to_mouse()
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			release()
	move_and_collide(dir)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_MOUSE_EXIT:
			is_dragged = false

#func _on_mouse_exited() -> void:
	#selected = false
	#linear_velocity = Input.get_last_mouse_velocity()

func _on_input_event(viewport: Node, event:InputEvent, shape_idx:int) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		if mouse_event.button_index != MOUSE_BUTTON_LEFT: return
		if mouse_event.pressed:
			grab()
		else:
			release()

func grab() -> void:
	grabbed.emit(self)
	is_dragged = true
	rotation = 0
	angular_velocity = 0
	linear_velocity = Vector2.ZERO
	mouse_offset = position - get_global_mouse_position()

func release() -> void:
	released.emit(self)
	is_dragged = false
	linear_velocity = Input.get_last_mouse_velocity()

func direction_to_mouse():
	return get_global_mouse_position() + mouse_offset - position
