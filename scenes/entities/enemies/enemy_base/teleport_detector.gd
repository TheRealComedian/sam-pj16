extends Area2D

@onready var FSM: FiniteStateMachine = $FiniteStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_entered() -> void:
	#FSM.force_update('Teleport')
	pass
