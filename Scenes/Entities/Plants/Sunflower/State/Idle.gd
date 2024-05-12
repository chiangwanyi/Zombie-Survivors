extends State

func enter() -> void:
	($"../../AnimatedSprite2D" as AnimatedSprite2D).play("idle")
	($"../../PlantOnGrassAudioPlayer" as AudioStreamPlayer).play()
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

