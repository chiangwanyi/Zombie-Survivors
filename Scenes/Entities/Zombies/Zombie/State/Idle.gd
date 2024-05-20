extends State

@onready var animation := $"../../AnimatedSprite2D" as AnimatedSprite2D

func enter() -> void:
	animation.play(["idle1", "idle2"].pick_random())
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

