extends Plant

func _ready() -> void:
	state_machine = $StateMachine as StateMachine
	state_machine.start()
