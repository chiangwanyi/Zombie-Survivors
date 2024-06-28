extends State

var wand: Wand

var recharge_delay: float
var ts: float

func _ready() -> void:
    pass
    
func enter() -> void:
    wand = owner as Wand
    wand.wand_recharge_bar.visible = true
    recharge_delay = 0.0
    ts = 0.0
    for cast_group in wand.cast_group_stack:
        for spell in cast_group as Array[Spell]:
            recharge_delay += spell.recharge_time
    recharge_delay += wand.recharge_time
    print("%s 进入 RechargeDelay 状态，本轮所有施法组：%s，总计recharge_delay:%f" % [wand.name, wand.cast_group_stack, recharge_delay])
    

func physics_update(delta: float) -> void:
    if ts >= recharge_delay:
        print("%s 充能延迟结束" % [wand.name])
        wand.reload()
        emit_signal("finished", "Idle")
    else:
        ts += delta
        wand.wand_recharge_bar.value = lerp(0, 100, ts / recharge_delay)
        #print("%s 等待充能延迟...[%f/%f]" % [wand.name, ts, recharge_delay])
        wand.recharge(delta)
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

