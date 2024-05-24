extends State

@onready var animation := $"../../AnimatedSprite2D" as AnimatedSprite2D

var body: RigidBody2D

func enter() -> void:
	body = owner as RigidBody2D
	body.freeze = false
	animation.scale = Vector2.ZERO

	body.apply_central_impulse(Vector2(0, -100).rotated(deg_to_rad([30, -30].pick_random())))
	var tween := create_tween()
	tween.tween_property(animation, "scale", Vector2(0.7, 0.7), 0.5)
	tween.finished.connect(func ():
		emit_signal("finished", "Idle"))
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

