class_name Arrow
extends Node2D

@export var speed := 1000.0
@export var lifetime := .6

var direction:=Vector2.ZERO

@onready var timer := $Timer
@onready var hitbox := $Hitbox
@onready var sprite := $Sprite2D
@onready var impact_detector := $ImpactDetector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	look_at(position+direction)
	timer.timeout.connect(queue_free)
	timer.start(lifetime)
	impact_detector.body_entered.connect(_on_impact)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_impact(_body: Node) -> void:	
	queue_free()
