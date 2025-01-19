class_name Player extends CharacterBody2D

@export var input_disabled: bool = false
@export var movement_speed: int = 300
const momentum = 1200
const friction = 600
@onready var cursor: AnimatedSprite2D = $Cursor
@onready var cursor_ray: RayCast2D = $CursorFacing

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

func _physics_process(delta: float) -> void:
	cursor.global_position = get_global_mouse_position()
	# Placeholder visual to show what direction a weapon would be facing
	cursor_ray.rotation = angle_to_cursor
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !input_disabled: 
		self.velocity = velocity.move_toward(input_direction * movement_speed, momentum * delta) 
	move_and_slide()
