## Hit
## enemy has been hit and will be temporarily stunned
extends State

#TODO: allow hit state to override attack state animations propperly
func enter():
	owner.hurtbox.get_child(0).disabled = true
	await Util.wait(1).timeout
	owner.hurtbox.get_child(0).disabled = false
	Transitioned.emit(self, 'Idle')
