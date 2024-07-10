class_name DamageOnTouchAbility extends Ability

@export var atk: int = 10
@export var damage_self: bool = false

func damage(area_list: Array[Area2D]):
    var self_atk_total := 0
    
    for area in area_list:
        if area.has_node(^"HealthAbility"):
            var target_health_ability := area.get_node(^"HealthAbility") as HealthAbility
            target_health_ability.take_damage(atk)
            self_atk_total += atk
            
    if damage_self and owner.has_node(^"HealthAbility"):
        var self_health_ability := owner.get_node(^"HealthAbility") as HealthAbility
        self_health_ability.take_damage(self_atk_total)        
    
