extends Sprite2D

@export var bat_scene_path = "res://bat.tscn"
var loaded_bat : PackedScene
@onready var spawn_timer = $SpawnTimer

func _ready() -> void:
	loaded_bat = load(bat_scene_path)

func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var new_bat = loaded_bat.instantiate()
	get_tree().root.add_child(new_bat)
	new_bat.global_position = $SpawnPosition.global_position
