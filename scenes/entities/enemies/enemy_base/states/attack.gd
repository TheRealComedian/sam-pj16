## Attack
## enemy is actively attacking with their weapon
extends State

func enter():
	#print("attack")
	#TODO: add 'windup' period where enemy projects an attack before executing giving change to dodge
	await (owner as Enemy).weapon.attack()
	
	#await Util.wait(0.5).timeout
	Transitioned.emit(self, 'Idle')

func exit():
	owner.weapon.cancel_attack()
