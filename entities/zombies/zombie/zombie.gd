extends Zombie

func _ready() -> void:
	health = Health.new(100, false)
	add_child(health)
	
	state_machine = $StateMachine as StateMachine
	animation = $AnimatedSprite2D as AnimatedSprite2D
	damage_area = $DamageOnTouchArea as DamageOnTouch
	
	print("生成僵尸:[%s]" % self)
	state_machine.start()

func _process(_delta: float) -> void:
	pass
