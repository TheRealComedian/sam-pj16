class_name Reaper extends Boss

var map: Map

func _ready():
	map = get_parent()


var stamina: int = 3:
	set(value):
		stamina = clamp(value, 0, 3)

func decide_action() -> String:
	if stamina == 0:
		return 'Rest'
	var options = [
		'Melee',
		'Projectile'
	]
	if stamina < 3:
		options.append('Rest')
	if !map.check_for_enemies(): options.append('Summon')
	return options.pick_random()

func get_perch_point() -> Vector2:
	return map.get_node('Columns').get_child(randi_range(0,4)).global_position

#REAPER
# idle (before fight) > intro (scripted animations)
# rest (moves to center of map and stops moving)
# melee (chases player)
# perching (moves to column)
# projectiles (fire projectiles in waves at player)
# summon (summons enemies)
