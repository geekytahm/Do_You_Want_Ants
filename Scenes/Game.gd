extends Node2D
@onready var line = $Line2D

func _on_scout_ant_path_changed(path):
	line.points = path 
