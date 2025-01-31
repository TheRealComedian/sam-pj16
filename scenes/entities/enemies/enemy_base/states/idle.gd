## Idle
## enemy is standing still
extends State

#func connect_singals():
	#owner.detection_range.body_entered.connect(player_detected)
#func disconnect_singals():
	#owner.detection_range.body_entered.disconnect(player_detected)

var start_checking: bool = false #HACK: bodies were detected on instancing, this will have to do

func enter():
	print("Idle")
	await Util.wait(0.05).timeout
	start_checking = true

func physics_update(delta: float):
	if not start_checking: return
	print((owner.detection_range as Area2D).get_overlapping_bodies())
	if Global.player in (owner.detection_range as Area2D).get_overlapping_bodies():
		Transitioned.emit(self, owner.player_detected_state)
		return
	

		#
	#await Util.wait(1).timeout
	#disconnect_singals()
	#Transitioned.emit(self, 'Wander')
#
#func player_detected(body):
	#pass
	#disconnect_singals()
	#Transitioned.emit(self, owner.player_detected_state)
