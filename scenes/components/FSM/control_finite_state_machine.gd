@icon("res://assets/godot/icons/ControlFiniteStateMachine.png")
class_name ControlFiniteStateMachine extends Control
## System that keeps track of a state of something, keeping it to one state at a time.
## [br]
## `State` scenes are nested to it to define the states themselves [br]
## States switch with the `Transistioned` signal

## child `State` scene that is first active in the machine
@export var initial_state: ControlState

## from child State scene
## [br]
## keys are scene name in lowercase 
var states: Dictionary = {}
var current_state: ControlState

func _ready():
	# collect all child states and put them in the dictionary
	for child in get_children():
		if child is ControlState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			child.visible = false
			
	# check for initial state and use it if found
	if initial_state:
		initial_state.visible = initial_state.start_visible
		initial_state.enter()
		current_state = initial_state

# run the current state's update function in the game loop
func _process(delta):
	if current_state:
		current_state.update(delta)
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

# on state transition call
func on_child_transition(_old_state: ControlState, new_state_name: String):
	# ignore if new state is same as current
	#if old_state == current_state and current_state != initial_state: 
		#print("DUPLICATE STATE RETURN:")
		#print("old: %s; current: %s; initial: %s" % [old_state, current_state, initial_state])
		#return

	# find and verify new state
	var new_state: ControlState = states.get(new_state_name.to_lower())
	if !new_state: 
		return

	#NOTE: for some reason this is the only way to make godot remember that the exiting state exists and has exit code, otherwise it forgor 💀
	var exiting: ControlState = current_state
	var entering: ControlState = new_state
	# change current state to new one
	current_state = new_state
	
	# run exit code on current state if there was one previously
	exiting.visible = false
	exiting.exit()
	# run enter code on new state
	entering.visible = entering.start_visible
	entering.enter()
	
func force_update(new_state: String):
	current_state.Transitioned.emit(current_state, new_state)
