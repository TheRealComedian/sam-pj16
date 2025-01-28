class_name Projectile extends CharacterBody2D

@onready var timer := $Timer
@onready var Hitbox := $Hitbox
@onready var sprite := $AnimatedSprite2D
@export var speed: int = 10
@export var lifetime := .6
var direction= Vector2.RIGHT


func _ready():
	direction=Vector2.RIGHT.rotated(global_rotation)
	sprite.play('default')
	timer.timeout.connect(queue_free)
	timer.start(lifetime)

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
	
