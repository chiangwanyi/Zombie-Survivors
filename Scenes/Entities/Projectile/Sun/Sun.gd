extends RigidBody2D

@onready var state_machine = $StateMachine as StateMachine

func _ready() -> void:
	state_machine.start()
	
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#state_machine._rigid_process(state)

