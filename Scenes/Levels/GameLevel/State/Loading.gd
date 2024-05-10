extends State

@onready var animation := $"../../AnimationPlayer" as AnimationPlayer

func enter() -> void:
	print("Loding...")
	animation.play("Loading")
	super.enter()

func update(_delta: float) -> void:
	if not animation.is_playing():
		emit_signal("finished", "Selecting")
	
func exit() -> void:
	super.exit()

