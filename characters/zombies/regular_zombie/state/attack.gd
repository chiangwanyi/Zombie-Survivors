extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var body: Zombie

func enter() -> void:
	body = owner as Zombie
	animated_sprite_2d.play("attack")

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	pass

func _exit_tree() -> void:
	pass

