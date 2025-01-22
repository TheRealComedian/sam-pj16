class_name Enemy extends Character

@onready var FSM: FiniteStateMachine = $FiniteStateMachine
@export var detection_range: Area2D
@export var attack_range: Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	(health_component as HealthComponent).health_changed.connect(health_changed)

func health_changed(_prev: int, new: int):
	if new == 0:
		FSM.force_update('Death')
		return
	FSM.force_update('Hit')
	
## Idle
## Wander
## Chase
## Reposition
## Attack
## Death
