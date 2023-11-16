extends Control

@export var score_label : Label
@export var level_label : Label
@export var lives_label : Label

@export var game_over_panel : Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_main_score_changed(new_score):
	score_label.text = "Score: %d" % new_score


func _on_main_lives_changed(new_lives):
	lives_label.text = "Lives: %d" % new_lives


func _on_main_level_changed(new_level):
	level_label.text = "Level: %d" % new_level


func _on_main_game_over():
	game_over_panel.show()


func _on_restart_button_pressed():
	get_parent().setup_new_game()
	game_over_panel.hide()
