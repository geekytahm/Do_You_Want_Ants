extends Node2D

@export var max_radius: float = 30.0
@export var animation_time: float = 1.2

@onready var tween : Tween = create_tween()

var radius = 0.0

func _ready():
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "radius", max_radius, animation_time)
	tween.parallel().tween_property(self, "modulate", Color(1, 1, 1, 0), animation_time)

	tween.connect("finished", Callable(self, "_finished"))
	
func _draw():
	draw_circle(Vector2(0, 0), radius, modulate)

func _process(delta):
	queue_redraw()

func _finished():
	queue_free()
