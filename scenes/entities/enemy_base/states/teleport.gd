extends State

var agent: NavigationAgent2D

var max_distance=56893434343
var a = randf() * 2 * PI
var r = max_distance * sqrt(randf())

var x = r * cos(a)
var y = r * sin(a)

var teleport_location = Global.player.position + Vector2(x,y)

func enter():
	agent = owner.navigation_agent
	owner.attack_range.body_entered.connect(player_in_attack_range)
	owner.detection_range.body_exited.connect(player_lost)
	owner.position=teleport_location
	if Global.player in (owner.attack_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Attack')
		return
	call_deferred('seek_target', Global.player)

func seek_target(target: Node2D):
	#await get_tree().physics_frame
	if !target: return
	agent.target_position = target.global_position

func physics_update(delta):
	owner.weapon.look_at(Global.player.position)
	
	seek_target(Global.player)
	var current_agent_position = owner.global_position
	var next_path_position = agent.get_next_path_position()
	var new_velocity = owner.velocity.move_toward(
		(owner as Enemy).position.direction_to(next_path_position) * owner.movement_speed, 
		owner.momentum * delta
	)
	if agent.avoidance_enabled:
		agent.set_velocity(new_velocity)
	else:
		velocity_computed(new_velocity)
	
	owner.move_and_slide()

func player_in_attack_range(body):
	Transitioned.emit(self, 'Attack')
	
func player_lost(body):
	owner.position=teleport_location
	Transitioned.emit(self, 'Idle')

func exit():
	owner.attack_range.body_entered.disconnect(player_in_attack_range)
	owner.detection_range.body_exited.disconnect(player_lost)

func velocity_computed(safe_velocity: Vector2):
	owner.velocity = safe_velocity
