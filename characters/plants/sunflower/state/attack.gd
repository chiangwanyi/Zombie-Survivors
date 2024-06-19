extends State

@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $"../../HandleWeaponAbility"

func enter() -> void:
    pass
    # 打印当前时间
    #print("Attack:", Time.get_ticks_msec())
    #var tween := create_tween()
    #var material :=  ($"../../AnimatedSprite2D" as AnimatedSprite2D).material as ShaderMaterial
    #tween.tween_property(material, "shader_parameter/glow_power", 1.4, 1)
    #tween.tween_property(material, "shader_parameter/glow_power", 1, 1)
    #tween.tween_callback(func ():
        #emit_signal("finished", "Idle"))
    handle_weapon_ability.shoot_start()
