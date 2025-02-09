class_name Player extends Character

@onready var FSM: FiniteStateMachine = $FiniteStateMachine
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	if Global.player:
		self.queue_free()
		return 
	Global.player = self
	Global.hud.health_bar.connect_health(health_component)
	health_component.health_changed.connect(health_changed)

func health_changed(prev: float, new: float):
	if new == 0:
		FSM.force_update('Death')

static func instance(weapon: PackedScene = Session.current_weapon) -> Player:
	#TODO: add data when implemented
	var inst: Player = load('res://scenes/entities/player/player.tscn').instantiate()
	var weapon_inst: Weapon = weapon.instantiate()
	inst.add_child(weapon_inst)
	inst.weapon = weapon_inst
	Global.hud.set_weapon_icon(weapon_inst)
	return inst


var dash_available: bool = true
func dash():
	if !dash_available: return
	dashing = true
	dash_available = false
	set_collision_mask_value(3, false)
	await hurtbox.invincible_period(1)
	dashing = false
	set_collision_mask_value(3, true)
	await Util.wait(2).timeout
	dash_available = true

#func _input(event: InputEvent):
	#if input_disabled: return
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#input_disabled = true
		#await weapon.attack()
		#input_disabled = false
#
#func _physics_process(delta):
	#if weapon and !input_disabled:
			#weapon.look_at(Global.game.get_global_mouse_position())


func _exit_tree():
	Global.player = null
