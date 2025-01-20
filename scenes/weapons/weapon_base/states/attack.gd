## Attack
## Weapon is mid-attack or in cooldown between hits
extends State

func enter():
	await owner.attack()
	Transitioned.emit(self, 'Idle')
