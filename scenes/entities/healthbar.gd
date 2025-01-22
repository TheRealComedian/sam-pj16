class_name HealthBar extends ProgressBar
#NOTE: this will likely be iterated on or replaced but it's fine for now to show health

@export var health_component: HealthComponent

func _ready():
	if !health_component: return
	connect_health(health_component)
	
func connect_health(health: HealthComponent):
	self.max_value = health.max_health
	self.value = health.current_health
	health.health_changed.connect(update_health_gui)
	

func update_health_gui(_prev: float, new: float):
	self.value = new
