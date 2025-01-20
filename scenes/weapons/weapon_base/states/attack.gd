## Attack
## Weapon is mid-attack or in cooldown between hits
extends State

func enter():
	#TODO: this line works as long as the user is a Player or at least has that prop. I'd like to come up with a cleaner way to do it, but for a prototype it's fine
	owner.get_parent().input_disabled = true
	await owner.attack()
	Transitioned.emit(self, 'Idle')
	
func exit():
	owner.get_parent().input_disabled = false
