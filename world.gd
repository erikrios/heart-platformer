extends Node2D

@export var next_level: PackedScene

var level_time := 0.0
var start_level_msec := 0.0

@onready var level_completed: ColorRect = $CanvasLayer/LevelCompleted
@onready var start_in: ColorRect = %StartIn
@onready var start_in_label: Label = %StartInLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var level_time_label: Label = %LevelTimeLabel

func _ready() -> void:
	Events.level_completed.connect(show_level_completed)
	get_tree().paused = true
	start_in.visible = true
	await LevelTransition.fade_from_black()
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	start_in.visible = false
	start_level_msec = Time.get_ticks_msec()
	
func _process(delta: float) -> void:
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text = str(level_time / 1000.0)
	
func retry() -> void:
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)
	
func go_to_next_level() -> void:
	if not next_level is PackedScene:
		return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	
func show_level_completed() -> void:
	level_completed.show()
	level_completed.retry_button.grab_focus()
	get_tree().paused = true

func _on_level_completed_retry() -> void:
	retry()

func _on_level_completed_next_level() -> void:
	go_to_next_level()
