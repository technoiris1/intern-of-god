extends Node2D

@onready var rain = $"CPUParticles2D"

var raining := false

func _input(event):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
		# start rain
		if event.pressed:
			raining = true
			rain.emitting = true
		
		# stop rain
		else:
			raining = false
			rain.emitting = false


func _process(delta):
	# move rain with mouse while holding click
	if raining:
		rain.global_position = get_global_mouse_position()
