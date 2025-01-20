class_name Player extends CharacterBody2D

@export var input_disabled: bool = false
@export var movement_speed: int = 300
const momentum = 1200
const friction = 600
@export var health_component: HealthComponent
@export var weapon: Weapon

func _ready():
	if Global.player:
		self.queue_free()
		return 
	Global.player = self
	Global.hud.health_bar.connect_health(health_component)
	
func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_disabled:
		input_direction = Vector2(0, 0) 
	
	if !input_disabled:
		# aim weapon to cursor position
		if weapon:
			weapon.look_at(Global.game.get_global_mouse_position())
		
	velocity = velocity.move_toward(
		input_direction * movement_speed, 
		momentum * delta
	) 
	move_and_slide()
