## Free
## character can move or stand still freely
extends State

func enter(): pass
func exit(): pass
func physics_update(delta: float): 
	owner.velocity = owner.velocity.move_toward(
		get_movement_direction() * owner.movement_speed, 
		owner.momentum * delta
	) 
	owner.move_and_slide()

func get_movement_direction() -> Vector2:
	if !owner.input_disabled:
		return Input.get_vector("move_left", "move_right", "move_up", "move_down")
	else:
		return Vector2(0, 0) 

func _input(event: InputEvent):
	if owner.input_disabled: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Transitioned.emit(self, 'Attacking')

func _physics_process(delta):
	if owner.weapon and !owner.input_disabled:
		owner.weapon.look_at(Global.game.get_global_mouse_position())
