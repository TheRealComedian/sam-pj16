extends CharacterBody2D

@onready var Hitbox := $Hitbox
@onready var animation := $AnimatedSprite2D
var speed =10
var direction= Vector2.RIGHT

func _ready():
	direction=Vector2.RIGHT.rotated(global_rotation)
	animation.play('default')

func _process(delta):
	velocity=direction*speed
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()

func enable_layer():
	$Hitbox.set_collision_layer_value(4, true)
	print($Hitbox.get_collision_layer_value(4))
	
func disable_layer():
	$Hitbox.set_collision_layer_value(4, false)
	print($Hitbox.get_collision_layer_value(4))
	
