class_name HUD extends Control

@onready var health_bar: HealthBar = $HBoxContainer/HealthBar

func _enter_tree():
	Global.hud = self
