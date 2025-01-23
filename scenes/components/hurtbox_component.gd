class_name Hurtbox extends Area2D

@export var health_component: HealthComponent

## 2D Node that will be animated while invincible
@export var visual_node: Node2D
## period of seconds after detection where hurtbox will ignore hitboxes (i-frames)
@export var invincibility_preiod: float

func _on_area_entered(hitbox: Hitbox):
	if hitbox is not Hitbox: return
	set_deferred('monitoring', false)
	
	health_component.current_health -= hitbox.damage
	var clr: Color = visual_node.modulate
	clr.a = 0.5
	visual_node.modulate = clr
	
	Util.wait(invincibility_preiod, func(): 
		clr.a = 1
		visual_node.modulate = clr
		monitoring = true
		)
