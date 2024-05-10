extends Character2D

@onready var state_machine := $StateMachine as StateMachine

func _ready() -> void:
	state_machine.start()
