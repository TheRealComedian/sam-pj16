class_name Arrow
extends CharacterBody2D

@export var speed := 10.0
@export var lifetime := .6

var direction:=Vector2.RIGHT

@onready var timer := $Timer
@onready var sprite := $Sprite2D
@onready var Hitbox := $Hitbox
@onready var animation := $AnimatedSprite2D

func _ready():
	direction=Vector2.RIGHT.rotated(global_rotation)
	timer.timeout.connect(queue_free)
	timer.start(lifetime)

func _process(delta):
	velocity=direction*speed
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()
