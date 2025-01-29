## Attacking
## player is in the middle of an attack or cooldown from one
extends State

func enter(): 
	owner.input_disabled = true
	await owner.weapon.attack()
	Transitioned.emit(self, "Free")

func exit():
	owner.input_disabled = false

#func physics_update(delta: float): pass
