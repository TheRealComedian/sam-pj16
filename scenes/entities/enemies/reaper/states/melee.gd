## Reaper: Melee
## pursue player with melee attacks
extends State

func enter():
	print("melee")
func exit():
	owner.stamina -= 1
func physics_update(delta: float):
	pass
