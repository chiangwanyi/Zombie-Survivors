extends State

func enter() -> void:
	var gp = (owner as RigidBody2D).position
	GameManager.current_level.remove_child(owner)
	GameManager.current_level.get_node("OverHUD").add_child(owner)
	# 将非CanvasLayer节点移动到CanvasLayer节点中，需要加上分辨率
	(owner as RigidBody2D).position = gp + Vector2(1920/2, 1080/2)
	
	#var tween := create_tween()
	#var tweener = tween.tween_property(owner, ^"position", Vector2(0, 0), 0.5)
	#tweener.set_ease(Tween.EASE_OUT)
	#tweener.set_trans(Tween.TRANS_QUART)
	#tween.finished.connect(func ():
		#owner.queue_free())
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

