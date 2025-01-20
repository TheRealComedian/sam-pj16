class_name Weapon extends Node2D

@onready var FSM: FiniteStateMachine = $FiniteStateMachine

## Async method called in the attack script
# override with any attack functionality like sprite/position changes or hitbox control
func attack():
	pass
