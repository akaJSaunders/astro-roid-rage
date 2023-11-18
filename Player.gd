extends RigidBody2DWrap

var rotation_speed = TAU
var thrust_force = 400
var fire_cooldown = 0.25
var fire_cooldown_remaining = 0
var invulnerability_duration = 2.0
var invulnerability_remaining = invulnerability_duration

signal has_died

const bullet_scene = preload("res://bullet.tscn")

@onready var player_sprite = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if invulnerability_remaining > 0:
		invulnerability_remaining -= delta
		
		if invulnerability_remaining > 0:
			start_invulnerable_visual()
		else:
			stop_invulnerable_visual()
		
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
	
func start_invulnerable_visual():
	player_sprite.modulate.a = sin(invulnerability_remaining * 50.0) / 4.0 + 0.50
	
func stop_invulnerable_visual():
	player_sprite.modulate.a = 1

func _on_body_entered(_body):
	if invulnerability_remaining > 0:
		return

	has_died.emit()
