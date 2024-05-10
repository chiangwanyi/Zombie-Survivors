extends State

@onready var animation := $"../../AnimationPlayer" as AnimationPlayer
@onready var selecting_bg_player := $"../../SelectingBG" as AudioStreamPlayer

func enter() -> void:
	print("Selection Complete")
	animation.play("SelectionComplete")

	#animation.animation_finished.connect(exit.bindv())

	var tween := create_tween()
	tween.tween_property(selecting_bg_player, "volume_db", -80.0, 5)
	
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"SelectionComplete":
		emit_signal("finished", "Playing")
