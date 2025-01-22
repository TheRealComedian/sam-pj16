extends Area2D

@export var damage := 20
@onready var collision_shape := $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_disabled(is_disabled: bool) -> void:
	collision_shape.set_deferred("disabled", is_disabled)
	
func _on_body_entered(body):
	queue_free()
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	pass
