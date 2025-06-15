extends Sprite2D

@export var peasant_scene_path = "res://peasant.tscn"
var loaded_peasant : PackedScene
var is_building = true
@onready var building_mode := $BuildingMode
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var spawn_timer = $SpawnTimer

func _ready() -> void:
	loaded_peasant = load(peasant_scene_path)
	building_mode.build_building.connect(_set_building_mode)

func _process(delta: float) -> void:
	progress_bar.value = progress_bar.max_value - spawn_timer.time_left

func _on_spawn_timer_timeout() -> void:
	if !is_building:
		var new_peasant = loaded_peasant.instantiate()
		get_tree().root.add_child(new_peasant)
		new_peasant.global_position = $SpawnPosition.global_position

func _set_building_mode():
	is_building = false
	$StaticBody2D/CollisionShape2D.disabled = false
	$StaticBody2D/CollisionShape2D2.disabled = false
	spawn_timer.start()
	progress_bar.max_value = spawn_timer.time_left
	animation_player.play("building")
