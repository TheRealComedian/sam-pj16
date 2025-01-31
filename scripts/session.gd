## Session 
## Store and manage data specific to the current game session here
extends Node

#var current_weapon: PackedScene = load('res://scenes/weapons/sword.tscn')
#var current_weapon: PackedScene = load('res://scenes/weapons/mace.tscn')
var current_weapon: PackedScene = load('res://scenes/weapons/bow.tscn')
#var current_weapon: PackedScene = load('res://scenes/weapons/scythe.tscn')
var last_hit_weapon: PackedScene = current_weapon
