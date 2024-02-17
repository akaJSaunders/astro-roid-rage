extends Node

signal score_changed
signal level_changed
signal lives_changed

signal start_game
signal game_over
signal level_complete

var score:
		get:
			return score
		set(value):
			score = value
			score_changed.emit(score)

var level:
		get:
			return level
		set(value):
			level = value
			level_changed.emit(level)

var lives:
		get:
			return lives
		set(value):
			lives = value
			lives_changed.emit(lives)

var asteroid_big_scene = preload('res://asteroid_big.tscn')
var asteroid_spawn_range_min = 200
var asteroid_spawn_range_max = 500
var asteroid_number = 2

var player_scene = preload('res://player.tscn')
var player_node : Node2D = null

@onready var viewport_size = get_viewport().size

@export var asteroid_container : Node2D

func _ready():
	setup_new_game()
	
func setup_new_game():
	cleanup_game()
	lives = 3
	score = 0
	level = 0
	asteroid_number = 2
	setup_new_level()
	
func cleanup_game():
	if player_node:
		player_node.queue_free()
		player_node = null
	
	for asteroid in asteroid_container.get_children():
		asteroid.queue_free()

func _on_player_death():
	if lives <= 0:
		game_is_over()
		return

	lives -= 1
	spawn_player()
	
func game_is_over():
	if player_node:
		player_node.queue_free()
		player_node = null

	game_over.emit()

func setup_new_level():
	level += 1
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
	asteroid_container.call_deferred('add_child',node)
	
func add_to_score():
	score += 1
	
func increase_dificulty():
	asteroid_number += 2

func _on_score_changed(_score):
	print(asteroid_container.get_child_count())
	if asteroid_container.get_child_count() == 1 && score > 0:
		level_complete.emit(score, lives, level)

func next_level():
	cleanup_game()
	increase_dificulty()
	setup_new_level()
