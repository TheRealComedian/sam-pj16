## Idle
## enemy is standing still
extends State

func enter():
	owner.detection_range.body_entered.connect(player_detected)
	print("Idle")
	if Global.player in (owner.detection_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, 'Chase')
		return
	await Util.wait(1).timeout
	Transitioned.emit(self, 'Wander')

func exit():
	owner.detection_range.body_entered.disconnect(player_detected)

func player_detected(body):
	Transitioned.emit(self, 'Chase')
