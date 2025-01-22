## Util 
## Store utility methods and enums here
extends Node

## Pauses execution for a number of seconds before continueing
## e.g. 'await Util.wait(0.5).timeout' to act like sleep() in python; or 
## 'Util.wait(0.5, func(): print("Waited")) to act like timeout in javascript
func wait(time: float, on_timeout: Callable = func(): pass) -> Timer:
	var timer := Timer.new()
	Global.add_child(timer)
	timer.timeout.connect(func():
		on_timeout.call()
		timer.queue_free()
		)
	timer.start(time)
	return timer
