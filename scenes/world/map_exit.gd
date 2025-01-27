class_name MapExit extends Area2D

@export_category("Destination")
@export_file('*.tscn') var map_path: String = "res://scenes/world/maps/"
@export var entry_point: String = "start"

func _ready():
	body_entered.connect(switch_map)

func switch_map(body):
	Map.set_as_current_map(load(map_path), entry_point)
