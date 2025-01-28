class_name Bow extends Weapon

@export var sprite:AnimatedSprite2D
@export var projectile: PackedScene
@export var arrow_count: int = 5
@export_range(0,360) var arc: float=0
@export_range(0,20) var fire_rate: float=2.0

@onready var shoot_position := $CursorFacing
@export var cooldown_duration: float = 1.0

var can_shoot =true
var weapon_timer = 0.0
var anim_duration = 0.3
var arrow_speed = 900

func cancel_attack():
	#how do you cancel an arrow
	pass

func attack():
	sprite.play('shoot')
	await Util.wait(self.anim_duration).timeout
	for i in arrow_count:
		var new_arrow=projectile.instantiate()
		new_arrow.position=global_position
		if arrow_count==1:
			new_arrow.global_rotation=global_rotation
		else:
			var arc_rad = deg_to_rad(arc)
			var increment=arc_rad/(arrow_count-1)
			new_arrow.global_rotation=(
				global_rotation + increment*i - arc_rad/2
			)
		get_tree().root.call_deferred("add_child", new_arrow)
	await get_tree().create_timer(1/fire_rate).timeout
	sprite.play('idle')
	await Util.wait(self.cooldown_duration).timeout
	
