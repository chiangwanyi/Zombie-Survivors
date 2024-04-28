extends StateMachine

@onready var idle = $Idle
@onready var stagger = $Stagger
@onready var die = $Die
@onready var attack = $Attack

func _ready() -> void:
	states_map = {
		&"idle": idle,
		&"stagger": stagger,
		&"die": die,
		&"attack": attack,
	}


func _change_state(state_name: StringName) -> void :
	super._change_state(state_name)
