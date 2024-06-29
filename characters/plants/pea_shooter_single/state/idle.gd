extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"


func enter() -> void:
	head_animated_sprite_2d.play("idle")
	stem_animated_sprite_2d.play("default")

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	pass

func _exit_tree() -> void:
	pass

