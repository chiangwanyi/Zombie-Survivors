class_name DamageOnTouchAbility extends Ability

@export var atk: int = 10
@export var damage_self: bool = false


func _on_projectile_2d_area_entered(area: Area2D) -> void:
    if area.has_node(^"HealthAbility"):
        var target_health_ability := area.get_node(^"HealthAbility") as HealthAbility
        target_health_ability.take_damage(atk)
    if damage_self and owner.has_node(^"HealthAbility"):
        var self_health_ability := owner.get_node(^"HealthAbility") as HealthAbility
        self_health_ability.take_damage(atk)
