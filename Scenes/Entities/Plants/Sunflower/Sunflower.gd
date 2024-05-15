extends ResourcePlant

func _ready() -> void:
	state_machine = $StateMachine as StateMachine
	($PlantOnGrassAudioPlayer as AudioStreamPlayer).play()
	state_machine.start()
	
func set_resource_time(t: float) -> void:
	($SpawnSunTimer as Timer).wait_time = t
