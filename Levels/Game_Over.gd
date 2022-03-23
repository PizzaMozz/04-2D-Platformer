extends Control

var prevLev

func _on_Resume_pressed():
	Global.save_data["general"]["score"] = 0
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
