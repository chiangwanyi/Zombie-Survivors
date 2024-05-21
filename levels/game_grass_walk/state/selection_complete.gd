extends State

@onready var animation := $"../../AnimationPlayer" as AnimationPlayer

func enter() -> void:
	print("Selection Complete")
	animation.play("selection_complete")

	var tween := create_tween()
	tween.tween_property(($"../../BgmSelecting" as AudioStreamPlayer), "volume_db", -80.0, 5)
	
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not is_active():
		return
	if anim_name == "selection_complete":
		emit_signal("finished", "SetReadyPlant")
