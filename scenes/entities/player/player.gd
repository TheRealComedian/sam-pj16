class_name Player extends Character

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

func _physics_process(delta):
	if weapon and !input_disabled:
			weapon.look_at(Global.game.get_global_mouse_position())
		
	velocity = velocity.move_toward(
		get_movement_direction() * movement_speed, 
		momentum * delta
	) 
	move_and_slide()
