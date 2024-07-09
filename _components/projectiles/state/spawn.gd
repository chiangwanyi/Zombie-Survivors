extends State

func enter() -> void:
    pass
    
func update(_delta: float) -> void:
    emit_signal("finished", "Launch")

func exit() -> void:
    pass
