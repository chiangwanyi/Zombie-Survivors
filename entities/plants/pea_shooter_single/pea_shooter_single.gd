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


func _on_shoot_area_area_entered(area: Area2D) -> void:
	if area is Zombie and target_zombie == null:
		target_zombie = area as Zombie
		print("僵尸:[%s] 进入 植物:[%s]攻击范围" % [target_zombie, self])
		state_machine._change_state(&"attack")
