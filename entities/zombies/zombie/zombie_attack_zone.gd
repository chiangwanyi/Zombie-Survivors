extends DamageOnTouch

func _ready() -> void:
	repeat_damage_over_time = true

func _on_area_entered(area: Area2D) -> void:
	var health_node = area.get_node_or_null("Health")
	var body = owner as Zombie
	
	if health_node != null and area == body.target_plant:
		collider_health = health_node as Health
		body.state_machine._change_state(&"attack")
