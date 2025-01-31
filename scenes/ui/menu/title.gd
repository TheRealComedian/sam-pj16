## Title
## title screen seen when first opening the game 
extends ControlState
@onready var begin_btn: Button = $Button
@onready var revenant_menu = $RevenantMenu

@export var start_room: int = 1


#TODO: add title screen functionality once maps and player instancing are in place 
func _ready():
	begin_btn.grab_focus()
	begin_btn.pressed.connect(start)

func start():
	Global.transition.play('out')
	await Global.transition.animation_finished
	
	Transitioned.emit(self, 'Hidden')
	Map.set_as_current_map(load('res://scenes/world/maps/room_%s.tscn'%start_room), 'start', false)
	
	Global.transition.play('in')
	await Global.transition.animation_finished
	
	
