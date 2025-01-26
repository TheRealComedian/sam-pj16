class_name TransitionButton extends Button

## The CFSM root from which the transition is forced
@export var parent_CFSM: ControlFiniteStateMachine
## State the button will transition to when pressed
@export var target_state: ControlState

var before_transition: Callable = func(): pass
var after_transition: Callable = func(): pass

func _ready():
	pressed.connect(transition)

func transition():
	before_transition.call()
	parent_CFSM.force_update(target_state.name)
	after_transition.call()
