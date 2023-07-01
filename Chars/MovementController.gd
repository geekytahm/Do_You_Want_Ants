class_name MovementController
extends Node2D

@onready var ClickEffect = preload("res://art/ClickEffect.tscn")
@onready var npc:ScoutAnt = get_parent()
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var target_position = get_global_mouse_position()
		npc.set_target_position(target_position)
		var clickEffect = ClickEffect.instantiate()
		clickEffect.global_position = target_position
		clickEffect.set_as_top_level(true)
		get_parent().add_child(clickEffect)
	
