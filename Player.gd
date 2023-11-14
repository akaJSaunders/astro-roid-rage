extends RigidBody2DWrap

var rotation_speed = TAU
var thrust_force = 400
var fire_cooldown = 0.25
var fire_cooldown_remaining = 0

signal has_died

const bullet_scene = preload("res://bullet.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	angular_velocity = 0
	if Input.is_action_pressed("rotate_cw"):
		angular_velocity = rotation_speed
	if Input.is_action_pressed("rotate_ccw"):
		angular_velocity = -rotation_speed
	if Input.is_action_pressed("thrust_forward"):
		apply_force(Vector2.UP.rotated(rotation) * thrust_force)
		
	fire_cooldown_remaining -= delta
	if fire_cooldown_remaining <= 0 && Input.is_action_pressed("fire"):
		fire_cooldown_remaining = fire_cooldown
		shoot_bullet()
		
func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.rotation = rotation
	bullet.position = $BulletSpawnSpot.global_position
	get_parent().add_child(bullet)

func _on_body_entered(_body):
	has_died.emit()
