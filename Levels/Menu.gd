extends Control

func _on_Resume_pressed():
	Global.save_data["general"]["score"] = 0
	if Global.save_data["general"]["level"] == 1:
		get_tree().change_scene("res://Levels/Level1.tscn")
	if Global.save_data["general"]["level"] == 2:
		get_tree().change_scene("res://Levels/Level2.tscn")
	if Global.save_data["general"]["level"] == 3:
		get_tree().change_scene("res://Levels/Level3.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Save_pressed():
	Global.save_game()


func _on_Load_pressed():
	Global.load_game()
