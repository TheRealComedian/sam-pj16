## Attack
## enemy is actively attacking with their weapon
extends State

var ims: int

#func connect_signals():
	#owner.attack_range.body_exited.connect(player_left_attack_range)
#func disconnect_signals():
	#owner.attack_range.body_exited.disconnect(player_left_attack_range)
#
#
func enter():
	print("attack")
	await (owner as Enemy).weapon.attack_tween()
	
	if Global.player in (owner.attack_range as Area2D).get_overlapping_bodies():
		enter()
		return
	else:
		Transitioned.emit(self, 'Idle')
		return
	
	#connect_signals()
	#ims = owner.movement_speed
	#owner.movement_speed = 0
	#print("running attack tweeen")
	#
	#print("done attacking, waiting to see if they remain")
	#await Util.wait(3).timeout
	#
	#if player_in_attack_range:
		#print("still in range, attacking again")
		#enter()
	#else:
		#print("left range, going to chase")
		#disconnect_signals()
		#Transitioned.emit(self, 'Chase')
#
#func player_left_attack_range():
	#player_in_attack_range = false
#
#func exit():
	#print('leaving attack')
	#owner.movement_speed = ims
	#owner.weapon.cancel_attack()
