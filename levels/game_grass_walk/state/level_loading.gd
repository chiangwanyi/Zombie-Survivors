extends State

@onready var seed_chooser := $"../../HUD/SeedChooser" as SeedChooser
@onready var seed_bank := $"../../HUD/SeedBank" as SeedBank
@onready var animation := $"../../AnimationPlayer" as AnimationPlayer

func enter() -> void:
    print("Loding start...")
    seed_chooser.init()
    seed_bank.init(GameManager.levels[(owner as GameLevel).level_name]["initial_sun"])
    animation.play("level_loading")

func update(_delta: float) -> void:
    pass
    
func exit() -> void:
    print("Loading end.")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if not is_active():
        return
    if anim_name == "level_loading":
        emit_signal("finished", "LevelSelecting")
