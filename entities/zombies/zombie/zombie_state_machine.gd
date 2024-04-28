extends StateMachine

@onready var idle = $Idle
@onready var move = $Move
@onready var stagger = $Stagger
@onready var attack = $Attack

func _ready() -> void:
	states_map = {
		&"idle": idle,
		&"move": move,
		&"stagger": stagger,
		&"attack": attack,
	}

func _change_state(state_name: StringName) -> void:
	if not _active:
		return
	#if state_name in ["stagger", "jump", "attack"]:
		#states_stack.push_front(states_map[state_name])
	#if state_name == "jump" and current_state == move:
		#jump.initialize(move.speed, move.velocity)
	super._change_state(state_name)
