extends State

func enter() -> void:
	($"../../AnimatedSprite2D" as AnimatedSprite2D).play("idle")
	($"../../SpawnSunTimer" as Timer).start()
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

func _on_spawn_sun_timer_timeout() -> void:
	emit_signal("finished", "SpawnSun")
