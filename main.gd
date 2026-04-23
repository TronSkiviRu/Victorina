extends Control

@onready var comtrol_main = $ControlMain
@onready var label_tutorial = $ControlMain/LabelTutorial
@onready var label_Info = $ControlMain/LabelInfo

@onready var control_game = $ControlGame
@onready var label_question = $ControlGame/LabelQuestion
@onready var label_number_question = $ControlGame/LabelNumberQuestion
@onready var buttons = $ControlGame/Buttons
var number_question = 1

func _ready() -> void:
	comtrol_main.show()
	control_game.hide()


func _on_start_button_pressed() -> void:
	comtrol_main.hide()
	control_game.show()
	start_new_victory()


func _on_tutorial_pressed() -> void:
	label_tutorial.visible = !label_tutorial.visible
	
func start_new_victory():
	if number_question == 11:
		finish_victorina()
	
	label_question.text = "Hfljk"
	label_number_question.text = "%02d/10" % number_question
	var n = randi() % buttons.get_child_count()
	
	for i in buttons.get_child_count():
		var button = buttons.get_child(i)
		for connection in button.pressed.get_connections():
			button.pressed.disconnect(connection.callable)
		if i == n:
			button.pressed.connect(_on_right_var)
		else:
			button.pressed.connect(_on_wrong_var)
	number_question += 1
	print(number_question)


func _on_right_var():
	start_new_victory()

func _on_wrong_var():
	finish_victorina()

func finish_victorina():
	comtrol_main.show()
	control_game.hide()
	label_Info.show()
	if number_question == 11:
		label_Info.text = "Вы прошли виктарину!"
	else:
		label_Info.text = "Вы не прошли виктарину!"
	number_question = 0
