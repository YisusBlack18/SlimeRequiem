extends ColorRect

class_name Blood_screen

@onready var player = get_tree().get_first_node_in_group("player")

@export var time = 0

var blood_time = 60

signal changetime(time)
signal toggle_blood_mode(is_bloodmode : bool)

var blood_mode : bool = false:
	get:
		return blood_mode
	set(value):
		blood_mode = value
		emit_signal("toggle_blood_mode", blood_mode)

func _ready():
	hide()
	connect("changetime",Callable(player,"change_time"))

func _on_timer_timeout():
	time += 1
	if !blood_mode:
		if time == blood_time:
			show()
			blood_mode = !blood_mode
	else:
		if time == blood_time+15:
			hide()
			blood_time = blood_time+60
			blood_mode = !blood_mode
	emit_signal("changetime",time)
