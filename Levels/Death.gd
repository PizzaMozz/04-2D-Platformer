extends Control

func _on_Play_Again_pressed():
	Global.save_data["general"]["score"] = 0
	Global.save_data["general"]["level"] = 1
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
