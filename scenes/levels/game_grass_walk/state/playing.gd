extends State

func enter() -> void:
	print("Playing")
	($"../../BgmGameGrasswalk" as AudioStreamPlayer).play()
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()
