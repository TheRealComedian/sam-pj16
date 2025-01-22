class_name Player extends CharacterBody2D

const ArrowScene := preload("res://scenes/entities/weapons/arrow.tscn")

@export var input_disabled: bool = false
@export var movement_speed: int = 300
const momentum = 1200
const friction = 600
@onready var cursor: AnimatedSprite2D = $Cursor
@onready var cursor_ray: RayCast2D = $CursorFacing
@export var health_component: HealthComponent
@onready var healthbar: ProgressBar = $Healthbar	# Placeholder for testing health until health GUI is added
@onready var shoot_position := $CursorFacing

var weapon_timer = 0.0
var cooldown = 0.69
var speed_bullet = 900

## rotation angle to orient something towards the cursor
##NOTE: default resting position is facing right (0.0)
var angle_to_cursor: float:
	get():
		return self.get_angle_to(get_global_mouse_position())

func _ready():
	if Global.player:
		self.queue_free()
		return 
	Global.player = self
	
	healthbar.max_value = health_component.max_health
	healthbar.value = health_component.current_health
	health_component.health_changed.connect(update_health_gui)
	

func update_health_gui(_prev: float, new: float):
	healthbar.value = new

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	cursor.global_position = get_global_mouse_position()
	# Placeholder visual to show what direction a weapon would be facing
	cursor_ray.rotation = angle_to_cursor
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !input_disabled: 
		self.velocity = velocity.move_toward(input_direction * movement_speed, momentum * delta) 
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
	arrow.linear_velocity = Vector2(speed_bullet,0).rotated(arrow.rotation)
	add_child(arrow)
	pass
	
