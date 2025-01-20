class_name Game extends Node2D
## The main scene of the project, within all 2D nodes will be added

@onready var cursor = $Cursor

func _ready():
	Global.game = self
	
	#NOTE: this may seem obsolete, but trust me having a separate global signal for the main scene's readiness prevents a lot of issues using the built in ready signal causes
	SignalBus.main_scene_ready.emit()

func _process(_delta):
	cursor.global_position = get_global_mouse_position()
