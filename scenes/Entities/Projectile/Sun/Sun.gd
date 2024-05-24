extends RigidBody2D

@onready var state_machine = $StateMachine as StateMachine

var picked_flag := false

func _ready() -> void:
	state_machine.start()
	
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#state_machine._rigid_process(state)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and not picked_flag:
			state_machine.change_state("Pick")
