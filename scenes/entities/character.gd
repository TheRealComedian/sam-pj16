class_name Character extends CharacterBody2D
@export var mc: bool = false
@export var input_disabled: bool = false
@export var movement_speed: int = 300
const momentum = 1200
const friction = 600
@export var health_component: HealthComponent
@export var weapon: Weapon#:
	#set(value): 
		#weapon = value
		#weapon.user = self
