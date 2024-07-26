extends State

var wand: Wand
#var projectiles: Array[Projectile2D]

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    print("%s 进入 Cast 状态，当前待施放【施法法术组】:%s" % [wand.name, wand.cast_group_stack])
    # for spell in wand.cast_group_stack[0] as Array[Spell]:
    #     wand.energe -= spell.energe_drain
    #     if spell.spell_type == Spell.SpellType.Projectile:
    #         spell.cast(wand.projectile_spawn.global_position, wand.weapon_aim_point.global_position, wand.FORCE)
    #         #spell.cast(wand.projectile_spawn.global_position, wand.get_global_mouse_position(), wand.FORCE)
    # print("%s 本次施法完毕" % [wand.name])
    # if wand.deck.is_empty():
    #     emit_signal("finished", "RechargeDelay")
    # else:
    #     emit_signal("finished", "CastDelay")
