class_name Scythe extends Weapon

@export var sprite: AnimatedSprite2D
@export var hitbox: CollisionShape2D

@export var projectile: PackedScene
@export var arrow_count: int = 5
@export_range(0,360) var arc: float=0
@export_range(0,20) var fire_rate: float=2.0

@onready var shoot_position := $CursorFacing

var weapon_timer = 0.0
var anim_duration = 0.6
var arrow_speed = 900
var warn=2
var warned=false
var melee=2

var can_shoot =true

@export_category("Animation Durations")
## time it takes for the active swipe animation, hitbox is active during this timeframe
@export var swipe_duration: float = 0.3
## time after swipe animation where action remains disabled before returning t idle state
@export var cooldown_duration: float = 1.0

var current_animation_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cancel_attack():
	#how do you cancel an arrow
	if owner.weapon.current_animation_tween:
		owner.weapon.current_animation_tween.kill()
		owner.weapon.hitbox.disabled = true


func attack():
	if melee>0:
		sprite.play('windup')
		await Util.wait(self.anim_duration).timeout
		current_animation_tween = get_tree().create_tween()
		current_animation_tween.tween_property(self, 'rotation', self.rotation-1.1, 0.1)
		await current_animation_tween.finished
		
		hitbox.disabled = false
		sprite.play('active')
		
		current_animation_tween = get_tree().create_tween()
		current_animation_tween.tween_property(self, 'rotation', self.rotation+2.1, swipe_duration)
		await current_animation_tween.finished
		
		hitbox.disabled = true
		sprite.play('idle')
		await Util.wait(self.cooldown_duration).timeout
		melee-=1
	else:
		if can_shoot:
			can_shoot=false
			for j in warn:
				for i in arrow_count:
					var new_arrow=projectile.instantiate()
					if warned==true:
						new_arrow.enable_layer()
					new_arrow.position=global_position
					#new_bullet.direction = global_position.direction_to(get_global_mouse_position())
					#print(global_position.direction_to(get_global_mouse_position()))
					#print(global_rotation)
					var arc_rad = deg_to_rad(arc)
					var increment=arc_rad/(arrow_count-1)
					new_arrow.global_rotation=(
						global_rotation + increment*i - arc_rad/2
					)
					#print(new_arrow.get_collision_layer_value(4))
					get_tree().root.call_deferred("add_child", new_arrow)
				warned=true
				await get_tree().create_timer(1/fire_rate).timeout
		await get_tree().create_timer(1/fire_rate).timeout
		warned=false
		can_shoot = true
		melee=2
