## Reaper: Rest
## take a break from actions allowing window for attack
extends State

func enter():
	print("rest")
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(owner, 'position', owner.get_map_center(), 0.3)
	await tween.finished
	
	#await Util.wait(randi_range(3, 5)).timeout
	await Util.wait(randi_range(1, 5)).timeout
	owner.stamina += 1
	print('done resting')
	
	var dec = owner.decide_action()
	if dec == "Rest": 
		enter()
	else: 
		Transitioned.emit(self, dec)
	return
func exit():
	pass
func physics_update(delta: float):
	pass
