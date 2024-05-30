extends State

@onready var animation := $"../../AnimationPlayer" as AnimationPlayer

func _ready() -> void:
	pass

func enter() -> void:
	animation.play("set_ready_plant")
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

func _exit_tree() -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not is_active():
		return
	if anim_name == "set_ready_plant":
		emit_signal("finished", "Playing")
