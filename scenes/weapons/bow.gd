class_name Bow extends Weapon

@export var sprite:AnimatedSprite2D
const ArrowScene := preload("res://scenes/weapons/arrow.tscn")

@onready var shoot_position := $CursorFacing
@export var cooldown_duration: float = 0.69

var weapon_timer = 0.0
var anim_duration = 0.5
var arrow_speed = 900

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func cancel_attack():
	#how do you cancel an arrow
	pass

func attack():
	sprite.play('shoot')
	await Util.wait(self.anim_duration).timeout
	var arrow = ArrowScene.instantiate()
	arrow.global_position = shoot_position.global_position
	if user.mc:
		arrow.direction = global_position.direction_to(get_global_mouse_position())
	else:
		shoot_position.target_position=Global.player.position
		arrow.direction = (shoot_position.target_position).normalized()
	#arrow.rotation_degrees = rotation_degrees
	#arrow.linear_velocity = Vector2(arrow_speed,0).rotated(arrow.rotation)
	add_child(arrow)
	sprite.play('idle')
	await Util.wait(self.cooldown_duration).timeout
	
