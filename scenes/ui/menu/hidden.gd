## Hidden
## no menu is currently open
extends ControlState

func enter():
	get_tree().paused = false

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed('pause'):
		Transitioned.emit(self, 'Pause')

func exit():
	get_tree().paused = true
