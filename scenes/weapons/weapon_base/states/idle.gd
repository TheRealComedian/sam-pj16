## Idle
## Weapon is ready to be used, angling towards target aim
extends State

func physics_update(_delta):
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, 'attack')
