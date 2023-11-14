extends Node

var num_asteroids = 4
var player_scene = preload('res://player.tscn')
var asteroid_big_scene = preload('res://asteroid_big.tscn')

@onready var viewport_size = get_viewport().size

var asteroid_spawn_range_min = 200
var asteroid_spawn_range_max = 500

var player_node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_new_level(num_asteroids)
	pass # Replace with function body.

func _on_player_death():
	spawn_player()

func setup_new_level(asteroid_number):
	spawn_player()
	
	for i in asteroid_number:
		
		spawn_asteroid()
		
func spawn_player():
	if player_node:
		player_node.queue_free()
	
	player_node = player_scene.instantiate()
	player_node.position = viewport_size / 2
	player_node.has_died.connect(_on_player_death)
	call_deferred("add_child", player_node)
	
func spawn_asteroid():
	var node = asteroid_big_scene.instantiate()
	node.position = viewport_size/2.0 + (Utility.randomUnitVector2() * randf_range(asteroid_spawn_range_min, asteroid_spawn_range_max))
	add_child(node)
