class_name Map extends Node2D

@onready var camera = $Camera
@onready var entry_points = $EntryPoints

func _ready():
	if Global.map: 
		self.queue_free()
		return
	Global.map = self
	Global.camera = self.camera

func _process(delta):
	if camera and Global.player and camera.enabled:
		camera.global_position = Global.player.global_position

func _exit_tree():
	Global.camera = null
	Global.map = null

static func set_as_current_map(map_resource: PackedScene, entry_point: String = 'start'):
	# transition out
	pass #TODO: add transitions
	
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
	if new_map is not Map: 
		push_error('map_resource "%s" does not unpack into a Map' % map_resource)
		return
	
	# add new map
	Global.game.add_child(new_map)
	
	# add player
	Global.game.add_child(Player.instance())
	
	# load player data
	pass #TODO: no player specific data implemented yet such as current weapon, powerups, etc.
	
	# move player to entry point in map
	Global.player.global_position = new_map.entry_points.get_node(entry_point).global_position
	
	# transition in
	pass #TODO: add transitions
