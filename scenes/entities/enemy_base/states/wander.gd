## Wandering
## enemy walks in random direction
extends State

var direction: Vector2
var wander_timer: Timer
var done_wandering: bool = false

func enter():
	owner.detection_range.body_entered.connect(player_detected)
	
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1., 1.0))
	
	done_wandering = false
	wander_timer = Util.wait(1, func(): done_wandering = true)

func physics_update(delta):
	if done_wandering: 
		Transitioned.emit(self, 'Idle')
		if is_instance_valid(wander_timer): wander_timer.quedue_free()
	
	if Global.player in (owner.detection_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Chase')
		return
	
	#TODO: once rooms are implemented ensure movement tends toward center of room
	#TODO: add actual pathfinding
	owner.velocity = owner.velocity.move_toward(
		direction * owner.movement_speed, 
		owner.momentum * delta
	)
	owner.move_and_slide()

func player_detected(area):
	Transitioned.emit(self, 'Chase')

func exit():
	owner.detection_range.body_entered.disconnect(player_detected)
