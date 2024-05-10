extends StateMachine

@onready var s1 = $S1
@onready var s2 = $S2

func _ready() -> void:
	states_map = {
		&"s1": s1,
		&"s2": s2
	}
