extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var body: Zombie
var linera_direction: Vector2

func enter() -> void:
	body = owner as Zombie
	animated_sprite_2d.play(["walk1", "walk2"].pick_random())
	
	if body.target_plant:
		linera_direction = body.global_position.direction_to(body.target_plant.global_position)

func physics_update(delta: float) -> void:
	if body.target_plant:
		# 始终面向 target_plant
		if body.target_plant.global_position.x > body.global_position.x:
			body.scale.x = -1
		else:
			body.scale.x = 1
		# 向 target_plant 移动
		body.position += (linera_direction * body.speed * delta)
	else:
		emit_signal("finished", "Idle")
	
func exit() -> void:
	pass

func _exit_tree() -> void:
	pass

