extends Plant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = Health.new(100, false)
	add_child(health)
	
	state_machine = $StateMachine as StateMachine
	
	print("生成植物:[%s]" % self)
	state_machine.start()

func _process(_delta: float) -> void:
	pass
