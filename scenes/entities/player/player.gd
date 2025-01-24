class_name Player extends Character
@onready var dir = $Dir

func _ready():
	if Global.player:
		self.queue_free()
		return 
	Global.player = self
	Global.hud.health_bar.connect_health(health_component)

func get_movement_direction() -> Vector2:
	if !input_disabled:
		return Input.get_vector("move_left", "move_right", "move_up", "move_down")
	else:
		return Vector2(0, 0) 

func _input(event: InputEvent):
	if input_disabled: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		input_disabled = true
		await weapon.attack()
		input_disabled = false

func _physics_process(delta):
	if weapon and !input_disabled:
			weapon.look_at(Global.game.get_global_mouse_position())
		
	velocity = velocity.move_toward(
		get_movement_direction() * movement_speed, 
		momentum * delta
	) 
	move_and_slide()

func changed_direction(new_direction: Util.DIRECTION):
	print('new rotation')
	match new_direction:
		Util.DIRECTION.DOWN: dir.play('down')
		Util.DIRECTION.LEFT: dir.play('left')
		Util.DIRECTION.RIGHT: dir.play('right')
		Util.DIRECTION.UP: dir.play('up')
