class_name Map extends Node2D

@onready var camera = $Camera
@onready var entry_points = $EntryPoints

func _ready():
	if Global.map: 
		self.queue_free()
		return
	Global.map = self
	Global.camera = self.camera

func check_for_enemies() -> bool:
	for child in get_children():
		if child is Reaper: continue
		if child is Enemy:
			return true
	return false

func _process(delta):
	if camera and Global.player and camera.enabled:
		camera.global_position = Global.player.global_position
	
	BGM.combat_mode = check_for_enemies()

func _exit_tree():
	Global.camera = null
	Global.map = null

enum ROOM {
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN
}

const map_1 = preload('res://scenes/world/maps/room_1.tscn')
const map_2 = preload('res://scenes/world/maps/room_2.tscn')
const map_3 = preload('res://scenes/world/maps/room_3.tscn')
const map_4 = preload('res://scenes/world/maps/room_4.tscn')
const map_5 = preload('res://scenes/world/maps/room_5.tscn')
const map_6 = preload('res://scenes/world/maps/room_6.tscn')
const map_7 = preload('res://scenes/world/maps/room_7.tscn')
const map_8 = preload('res://scenes/world/maps/room_8.tscn')
const map_9 = preload('res://scenes/world/maps/room_9.tscn')
const map_10 = preload('res://scenes/world/maps/room_10.tscn')

static func load_room(room: ROOM) -> PackedScene:
	match room:
		ROOM.ONE	: return map_1
		ROOM.TWO	: return map_2
		ROOM.THREE	: return map_3
		ROOM.FOUR	: return map_4
		ROOM.FIVE	: return map_5
		ROOM.SIX	: return map_6
		ROOM.SEVEN	: return map_7
		ROOM.EIGHT	: return map_8
		ROOM.NINE	: return map_9
		ROOM.TEN	: return map_10
	return map_1

static func set_as_current_map(map_resource: PackedScene, entry_point: String = 'start', do_transition: bool = true):

	# transition out
	if Global.player:
		Global.player.input_disabled = true
	
	if do_transition:
		Global.transition.play('out')
		await Global.transition.animation_finished

	
	# save player data
	pass #TODO: no player specific data implemented yet such as current weapon, powerups, etc.
	
	# remove map (and with it everything that checks for the player)
	if Global.map:
		Global.map.queue_free()
		await Global.map.tree_exited
	
	# remove player
	if Global.player:
		Global.player.queue_free()
		await Global.player.tree_exited
	
	# instance new map
	var new_map: Map = map_resource.instantiate()
	if map_resource.instantiate() is not Map: 
		push_error('map_resource "%s" does not unpack into a Map' % map_resource)
		return
	
	# add new map
	Global.game.add_child(new_map)
	
	# add player
	Global.game.add_child(Player.instance())
	Global.player.input_disabled = true
	
	# move player to entry point in map
	Global.player.global_position = new_map.entry_points.get_node(entry_point).global_position
	
	# transition in
	if do_transition:
		Global.transition.play('in')
		await Global.transition.animation_finished
	Global.player.input_disabled = false
