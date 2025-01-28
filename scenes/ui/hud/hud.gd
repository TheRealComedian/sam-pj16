class_name HUD extends Control

@onready var health_bar: HealthBar = $Health/HealthBar
@onready var weapon_rect = $PanelContainer/TextureRect

func _enter_tree():
	Global.hud = self
	
func set_weapon_icon(weapon: Weapon):
	var atlas: AtlasTexture = weapon_rect.texture
	if weapon is Sword:		atlas.region = Rect2(0*128, 0*128, 128, 128)
	if weapon is Mace:		atlas.region = Rect2(0*128, 1*128, 128, 128)
	if weapon is Bow:		atlas.region = Rect2(0*128, 2*128, 128, 128)
	if weapon is Scythe:	atlas.region = Rect2(0*128, 3*128, 128, 128)
