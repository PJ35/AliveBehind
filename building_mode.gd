extends Node2D

@export var building_area := Rect2(0, 0, 128, 128)
@export var parent_building : Node2D
var query_rect = RectangleShape2D.new()
var can_build = []
var has_built = false

signal build_building

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("build") && can_build.size() == 0:
		build_building.emit()
		has_built = true
		queue_redraw()

func _process(delta: float) -> void:
	if !has_built:
		parent_building.global_position = get_global_mouse_position()
		building_area.position = -building_area.size/2
		var space = get_world_2d().direct_space_state
		query_rect.extents = abs(building_area.size)/2
		var q = PhysicsShapeQueryParameters2D.new()
		q.shape = query_rect
		q.collision_mask = 10
		q.transform = Transform2D(0, get_global_mouse_position())
		can_build = space.intersect_shape(q)
		queue_redraw()

func _draw() -> void:
	if can_build.size() == 0 && !has_built:
		draw_rect(building_area, Color(0, 1, 0, .5))
	elif !has_built:
		draw_rect(building_area, Color(1, 0, 0, .5))
	else:
		draw_rect(building_area, Color.TRANSPARENT)
