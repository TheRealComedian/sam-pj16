class_name Boss extends Enemy

func _ready():
	(health_component as HealthComponent).health_changed.connect(health_changed)
	if animation!=null:
		animation.play('default')

func health_changed(_prev: int, new: int):
	if new == 0:
		FSM.force_update('Death')
		#return
	#FSM.force_update('Hit')
