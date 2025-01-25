extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const speed = 300
	var velocity = 0
	if Input.is_action_pressed("move_right"):
		velocity = 1
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity = -1
		$AnimatedSprite2D.flip_h = true
	if velocity == 0:
		$AnimatedSprite2D.animation = "idle"
	else:
		$AnimatedSprite2D.animation = "walk"
		position.x += velocity * delta * speed
	pass
