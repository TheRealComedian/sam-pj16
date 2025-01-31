## Reaper: Projectile
## fire projectiles at player while standing still
extends State

func enter():
	print("projectile")
func exit():
	owner.stamina -= 1
func physics_update(delta: float):
	pass
