extends State

var head_animation: AnimatedSprite2D
var stem_animation: AnimatedSprite2D

var plant : Plant

var need_exit := false

# 每一个动画周期内的攻击次数
var attacks_per_animation_cycle := 1
# 当前动画周期内剩余的攻击次数
var remaining_attack_count := attacks_per_animation_cycle

func enter():
	head_animation = owner.get_node(^"HeadAnimation") as AnimatedSprite2D
	stem_animation = owner.get_node(^"StemAnimation") as AnimatedSprite2D
	plant = owner as Plant
	
	remaining_attack_count = attacks_per_animation_cycle
	
	head_animation.play(&"shoot")
	stem_animation.play(&"shoot")
	
	print("植物 attack 进入")
	super.enter()

func update(_delta: float) -> void:
	if not head_animation.is_playing() and not need_exit:
		remaining_attack_count = attacks_per_animation_cycle
		head_animation.play()

	if not stem_animation.is_playing() and not need_exit:
		stem_animation.play()
	
	if plant.target_zombie != null:
		# 豌豆射手在攻击动画的第13帧开火
		if head_animation.animation == &"shoot" and head_animation.frame == 13 and remaining_attack_count > 0:
			for weapon in plant.projectile_weapons:
				weapon.weapon_use(GameManager.level.to_local(weapon.spawn_position).direction_to(plant.target_zombie.position))
			remaining_attack_count -= 1
		
		if (plant.target_zombie.position - plant.position).x < 0:
			head_animation.flip_h = true
			stem_animation.flip_h = true
		else:
			head_animation.flip_h = false
			stem_animation.flip_h = false
	else:
		emit_signal("finished", "idle")
	
func exit() -> void:
	need_exit = true
	await head_animation.animation_finished
	await stem_animation.animation_finished
	super.exit()
