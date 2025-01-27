## Hit
## enemy has been hit and will be temporarily stunned
extends State

#TODO: allow hit state to override attack state animations propperly
func enter():
	await Util.wait(1).timeout
	Transitioned.emit(self, 'Idle')
