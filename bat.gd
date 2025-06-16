extends CharacterBody2D

@export var speed = 100
var av = Vector2.ZERO
var avoid_weight = 0.1
var target_radius = 50
#var selected = false:
	#set = set_selected
var target = null:
	set = set_target

func set_target(value):
	target = value

func delete():
	var neighbors = $Detect.get_overlapping_bodies()
	if neighbors:
		for n in neighbors:
			n.queue_free()
		queue_free()

func _physics_process(delta: float) -> void:
	delete()
	velocity = Vector2.ZERO
	if target != null:
		velocity = position.direction_to(target)
		velocity = velocity.normalized() * speed
	move_and_collide(velocity * delta)
	$AnimationPlayer.play("flying")
