extends State

var wand: Wand

var cast_delay: float
var ts: float

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    cast_delay = 0.0
    ts = 0.0
    print("%s 进入 CastDelay 状态，上次已施放【施法法术组】cast_group:%s" % [wand.name, wand.cast_group_stack[0]])
    for spell in wand.cast_group_stack[0]:
        cast_delay += spell.cast_delay
    print("%s 合计施法延迟【修正】\tcast_delay=%f+[%f]=%f" % [wand.name,
    wand.cast_delay, cast_delay, (wand.cast_delay + cast_delay)])
    cast_delay += wand.cast_delay

func physics_update(delta: float) -> void:
    if ts >= cast_delay:
        if wand.deck.is_empty():
            print("%s 施法延迟结束，牌库为空，进入充能冷却状态" % [wand.name])
            emit_signal("finished", "RechargeDelay")
        else:
            print("%s 施法延迟结束，先回到Idle状态" % [wand.name])
            emit_signal("finished", "Idle")
    ts += delta
    wand.recharge(delta)
    #print("%s 等待施法延迟...[%f/%f]" % [wand.name, ts, cast_delay])
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

