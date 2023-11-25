extends Node2D

@onready var level_completed: ColorRect = $CanvasLayer/LevelCompleted

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	Events.level_completed.connect(show_level_completed)
	
func show_level_completed() -> void:
	level_completed.show()
	get_tree().paused = true
