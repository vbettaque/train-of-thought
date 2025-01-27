class_name Player
extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
@export var bobbing_strength: float = 8
@export var bobbing_speed: float = 5
var bobbing_offset: float

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var item_slot: ItemSlot = $ItemSlot

func _ready() -> void:
	bobbing_offset = 2 * randf() * PI

func _process(delta: float) -> void:
	sprite.position.y = bobbing_strength \
		* sin(bobbing_speed * (Time.get_ticks_msec() / 1000.) + bobbing_offset)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		#sprite.animation = "walk"
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	else:
		#sprite.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
