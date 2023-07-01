class_name ScoutAnt
extends CharacterBody2D 


signal target_reached
signal path_changed(path)
@export var MAX_SPEED: float = 105
@export var is_selected: bool = 105
#var target_position = Vector2.ZERO
var last_move_velocity = Vector2.ZERO
var move_direction = Vector2.ZERO
var did_arrive = false
@onready var navigation_agent = $NavigationAgent2D

func _ready():
	set_target_position(position)
	
func set_target_position(target:Vector2) -> void:
	if is_selected:
		did_arrive = false
		navigation_agent.target_position = target
	
func _physics_process(delta):
	var move_direction = position.direction_to(navigation_agent.get_next_path_position())
	velocity = move_direction * MAX_SPEED
	navigation_agent.set_velocity(velocity)
	look_at_direction(move_direction)
	if not _arrived_at_location():
		set_velocity(velocity)
		move_and_slide()
		velocity = velocity
	elif not did_arrive:
		did_arrive = true
		emit_signal("path_changed", [])
		emit_signal("target_reached")
		
func look_at_direction(direction:Vector2) -> void:
	direction = direction.normalized()
	move_direction = direction

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()
	
func _get_direction_string(angle:float) -> String:
	var angle_deg = round(rad_to_deg(angle))
	if angle_deg > -90.0 and angle_deg < 90.0:
		return "Right"
	return "Left"	


func _on_navigation_agent_2d_path_changed():
	emit_signal("path_changed", navigation_agent.get_current_navigation_path())
