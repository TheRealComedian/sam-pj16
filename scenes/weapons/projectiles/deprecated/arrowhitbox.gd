class_name ArrowHitbox extends Hitbox

##damage := 20
#@onready var collision_shape := $CollisionShape2D
#
##  Disable the hitbox once it hits a target or wall
#func set_disabled(is_disabled: bool) -> void:
	#collision_shape.set_deferred("disabled", is_disabled)
	#
##  Disappears once the hitbox hits a target or wall
#func _on_body_entered(body):
	#queue_free()
	#pass
#
#func _on_visible_on_screen_enabler_2d_screen_exited():
	#queue_free()
	#pass
