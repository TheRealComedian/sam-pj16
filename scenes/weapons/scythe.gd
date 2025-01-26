class_name Scythe extends Weapon

@export var bullet: PackedScene
@export var bullet_count: int = 5
@export_range(0,360) var arc: float=0
@export_range(0,20) var fire_rate: float=2.0

@onready var shoot_position := $CursorFacing
@export var cooldown_duration: float = 0.69

var weapon_timer = 0.0
var anim_duration = 0.5
var arrow_speed = 900

var can_shoot =true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cancel_attack():
	#how do you cancel an arrow
	pass


func attack():
	if can_shoot:
		can_shoot=false
		for i in bullet_count:
			var new_bullet=bullet.instantiate()
			new_bullet.position=global_position
			#new_bullet.direction = global_position.direction_to(get_global_mouse_position())
			#print(global_position.direction_to(get_global_mouse_position()))
			#print(global_rotation)
			var arc_rad = deg_to_rad(arc)
			var increment=arc_rad/(bullet_count-1)
			new_bullet.global_rotation=(
				global_rotation + increment*i - arc_rad/2
			)
			get_tree().root.call_deferred("add_child", new_bullet)
	await get_tree().create_timer(1/fire_rate).timeout
	can_shoot = true
