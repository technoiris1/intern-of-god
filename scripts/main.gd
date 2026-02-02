extends Node2D

@onready var rain = $"CPUParticles2D"
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var temp_label = $CanvasLayer/TempLabel
@onready var live_label = $CanvasLayer/LivabilityLabel

var raining := false
var time_left := 180.0
var temperature := 20
var livability := 50.0


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			raining = true
			rain.emitting = true
		else:
			raining = false
			rain.emitting = false


func _process(delta):

	if raining:
		rain.global_position = get_global_mouse_position()
		
		if temperature >= 18 and temperature <= 26:
			if livability < 80:
				livability += 1.0 * delta
		else:
			livability -= 2.0 * delta

	else:
		livability -= 0.5 * delta

	livability = clamp(livability,0,100)

	time_left -= delta
	if time_left < 0:
		time_left = 0
		game_over()

	update_timer_text()
	live_label.text = "Livability: " + str(int(livability))


func update_timer_text():
	var m = int(time_left)/60
	var s = int(time_left)%60
	timer_label.text = str(m)+":"+str(s).pad_zeros(2)


func game_over():
	print("TIME UP")


func _on_temp_slider_value_changed(value: float) -> void:
	temperature = value
	temp_label.text = "Temp: " + str(int(value))
