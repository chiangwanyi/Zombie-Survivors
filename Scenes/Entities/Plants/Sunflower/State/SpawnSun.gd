extends State

func enter() -> void:
	var light := $"../../PointLight2D" as PointLight2D
	var tween := create_tween()
	tween.tween_property(light, "energy", 1, 1)
	tween.tween_property(light, "energy", 0, 1)
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

