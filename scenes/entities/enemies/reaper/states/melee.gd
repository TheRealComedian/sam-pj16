## Reaper: Melee
## pursue player with melee attacks
extends State
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var agent: NavigationAgent2D
var done_spinning: bool = false

func enter():
	print("melee")
	done_spinning = false
	agent = owner.get_node('NavigationAgent2D')
	agent = owner.navigation_agent
	call_deferred('seek_target', Global.player)
	animation_player.play('spin_attack')
	Util.wait(2, func(): done_spinning = true)
	
func exit():
	pass

func physics_update(delta):
	if done_spinning:
		animation_player.stop()
		await Util.wait(2).timeout
		owner.stamina -= 1
		var dec = owner.decide_action()
		if dec == "Melee": 
			enter()
		else: 
			Transitioned.emit(self, dec)
		return
	
	owner.velocity = owner.velocity.move_toward(
		(owner.global_position as Vector2).direction_to(Global.player.global_position) * owner.movement_speed, 
		owner.momentum * delta
	) 
	owner.move_and_slide()
	
	
