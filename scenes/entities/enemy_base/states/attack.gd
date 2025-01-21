## Attack
## enemy is actively attacking with their weapon
extends State

func enter():
	#TODO: add 'windup' period where enemy projects an attack before executing giving change to dodge
	await (owner as Enemy).weapon.attack()
	Transitioned.emit(self, 'Idle')
