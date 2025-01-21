## Chase
## enemy moves towards player while they are in detection range
extends State

func enter():
	owner.attack_range.body_entered.connect(player_in_attack_range)
	owner.detection_range.body_exited.connect(player_lost)
	
	if Global.player in (owner.attack_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Attack')
		return
	
	
func physics_update(delta):
	owner.weapon.look_at(Global.player.position)
	
	#TODO: add actual pathfinding
	owner.velocity = owner.velocity.move_toward(
		(owner as Enemy).position.direction_to(Global.player.position) * owner.movement_speed, 
		owner.momentum * delta
	)
	owner.move_and_slide()

func player_in_attack_range(body):
	Transitioned.emit(self, 'Attack')
	
func player_lost(body):
	Transitioned.emit(self, 'Idle')

func exit():
	owner.attack_range.body_entered.disconnect(player_in_attack_range)
	owner.detection_range.body_exited.disconnect(player_lost)
