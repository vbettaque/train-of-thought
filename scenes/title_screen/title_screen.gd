extends Control

@export_file("*.tscn") var next_scene_path: String

@onready var play_button: Button = $MarginContainer/CenterContainer/VBoxContainer/PlayButton
@onready var title: TextureRect = $MarginContainer/CenterContainer/VBoxContainer/Title


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	if next_scene_path:
		get_tree().change_scene_to_file(next_scene_path)
