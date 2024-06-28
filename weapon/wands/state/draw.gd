extends State

var wand: Wand
var cast_group: Array[Spell]

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    print("%s 进入 Draw 状态" % wand.name)
    # 1. 如果【牌库】不为空，【弃牌库】为空，则表示为第1次施法
    #if not wand.deck.is_empty() and wand.discared.is_empty():
        ##TODO 标记回绕
        #pass
    
    if not wand.deck.is_empty():
        cast_group = draw_spell()
        # 牌库有法术，但是抽取失败，直接进入充能延迟
        if cast_group.is_empty(): 
            print("%s 本次抽取未抽取到法术，剩余energe[%f/%f]，进入充能冷却" % [wand.name, wand.energe, wand.max_energe])
            emit_signal("finished", "RechargeDelay")
        else:
            wand.cast_group_stack.push_front(cast_group)
            print("%s 本次抽取到法术:%s，剩余energe[%f/%f]，剩余desk:%d，准备【施法】" % [wand.name, cast_group, wand.energe, wand.max_energe, wand.deck.size()])
            emit_signal("finished", "Cast")
    else:
        print("%s 牌库为空，准备进入【充能延迟】" % [wand.name])
        emit_signal("finished", "RechargeDelay")


## 抽取法术
func draw_spell() -> Array[Spell]:
    var group: Array[Spell] = []
    
    # 定义本次抽取次数
    var draw = wand.max_cast
    # 暂存当前的剩余 energe
    var remaining_energe = wand.energe
    while draw > 0 and not wand.deck.is_empty():
        # 尝试从【牌库】中抽取一个法术
        var spell := wand.deck.pop_front() as Spell
        # 如果当前的剩余 energe 不足以施放当前抽取的法术
        if spell.energe_drain > remaining_energe:
            wand.discared.append(spell)
            break
        draw += spell.draw_num
        draw -= 1
        group.append(spell)
        
    return group

func exit() -> void:
    pass
    #print("%s 退出 Draw 状态" % wand.name)

func _exit_tree() -> void:
    pass

