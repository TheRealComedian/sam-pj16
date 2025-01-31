## Reaper: Summon
## summon enemies in arena
extends State

func enter():
	print("summon")
	for i in range(randi_range(1, 2)):
		owner.summon_enemy()
		await Util.wait(1.5).timeout
	owner.stamina -= 1
	var dec = owner.decide_action()
	if dec == "Summon": 
		enter()
	else: 
		Transitioned.emit(self, dec)
	return
func exit():
	pass
func physics_update(delta: float):
	pass
