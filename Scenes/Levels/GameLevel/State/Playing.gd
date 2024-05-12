extends State

@onready var animation := $"../../AnimationPlayer" as AnimationPlayer
@onready var level_grasswalk_bg := $"../../LevelGrasswalkBG" as AudioStreamPlayer

func enter() -> void:
	print("Playing")
	animation.play("Ready")
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"Ready":
		GameEvent.trigger(GameEvent.Type.Playing)
		level_grasswalk_bg.play()
