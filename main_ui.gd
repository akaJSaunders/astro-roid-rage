extends Control

@export var score_label : Label
@export var level_label : Label
@export var lives_label : Label

@export var new_level_score : Label
@export var new_level_lives : Label
@export var new_level_header : Label

@export var game_over_panel : Panel
@export var level_complete_panel : Panel

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

func _on_exit_button_pressed():
	get_tree().quit(0)

func _on_main_level_complete(score, lives, level):
	new_level_score.text = "Score Earned: %d" % score
	new_level_lives.text = "Lives Remaining: %d" % lives
	new_level_header.text = "level %d complete!" % level
	level_complete_panel.show()

func _on_continue_pressed():
	get_parent().next_level()
	level_complete_panel.hide()
