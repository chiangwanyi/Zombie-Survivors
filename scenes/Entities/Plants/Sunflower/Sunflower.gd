extends Node

func _ready() -> void:
	pass
	
func set_resource_time(t: float) -> void:
	($SpawnSunTimer as Timer).wait_time = t
