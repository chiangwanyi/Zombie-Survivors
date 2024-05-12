extends State

func enter() -> void:
	var tween := create_tween()
	tween.tween_property(owner, "modulate", Color8(150, 150, 150), 0.5)
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

