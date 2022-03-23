extends Area2D

var score = 0

func _on_Exit_body_entered(body):
	if body.name == "Player":
		if name == "Exit_to_2":
			var _target = get_tree().change_scene("res://Levels/Level2.tscn")
		if name == "Exit_to_3":
			var _target = get_tree().change_scene("res://Levels/Level3.tscn")
		if name == "Exit_to_4":
			var _target = get_tree().change_scene("res://Levels/Game_Over.tscn")
		score += 1000
		Global.save_data["general"]["level"] += 1
