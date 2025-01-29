class_name Sword extends Weapon


@export var hitbox: Hitbox:
	set(value):
		hitbox = value
		hitbox_shape = hitbox.get_child(0)
var hitbox_shape: CollisionShape2D

@export_category("Animation Durations")
## time it takes for the active swipe animation, hitbox is active during this timeframe
@export var swipe_duration: float = 0.3
## time after swipe animation where action remains disabled before returning t idle state
@export var cooldown_duration: float = 1.0

var current_animation_tween: Tween
var anim_duration = 0.6

func cancel_attack():
	if owner.weapon.current_animation_tween:
		owner.weapon.current_animation_tween.kill()
		owner.weapon.hitbox_shape.disabled = true

func attack():
	sprite.play('windup')
	await Util.wait(self.anim_duration).timeout
	current_animation_tween = get_tree().create_tween()
	current_animation_tween.tween_property(self, 'rotation', self.rotation-1.1, 0.1)
	await current_animation_tween.finished
	
	hitbox_shape.disabled = false
	sprite.play('active')
	
	current_animation_tween = get_tree().create_tween()
	current_animation_tween.tween_property(self, 'rotation', self.rotation+2.1, swipe_duration)
	await current_animation_tween.finished
	
	hitbox_shape.disabled = true
	sprite.play('inactive')
	await Util.wait(self.cooldown_duration).timeout
