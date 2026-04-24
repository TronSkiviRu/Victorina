class_name QuestionBank
extends RefCounted

class QuestionData:
	extends RefCounted
	
	var question: String
	var correct_answer: String
	var wrong_answers: Array[String] = []
	
	func _init(p_question: String, p_correct: String, p_wrong: Array[String]):
		question = p_question
		correct_answer = p_correct
		wrong_answers = p_wrong
	
	func get_shuffled_answers() -> Array[String]:
		var all = wrong_answers + [correct_answer]
		all.shuffle()
		return all

var questions: Array = _fill()

func _fill() -> Array:
	var ques = [
		QuestionData.new("Как звали кота?", "Матроскин", ["Леопольд", "Гарфилд", "Базилио"]),
		QuestionData.new("Кто работал почтальоном?", "Печкин", ["Шарик", "Дядя Фёдор", "Папа"]),
		QuestionData.new("Фамилия Дяди Фёдора?", "Свекольников", ["Морковкин", "Картошкин", "Капустин"]),
		QuestionData.new("Что купил Матроскин?", "Корову", ["Телёнка", "Козу", "Трактор"]),
		QuestionData.new("Кто воровал из холодильника?", "Шарик", ["Матроскин", "Печкин", "Галчонок"]),
		QuestionData.new("Порода Шарика?", "Дворняжка", ["Овчарка", "Лабрадор", "Такса"]),
		QuestionData.new("Название деревни?", "Простоквашино", ["Кисломолочное", "Сметанино", "Творожное"]),
		QuestionData.new("Что прислал Печкин?", "Посылку", ["Письмо", "Телеграмму", "Бандероль"]),
		QuestionData.new("С кем дружил галчонок?", "С котом", ["С Шариком", "С Печкиным", "Ни с кем"]),
		QuestionData.new("Чьи документы — усы и лапы?", "Матроскина", ["Шарика", "Дяди Фёдора", "Печкина"])
	]
	return ques

func get_question(indx:int):
	if indx == 0:
		randomize() 
		questions.shuffle()
	
	var question = questions[indx].question
	var true_answer = questions[indx].correct_answer
	var list_wrong = questions[indx].wrong_answers
	
	return [question, true_answer, list_wrong]
