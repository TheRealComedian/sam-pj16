## Chase
## enemy moves towards player while they are in detection range
extends State

var agent: NavigationAgent2D
var localize=0.69

#func connect_signals():
	#owner.attack_range.body_entered.connect(player_in_attack_range)
	#owner.detection_range.body_exited.connect(player_lost)
#func disconnect_signals():
	#owner.attack_range.body_entered.disconnect(player_in_attack_range)
	#owner.detection_range.body_exited.disconnect(player_lost)
#
func enter():
	print("chase")
	#connect_signals()
	#
	agent = owner.navigation_agent
	#
	#await Util.wait(self.localize).timeout
	#if Global.player in (owner.attack_range as Area2D).get_overlapping_bodies():
		#disconnect_signals()
		#Transitioned.emit(self, 'Attack')
		#return
	call_deferred('seek_target', Global.player)
#
func seek_target(target: Node2D):
	#await get_tree().physics_frame
	if !target: return
	agent.target_position = target.global_position
#
func physics_update(delta):
	owner.weapon.look_at(Global.player.position)
	
	if Global.player not in (owner.detection_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Idle')
		return
	if Global.player in (owner.attack_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Attack')
		return
	
	seek_target(Global.player)
	var current_agent_position = owner.global_position
	var next_path_position = agent.get_next_path_position()
	var new_velocity = owner.velocity.move_toward(
		(owner as Enemy).position.direction_to(next_path_position) * owner.movement_speed, 
		owner.momentum * delta
	)
	if agent.avoidance_enabled:
		agent.set_velocity(new_velocity)
		owner.velocity = agent.velocity
	else:
		velocity_computed(new_velocity)
	
	owner.move_and_slide()
#
#func player_in_attack_range(body):
	#disconnect_signals()
	#Transitioned.emit(self, 'Attack')
	#
#func player_lost(body):
	#disconnect_signals()
	#Transitioned.emit(self, 'Idle')
#
#
func velocity_computed(safe_velocity: Vector2):
	owner.velocity = safe_velocity
