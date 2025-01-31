## Reaper: Projectile
## fire projectiles at player while standing still
extends State

func enter():
	print("projectile")
	# move to column
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(owner, 'position', owner.get_perch_point(), 0.3)
	await tween.finished
	# aim at player
	owner.weapon.look_at(Global.player.position)
	# fire projectiles
	await owner.weapon.windup_tween()
	await owner.weapon.projectile_attack(randi_range(2, 5))
	owner.stamina -= 1
	var dec = owner.decide_action()
	if dec == "Projectile": 
		enter()
	else: 
		Transitioned.emit(self, dec)
	return
	
func exit():
	pass
func physics_update(delta: float):
	pass
