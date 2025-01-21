class_name Sword extends Weapon

@export var sprite: AnimatedSprite2D
@export var hitbox: CollisionShape2D

@export_category("Animation Durations")
## time it takes for the active swipe animation, hitbox is active during this timeframe
@export var swipe_duration: float = 0.3
## time after swipe animation where action remains disabled before returning t idle state
@export var cooldown_duration: float = 1.0

func attack():
	var animation_tween: Tween = get_tree().create_tween()
	animation_tween.tween_property(self, 'rotation', self.rotation-1.1, 0.1)
	await animation_tween.finished
	
	hitbox.disabled = false
	sprite.play('active')
	
	animation_tween = get_tree().create_tween()
	animation_tween.tween_property(self, 'rotation', self.rotation+2.1, swipe_duration)
	await animation_tween.finished
	
	hitbox.disabled = true
	sprite.play('inactive')
	await Util.wait(cooldown_duration).timeout
