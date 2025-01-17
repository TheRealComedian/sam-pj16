@icon("res://assets/godot/icons/State.png")
class_name State extends Node

## tells the state manager to transition from one state to another
## `old_state` (State) is the current state being switched from (should be `self`)
## `new_state_name` (String) is the new state's name, corresponding to the state's node name
@warning_ignore("unused_signal")
signal Transitioned


## overrideable method that runs once when the state is entered into
func enter():
	pass
## overrideable method that runs once when the state is transitioned away from
func exit():
	pass
	
## overrideable method that runs once every available frame (idle processing)
func update(_delta: float):
	pass
## overrideable method that runs 60 times every second (physics processing)
func physics_update(_delta: float):
	pass
