extends Control


@onready var comtrol_main = $ControlMain
@onready var label_tutorial = $ControlMain/LabelTutorial
@onready var label_Info = $ControlMain/LabelInfo
@onready var label_stats = $ControlMain/LabelStat

@onready var control_game = $ControlGame
@onready var label_question = $ControlGame/LabelQuestion
@onready var label_number_question = $ControlGame/LabelNumberQuestion
@onready var buttons = $ControlGame/Buttons
var number_question = 1

var question_bank: QuestionBank

var save_manager
var total_wins = 0
var total_losses = 0

func _ready() -> void:
	save_manager = load("res://save_manager.gd").new()
	var stats = save_manager.load_stats()
	total_wins = stats.wins
	total_losses = stats.losses
	update_stats(total_wins, total_losses)
	
	question_bank = QuestionBank.new()
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
	
	var info_level = question_bank.get_question(number_question-1)
	var wrong_answer = info_level[2]
	wrong_answer.shuffle()
	label_question.text = info_level[0]
	label_number_question.text = "%02d/10" % number_question
	var random_indx = randi() % buttons.get_child_count()
	var inx_wrong = 0
	for i in buttons.get_child_count():
		var button = buttons.get_child(i)
		for connection in button.pressed.get_connections():
			button.pressed.disconnect(connection.callable)
		if i == random_indx:
			button.pressed.connect(_on_right_var)
			button.text = info_level[1]
		else:
			button.pressed.connect(_on_wrong_var)
			button.text = wrong_answer[inx_wrong]
			inx_wrong += 1
	number_question += 1


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
		total_wins += 1
		update_stats(total_wins, total_losses)
		save_manager.save_stats(total_wins, total_losses)
	else:
		label_Info.text = "Вы не прошли виктарину!"
		total_losses += 1
		update_stats(total_wins, total_losses)
		save_manager.save_stats(total_wins, total_losses)
	number_question = 1

func update_stats(win:int, lose:int):
	label_stats.text = \
"Статистика
Побед: %d
Поражений: %d" % [win, lose]
