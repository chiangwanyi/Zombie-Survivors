extends State

var wand: Wand
#var projectiles: Array[Projectile2D]

func _ready() -> void:
    pass

func enter() -> void:
    wand = owner as Wand
    var cast_group := wand.cast_group_stack.pop_front() as Array
    print("%s 进入 Cast 状态，当前待施放【施法法术组】:%s" % [wand.name, cast_group.map(Spell.get_spell_name)])

    for value in cast_group:
        if value is Spell:
            value.cast(wand.projectile_spawn.global_position, wand.weapon_aim_point.global_position, wand.FORCE)
    #     elif value is Array:
    # for spell in wand.cast_group_stack[0] as Array[Spell]:
    #     wand.energe -= spell.energe_drain
    #     if spell.spell_type == Spell.SpellType.Projectile:
    #         spell.cast(wand.projectile_spawn.global_position, wand.weapon_aim_point.global_position, wand.FORCE)
    #         #spell.cast(wand.projectile_spawn.global_position, wand.get_global_mouse_position(), wand.FORCE)
    # print("%s 本次施法完毕" % [wand.name])
    # if wand.deck.is_empty():
    emit_signal("finished", "RechargeDelay")
    # else:
    #     emit_signal("finished", "CastDelay")

func cast_spells(projectile_spawn_pos: Vector2, cast_group: Array) -> void:
    while not cast_group.is_empty():
        var value = cast_group.pop_front()
        if value is Spell:
            for modifier_spell in value.projectile_modifier_spells:
                pass
            if value.draw_num != 0:
                if not cast_group.is_empty():
                    var cast_group_on_hit = cast_group.pop_front()
            value.cast(projectile_spawn_pos, wand.weapon_aim_point.global_position)
            