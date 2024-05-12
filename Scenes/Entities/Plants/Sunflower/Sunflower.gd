extends ResourcePlant

func _ready() -> void:
	state_machine = $StateMachine as StateMachine
	state_machine.start()
	
func set_resource_time(t: float) -> void:
	($SpawnSunTimer as Timer).wait_time = t
