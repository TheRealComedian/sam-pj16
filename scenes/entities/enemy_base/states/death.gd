## Death
## enemy health depleted, playing death animation before freeing
extends State

func enter():
	owner.queue_free()
