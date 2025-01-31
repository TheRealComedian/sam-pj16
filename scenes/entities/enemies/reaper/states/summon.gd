## Reaper: Summon
## summon enemies in arena
extends State

func enter():
	print("summon")
func exit():
	owner.stamina -= 1
func physics_update(delta: float):
	pass
