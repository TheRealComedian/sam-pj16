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
	
	#added the shooting to the player for the sake of testing, will add it to a bow weapon class later
	weapon_timer -= delta
	if Input.is_action_pressed("left_click")and weapon_timer <= 0:
		weapon_timer = cooldown
		fire()

#added the shooting to the player for the sake of testing, will add it to a bow weapon class later
func fire() -> void:
	var arrow = ArrowScene.instantiate()
	arrow.global_position = shoot_position.global_position
	#arrow.direction = global_position.direction_to(get_global_mouse_position())
	arrow.rotation_degrees = rotation_degrees
	arrow.linear_velocity = Vector2(arrow_speed,0).rotated(arrow.rotation)
	add_child(arrow)
	pass
	
