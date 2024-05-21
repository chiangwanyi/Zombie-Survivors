extends State
# 点击开始游戏，至游戏正式开始可以选择卡片的阶段

func enter() -> void:
	var tween := create_tween()
	tween.tween_property(owner, "modulate", Color8(150, 150, 150), 0.5)
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

