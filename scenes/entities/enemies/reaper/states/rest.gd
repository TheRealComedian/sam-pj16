## Reaper: Rest
## take a break from actions allowing window for attack
extends State

func enter():
	print("rest")
	await Util.wait(randi_range(3, 5))
	owner.stamina += 1
	Transitioned.emit(self, owner.decide_action())
func exit():
	pass
func physics_update(delta: float):
	pass
