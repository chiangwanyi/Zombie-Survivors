extends State

var walk_animations := [&"walk1", &"walk2"]
var body : Zombie
var animation : AnimatedSprite2D

func enter() -> void:
	body = owner as Zombie
	animation = owner.get_node(^"AnimatedSprite2D") as AnimatedSprite2D
	
	animation.play(walk_animations.pick_random())
	super.enter()
	
func update(delta: float) -> void:
	if body.target_plant != null:
		var current_position : Vector2 = body.position
		var direction : Vector2 = (body.target_plant.position - current_position).normalized()
		var movement : Vector2 = direction * body.speed * delta
		body.position += movement
		if direction.x > 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		body.state_machine._change_state(&"idle")
