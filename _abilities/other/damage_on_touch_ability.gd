class_name DamageOnTouchAbility extends Ability

@export var atk : int = 10

func _ready() -> void:
    pass # Replace with function body.


func _on_projectile_2d_area_entered(area: Area2D) -> void:
    if area.has_node(^"HealthAbility"):
        var health_ability := area.get_node(^"HealthAbility") as HealthAbility
        health_ability.take_damage(atk)
