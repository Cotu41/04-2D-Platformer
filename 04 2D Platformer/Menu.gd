extends Control

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if visible:
			hide()
		else:
			show()
func _on_Save_pressed():
	Global.save_game()

func _on_Load_pressed():
	Global.load_game()

func _on_Quit_pressed():
	get_tree().quit()



func _on_Resume_pressed():
	hide()
	pass # Replace with function body.
