class_name MapExit extends Area2D

@export_category("Destination")
@export var destination_room: Map.ROOM
@export var entry_point: String = "start"

func _ready():
	body_entered.connect(switch_map)

func switch_map(body):
	Map.set_as_current_map(Map.load_room(destination_room), entry_point)
