## Idle
## Weapon is ready to be used, angling towards target aim
extends State

func physics_update(_delta):
	##TODO: this is a placeholder for the player. to make it reusable this can't be here when added to enemies, so it will need to be changed
	# Not sure if I want to move this to player-side controls since that'll be a mess of states back and forth, or if I should just add cases here for if the user is a player or enemy.
	if !Global.game: await SignalBus.main_scene_ready
	owner.look_at(Global.game.get_global_mouse_position())

	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, 'attack')
