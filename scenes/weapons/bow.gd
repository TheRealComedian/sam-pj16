class_name Bow extends Weapon

@export var projectile: PackedScene
@export var arrow_count: int = 5
@export_range(0,360) var arc: float=0
@export_range(0,20) var fire_rate: float=2.0

@onready var shoot_position := $CursorFacing
@export var cooldown_duration: float = 1.0

var can_shoot = true
var weapon_timer = 0.0
var anim_duration = 0.3
var arrow_speed = 900

func cancel_attack():
	#how do you cancel an arrow
	pass

#func spawn_projectile(origin: Vector2) -> Projectile:
	#var new_arrow=projectile.instantiate()

# custom for ghost cause might as well
func draw_tween():
	sprite.play('windup')
	await sprite.animation_finished
func shoot_tween():
	sprite.play('winddown')
	if arrow_count == 1:
		Projectile.spawn_projectile(
			projectile, 
			self.global_position, 
			self.global_rotation,
			self.user
		)
	else:
		for i in arrow_count:
			var arc_rad = deg_to_rad(arc)
			var increment=arc_rad/(arrow_count-1)
			Projectile.spawn_projectile(
				projectile, 
				self.global_position, 
				global_rotation + increment*i - arc_rad/2,
				self.user
			)
		
	await get_tree().create_timer(1/fire_rate).timeout
	
	sprite.play('inactive')
	await Util.wait(self.cooldown_duration).timeout

func attack():
	sprite.play('windup')
	await sprite.animation_finished
	
	sprite.play('winddown')
	if arrow_count == 1:
		Projectile.spawn_projectile(
			projectile, 
			self.global_position, 
			self.global_rotation,
			self.user
		)
	else:
		for i in arrow_count:
			var arc_rad = deg_to_rad(arc)
			var increment=arc_rad/(arrow_count-1)
			Projectile.spawn_projectile(
				projectile, 
				self.global_position, 
				global_rotation + increment*i - arc_rad/2,
				self.user
			)
		
	await get_tree().create_timer(1/fire_rate).timeout
	
	sprite.play('inactive')
	#await Util.wait(self.coolsdown_duration).timeout
	
