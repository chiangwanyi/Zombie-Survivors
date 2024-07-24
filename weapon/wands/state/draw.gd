extends State

var wand: Wand
var cast_group: Array

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    print("%s 进入 Draw 状态" % wand.name)
    # 1. 如果【牌库】不为空，【弃牌库】为空，则表示为第1次施法
    #if not wand.deck.is_empty() and wand.discared.is_empty():
        ##TODO 标记回绕
        #pass

    print("Discared:%s\tDeck:%s" % [wand.discared.map(get_spell_name), wand.deck.map(get_spell_name)]) 
    
    if not wand.deck.is_empty():
        cast_group = draw_spell()
        print("Discared:%s\tProjectils:%s\tDeck:%s" % [wand.discared.map(get_spell_name), cast_group.map(get_spell_name), wand.deck.map(get_spell_name)]) 
        ## 牌库有法术，但是抽取失败，直接进入充能延迟
        #if cast_group.is_empty(): 
            #print("%s 本次抽取未抽取到法术，剩余energe[%f/%f]，进入充能冷却" % [wand.name, wand.energe, wand.max_energe])
            #emit_signal("finished", "RechargeDelay")
        #else:
            #wand.cast_group_stack.push_front(cast_group)
            #print("%s 本次抽取到法术:%s，剩余energe[%f/%f]，剩余desk:%d，准备【施法】" % [wand.name, cast_group, wand.energe, wand.max_energe, wand.deck.size()])
            #emit_signal("finished", "Cast")
    else:
        print("%s 牌库为空，准备进入【充能延迟】" % [wand.name])
        emit_signal("finished", "RechargeDelay")


## 抽取法术
func draw_spell() -> Array:
    var draw := 1
    var remain_energe := wand.energe
    var projectile_spells = []
    var projectile_modifier_spells: Array[Spell] = []
    
    while draw > 0 and not wand.deck.is_empty():
        var spell := wand.deck.pop_front() as Spell
        if spell.energe_drain <= remain_energe:
            draw -= 1
            if spell.spell_type == Spell.SpellType.Multicast:
                draw += spell.draw_num
                wand.discared.append(spell)
            elif spell.spell_type == Spell.SpellType.ProjectileModifier:
                projectile_modifier_spells.append(spell)
                draw += spell.draw_num
                wand.discared.append(spell)
            elif spell.spell_type == Spell.SpellType.Projectile or spell.spell_type == Spell.SpellType.StaticProjectile:
                projectile_spells.append(spell)
                if spell.draw_num == 0:
                    draw += spell.draw_num
                    wand.discared.append(spell)
                else:
                    var sub_loop_draw := spell.draw_num
                    while sub_loop_draw > 0:
                        projectile_spells.append(draw_spell())
                        sub_loop_draw -= 1
                    wand.discared.append(spell)
        else:
            wand.discared.append(spell)

    for item in projectile_spells:
        if item is Spell:
            item.projectile_modifier_spells = projectile_modifier_spells

    return projectile_spells

func get_spell_name(value):
    if value is Spell:
        return value.spell_name
    elif value is Array:
        return value.map(get_spell_name)
    return "NONE"

