class_name Hurtbox extends Area2D

@export var health_component: HealthComponent

## 2D Node that will be animated while invincible
@export var visual_node: Node2D
## period of seconds after detection where hurtbox will ignore hitboxes (i-frames)
@export var invincibility_preiod: float


func _on_area_entered(hitbox: Hitbox):
	if hitbox is not Hitbox: return
	
	if owner is Character and hitbox.owner is Weapon or hitbox.owner is Projectile:
		if owner == hitbox.owner.user: return
	
	#HACK: this is really messy, but it'll work for the jam
	if owner is Player:
		if hitbox.owner is Sword:	Session.last_hit_weapon = load('res://scenes/weapons/sword.tscn')
		elif hitbox.owner.user.weapon is Bow:	Session.last_hit_weapon = load('res://scenes/weapons/bow.tscn')
		elif hitbox.owner is Mace:	Session.last_hit_weapon = load('res://scenes/weapons/mace.tscn')
		elif hitbox.owner is Scythe:	Session.last_hit_weapon = load('res://scenes/weapons/scythePlayer.tscn')
	
	set_deferred('monitoring', false)
	
	health_component.current_health -= hitbox.damage
	var clr: Color = visual_node.modulate
	clr.a = 0.5
	visual_node.modulate = clr
	
	await Util.wait(invincibility_preiod).timeout
	clr.a = 1
	visual_node.modulate = clr
	monitoring = true
