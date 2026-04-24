class_name SaveManager
extends RefCounted

const SAVE_PATH = "user://prostokvashino_stats.txt"

func save_stats(wins: int, losses: int):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_line(str(wins))
		file.store_line(str(losses))
		file.close()

func load_stats() -> Dictionary:
	var result = {"wins": 0, "losses": 0}
	
	if not FileAccess.file_exists(SAVE_PATH):
		return result
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var line1 = file.get_line()
		if line1.is_valid_int():
			result.wins = int(line1)
		
		var line2 = file.get_line()
		if line2.is_valid_int():
			result.losses = int(line2)
		
		file.close()

	return result

func reset_stats():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
