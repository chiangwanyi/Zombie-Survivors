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


func _change_state(state_name: StringName) -> void :
	super._change_state(state_name)
