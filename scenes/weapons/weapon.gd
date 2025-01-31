class_name Weapon extends Node2D

@export var sprite: AnimatedSprite2D
@export var animation: AnimationPlayer
@export var disable_input: bool = false
@export var speed_modifier: float = 1

var user: Character

func _ready():
	if get_parent() is Character:
		self.user = get_parent()

## Async method called in the attack script
# override with any attack functionality like sprite/position changes or hitbox control
func attack():
	pass
	
