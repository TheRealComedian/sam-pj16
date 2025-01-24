class_name Direction extends Node

var direction: Util.DIRECTION
@export var rotating_node: Node2D
#var rotation: int:
	#get():
		#rotation = rotating_node.rotation
		#if rotation < 0:
			#rotation += 360
		#return rotation

signal changed_direction(new_direction: Util.DIRECTION)

func normalize_rotation(deg: int):
	if deg < 0:
		deg += 360
	if deg > 360:
		deg -= 360
	return deg

func is_between(low: int, num: int, high:int, count_euqal_to: bool = false) -> bool:
	if count_euqal_to:
		if num >= low and num <= high: return true
	else:
		if num > low and num < high: return true

	return false

func _physics_process(delta):
	update_direction()

func update_direction():
	var rotation = rotating_node.global_rotation_degrees
	rotation = normalize_rotation(rotation)
	var new_dir: Util.DIRECTION = direction
	match direction:
		Util.DIRECTION.RIGHT:
			#if rotation-360 < -45: new_dir = Util.DIRECTION.UP
			#if rotation > 45: new_dir = Util.DIRECTION.DOWN
			
			if normalize_rotation(rotation+90) < 45: new_dir = Util.DIRECTION.UP
			elif normalize_rotation(rotation+90) > 135: new_dir = Util.DIRECTION.DOWN
			
			else: return
		Util.DIRECTION.DOWN: 
			if is_between(45, rotation, 135, true): return
			elif rotation < 45: new_dir = Util.DIRECTION.RIGHT
			elif rotation > 135: new_dir = Util.DIRECTION.LEFT
		Util.DIRECTION.LEFT: 
			if is_between(135, rotation, 225, true): return
			elif rotation < 135: new_dir = Util.DIRECTION.DOWN
			elif rotation > 225: new_dir = Util.DIRECTION.UP
		Util.DIRECTION.UP: 
			if is_between(225, rotation, 315, true): return
			if rotation < 225: new_dir = Util.DIRECTION.LEFT
			elif rotation > 315: new_dir = Util.DIRECTION.RIGHT
	if new_dir != direction:
		direction = new_dir
		changed_direction.emit(new_dir)

# if right:			0
	# r < 315 = up 		
	# r > 45 = down		
# if down:			90
	# r < 45 = right 	
	# r > 135 = left 	
# if left:			180
	# r < 135 = down 	
	# r > 225 = up 		
# if up:			270
	# r 225 = left 	
	# r > 315 = right 	
