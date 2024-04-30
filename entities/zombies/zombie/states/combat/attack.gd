extends State

var body: Zombie
var animation : AnimatedSprite2D

func enter() -> void:
	body = owner as Zombie
	animation = owner.get_node(^"AnimatedSprite2D") as AnimatedSprite2D
	
	animation.play(&"eat")
	print("僵尸:[%s] 开始攻击 植物:[%s]" % [body, body.target_plant])
	super.enter()

func update(delta: float) -> void:
	if body.target_plant != null:
		# 进行攻击
		body.damage_area.attack(delta)
	else:
		emit_signal("finished", "idle")
