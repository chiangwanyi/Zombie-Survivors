extends State

var body: RigidBody2D

func enter() -> void:
	body = owner as RigidBody2D
	body.freeze = true
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

