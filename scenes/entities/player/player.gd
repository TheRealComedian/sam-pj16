class_name Player extends CharacterBody2D

@export var input_disabled: bool = false
@export var movement_speed: int = 600

func _ready():
	if Global.player: 
		self.queue_free()
		return
	Global.player = self

func _physics_process(_delta):
	if input_disabled: return
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = input_direction * movement_speed
	move_and_slide()
