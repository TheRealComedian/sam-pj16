## Attack
## Weapon is mid-attack or in cooldown between hits
extends State

func enter():
	owner.user.input_disabled = true
	await owner.attack()
	Transitioned.emit(self, 'Idle')
	
	owner.user.input_disabled = false
