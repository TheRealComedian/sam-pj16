class_name MapExit extends Area2D

@export_category("Destination")
@export var destination_map: PackedScene
@export var entry_point: String = "start"

func _ready():
	body_entered.connect(switch_map)

func switch_map(body):
	Map.set_as_current_map(destination_map, entry_point)
