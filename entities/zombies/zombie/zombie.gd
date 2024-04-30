extends Zombie

func _ready() -> void:
	health = Health.new(100, false)
	add_child(health)
	
	state_machine = $StateMachine as StateMachine
	damage_area = $DamageOnTouchArea as DamageOnTouch

	print("生成僵尸:[%s]" % self)
	state_machine.start()

func _process(_delta: float) -> void:
	pass


func _on_damage_on_touch_area_area_entered(area: Area2D) -> void:
	var health_node = area.get_node_or_null("Health")
	
	if health_node != null and area == target_plant:
		# 普通僵尸只攻击提前标记的植物
		damage_area.collider_health = health_node as Health
		state_machine._change_state(&"attack")
