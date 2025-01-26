extends Node

const MUSIC_FILE: String = "res://assets/music/music.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var music: PackedScene = preload(MUSIC_FILE)
	if music and music.can_instantiate():
		add_child(music.instantiate())
