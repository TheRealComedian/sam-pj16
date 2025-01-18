@icon('res://assets/godot/icons/HealthComponent.png')
class_name HealthComponent extends Node

signal health_changed(prev: int, new: int)

@export var max_health: float = 5.0
@export var current_health: float = 5.0:
	set(value):
		value = clamp((round(value*4)/4), 0, max_health)
		health_changed.emit(current_health, value)
		current_health = value
