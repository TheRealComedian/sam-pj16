## Game Over
## shown on player death
extends ControlState

@onready var continue_button: Button = $Button

func _ready():
	continue_button.pressed.connect(continue_game)

func enter():
	Global.map.queue_free()
	continue_button.grab_focus()

func continue_game():
	Session.current_weapon = Session.last_hit_weapon
	Map.set_as_current_map(load('res://scenes/world/maps/crypt_vertical.tscn'))
	Transitioned.emit(self, 'Hidden')
