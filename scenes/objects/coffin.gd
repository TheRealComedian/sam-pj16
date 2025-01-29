class_name Coffin extends StaticBody2D
# object for spawning enemies

@export var enemy: PackedScene
@export var opened: bool = false
@onready var sprite: AnimatedSprite2D = $Sprite

func _ready():
	if opened:
		sprite.play('open')
		return
	sprite.play('closed')

func open():
	if opened: return
	sprite.play('open')
	await sprite.animation_finished
	if enemy:
		var enemy_inst: Enemy = enemy.instantiate()
		Global.map.add_child(enemy_inst)
		enemy_inst.global_position = self.global_position
	opened = true

#FIXME: camera jitters a bit, player may be moving forward, when spawning sometimes?
