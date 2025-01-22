class_name Hurtbox extends Area2D

@export var health_component: HealthComponent


func _on_area_entered(hitbox: Hitbox):
	if hitbox is not Hitbox: return
	
	health_component.current_health -= hitbox.damage
