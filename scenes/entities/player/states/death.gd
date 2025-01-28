## Death
## player has deleted health
extends State

func enter(): 
	Global.game.menu.force_update('GameOver')
func exit(): pass
func physics_update(delta: float): pass
