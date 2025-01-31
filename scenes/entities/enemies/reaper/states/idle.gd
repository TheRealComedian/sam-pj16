## Reaper: Idle
## before boss fight, no action
extends State

func enter():
	#TODO cutscene
	await Util.wait(1).timeout
	Transitioned.emit(self, 'Rest')
func exit():
	pass
func physics_update(delta: float):
	pass
