extends Area2D

const SPEED = 400

func _physics_process(delta):
	translate( Vector2.UP.rotated(rotation) * SPEED * delta)


func _on_body_entered(body):
	if body.was_shot:
		body.was_shot.emit()
		queue_free()
