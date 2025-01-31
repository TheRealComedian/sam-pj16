class_name Reaper extends Boss

var map: Map

func _ready():
	map = get_parent()

var stamina: int = 3:
	set(value):
		stamina = clamp(value, 0, 3)

func decide_action() -> String:
	print("deciding... (stamina: %s)" % stamina)
	if stamina == 0:
		return 'Rest'
	var options = [
		#'Melee',
		'Projectile'
	]
	if stamina < 3:
		options.append('Rest')
	print("has enemies?: %s"%map.check_for_enemies())
	if !map.check_for_enemies(): 
		print('adding enemy option')
		options.append('Summon')
	return options.pick_random()

func get_perch_point() -> Vector2:
	return map.get_node('Columns').get_children().pick_random().global_position
func get_map_center() -> Vector2:
	return map.get_node('EntryPoints').get_child(0).global_position
func summon_enemy():
	var pos: Vector2 = map.get_node('Spawns').get_children().pick_random().global_position
	var enemy: Enemy = load([
		'res://scenes/entities/enemies/skeleton/Skeleton.tscn',
		'res://scenes/entities/enemies/zombie/zombie.tscn',
		'res://scenes/entities/enemies/ghost/ghost.tscn',
	].pick_random()).instantiate()
	map.add_child(enemy)
	enemy.position = pos

#REAPER
# idle (before fight) > intro (scripted animations)
# rest (moves to center of map and stops moving)
# melee (chases player)
# perching (moves to column)
# projectiles (fire projectiles in waves at player)
# summon (summons enemies)
