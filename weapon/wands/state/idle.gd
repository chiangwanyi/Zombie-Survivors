extends State

var wand: Wand

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    wand.wand_recharge_bar.visible = false
    wand.wand_recharge_bar.value = 0
    print("%s 进入 Idle 状态" % wand.name)

func update(_delta: float) -> void:
    if wand.trigger_pressed:
        print("%s 尝试施法，准备【抽取】法术" % wand.name)
        emit_signal("finished", "Draw")
        
func physics_update(delta: float) -> void:
    wand.recharge(delta)
    
func exit() -> void:
    pass
    #print("%s 退出 Idle 状态" % wand.name)

func _exit_tree() -> void:
    pass

