class_name Projectile extends CharacterBody2D

@onready var timer := $Timer
@onready var Hitbox := $Hitbox
@onready var sprite := $AnimatedSprite2D
@export var speed: int = 10
@export var lifetime := .6
var user: Character
var direction= Vector2.RIGHT

static func spawn_projectile(proj_scene: PackedScene, spawn_position: Vector2, spawn_rotation: float, user: Character, add_to_scene: bool = true) -> Projectile:
	var inst: Projectile = proj_scene.instantiate()
	inst.user = user
	inst.position = spawn_position
	inst.global_rotation = spawn_rotation
	if add_to_scene and Global.map:
		Global.map.add_child(inst)
	return inst

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
	
