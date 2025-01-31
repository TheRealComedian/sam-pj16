class_name Scythe extends Weapon

@export var hitbox: CollisionShape2D

@export var projectile: PackedScene
@export var arrow_count: int = 5
@export_range(0,360) var arc: float=0
@export_range(0,20) var fire_rate: float=2.0

var warning_duration = 0.69
var weapon_timer = 0.0
var anim_duration = 0.69
var arrow_speed = 900
var warn=2
var warned=false
var melee=2

var can_shoot =true
@onready var animation_player := $AnimationPlayer
@export_category("Animation Durations")
## time it takes for the active swipe animation, hitbox is active during this timeframe
@export var swipe_duration: float = 0.2
## time after swipe animation where action remains disabled before returning t idle state
@export var cooldown_duration: float = 1.0

var current_animation_tween: Tween

func cancel_attack():
	animation_player.stop()
	animation_player.play('RESET')


func melee_attack(): 
	animation_player.play("slash")
	await animation_player.animation_finished
	
func projectile_attack():
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

func attack_tween():
	if current_animation_tween and current_animation_tween.is_running(): return
	print("ATTACK TWEEN")
	look_at(Global.player.global_position)
	current_animation_tween = get_tree().create_tween()
	current_animation_tween.tween_property(self, 'rotation', self.rotation-1.1, 0.1)
	await current_animation_tween.finished
	sprite.play('windup')
	await sprite.animation_finished
	await Util.wait(1).timeout
	
	hitbox.disabled = false
	sprite.play('active')
	#animation_player.play("slash")
	current_animation_tween = get_tree().create_tween()
	current_animation_tween.tween_property(self, 'rotation', self.rotation+3.8, swipe_duration)
	await current_animation_tween.finished
	
	hitbox.disabled = true
	sprite.play('inactive')
	await Util.wait(self.cooldown_duration).timeout

func attack():
	sprite.play('windup')
	await sprite.animation_finished
	
	sprite.play('active')
	
	projectile_attack()
	
	#if melee>0:
		#melee_attack()
		#melee-=1
		#
	#else:
		#if can_shoot:
			#can_shoot=false
			#for j in warn:
				#projectile_attack()
				#warned=true
				#await get_tree().create_timer(1/fire_rate).timeout
				#await Util.wait(self.warning_duration).timeout
		#await get_tree().create_timer(1/fire_rate).timeout
		#warned=false
		#can_shoot = true
		#melee=2
		
	sprite.play('inactive')
	await Util.wait(self.cooldown_duration).timeout
