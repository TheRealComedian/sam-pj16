## BGM
## global node that controls the background music
extends AudioStreamPlayer

var combat_mode: bool = false:
	set(f):
		combat_mode = f
		if combat_mode: enable_combat_layer()
		elif !combat_mode: disable_combat_layer()

func enable_combat_layer():
	((stream as AudioStreamPlaylist).get_list_stream(0) as AudioStreamSynchronized).set_sync_stream_volume(1, 0)
func disable_combat_layer():
	((stream as AudioStreamPlaylist).get_list_stream(0) as AudioStreamSynchronized).set_sync_stream_volume(1, -60.0)

func _ready():
	play()
