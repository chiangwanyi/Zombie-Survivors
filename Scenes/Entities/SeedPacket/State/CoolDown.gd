extends State

var progress: TextureProgressBar

func enter() -> void:
	progress = $"../../CoolDownProgress" as TextureProgressBar
	progress.visible = true
	progress.value = 100
	
	var seed_packet := owner as SeedPacket
	seed_packet.modulate = Color8(150, 150, 150)
	
	var tween := create_tween()
	tween.tween_property(progress, "value", 0, seed_packet.cooldown)
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	progress.visible = false
	progress.value = 100
	super.exit()

func _on_cool_down_progress_value_changed(value: float) -> void:
	if value == 0:
		emit_signal("finished", "Ready")
