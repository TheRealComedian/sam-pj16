## Attacking
## player is in the middle of an attack or cooldown from one
extends State

var original_speed: int

func enter(): 
	owner.input_disabled = owner.weapon.disable_input
	original_speed = owner.movement_speed
	owner.movement_speed *= owner.weapon.speed_modifier
	await owner.weapon.attack()
	Transitioned.emit(self, "Free")


func exit():
	owner.input_disabled = false
	owner.movement_speed = original_speed

func get_movement_direction() -> Vector2:
	if !owner.input_disabled:
		return Input.get_vector("move_left", "move_right", "move_up", "move_down")
	else:
		return Vector2(0, 0) 

func physics_update(delta: float): 
	owner.velocity = owner.velocity.move_toward(
		get_movement_direction() * owner.movement_speed, 
		owner.momentum * delta
	) 
	owner.move_and_slide()
	
#func physics_update(delta: float): pass
