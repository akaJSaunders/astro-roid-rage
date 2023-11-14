extends RigidBody2DWrap

const STARTING_FORCE = 100

signal was_shot

@export var debris_scene : PackedScene
@export var debris_amount = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(Utility.randomUnitVector2() * randf_range(STARTING_FORCE/2.0, STARTING_FORCE * 2))

func _on_was_shot():
	if debris_scene:
		for i in debris_amount:
			var debris = debris_scene.instantiate()
			debris.global_position = global_position
			get_parent().call_deferred("add_child", debris)

	queue_free()
