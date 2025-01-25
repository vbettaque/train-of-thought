extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const speed = 300
	if Input.is_action_pressed("move_right"):
		$Playersprite.flip_h = false
		position.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		$Playersprite.flip_h = true
		position.x -= speed * delta
	pass
