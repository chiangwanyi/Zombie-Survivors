extends State

var body: Zombie

func enter() -> void:
	body = owner as Zombie
	
	body.animation.play(&"eat")
	print("僵尸:[%s] 开始攻击 植物:[%s]" % [body, body.target_plant])
	super.enter()

func update(delta: float) -> void:
	# 进行攻击
	var damage_area := owner.get_node(^"DamageOnTouchArea") as DamageOnTouch
	damage_area.attack(delta)
