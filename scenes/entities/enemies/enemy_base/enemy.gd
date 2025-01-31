class_name Enemy extends Character

@onready var FSM: FiniteStateMachine = $FiniteStateMachine
@export var detection_range: Area2D
@export var attack_range: Area2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@export var player_detected_state: String = 'Chase'

func _ready():
	(health_component as HealthComponent).health_changed.connect(health_changed)
	if animation!=null:
		animation.play('default')

func health_changed(_prev: int, new: int):
	if new == 0:
		FSM.force_update('Death')
		return
	hurtbox.invincible_period(1.5)
	
#REAPER
# idle (before fight) > intro (scripted animations)
# rest (moves to center of map and stops moving)
# melee (chases player)
# perching (moves to column)
# projectiles (fire projectiles in waves at player)
# summon (summons enemies)
